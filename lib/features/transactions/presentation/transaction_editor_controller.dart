import 'package:decimal/decimal.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/exchange_rate.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_input.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/currencies/data/drift_exchange_rate_repository.dart';
import 'package:flossi/features/currencies/domain/exchange_rate_repository.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/transactions/data/transaction_repository.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'transaction_editor_controller.g.dart';

enum RateStatus { ready, loading, missing }

@immutable
class TransactionEditorState {
  const TransactionEditorState({
    required this.home,
    required this.type,
    required this.input,
    required this.date,
    required this.paymentMethod,
    required this.rateStatus,
    this.original,
    this.categoryId,
    this.title = '',
    this.note = '',
    this.rate,
    this.saving = false,
  });

  final Currency home;

  /// Set when editing an existing transaction.
  final TransactionRecord? original;
  final TransactionType type;
  final MoneyInput input;
  final String? categoryId;
  final DateTime date;
  final PaymentMethod paymentMethod;
  final String title;
  final String note;
  final RateQuote? rate;
  final RateStatus rateStatus;
  final bool saving;

  bool get isEditing => original != null;
  Currency get currency => input.currency;
  Money get amount => input.toMoney();
  bool get needsConversion => currency.code != home.code;

  /// Live preview in the home currency (null while no rate is known).
  Money? get converted => rate?.rate.convert(amount);

  bool get canSave =>
      !saving && amount.isPositive && categoryId != null && rateStatus == RateStatus.ready && rate != null;

  TransactionEditorState copyWith({
    TransactionType? type,
    MoneyInput? input,
    String? Function()? categoryId,
    DateTime? date,
    PaymentMethod? paymentMethod,
    String? title,
    String? note,
    RateQuote? Function()? rate,
    RateStatus? rateStatus,
    bool? saving,
  }) => TransactionEditorState(
    home: home,
    original: original,
    type: type ?? this.type,
    input: input ?? this.input,
    categoryId: categoryId == null ? this.categoryId : categoryId(),
    date: date ?? this.date,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    title: title ?? this.title,
    note: note ?? this.note,
    rate: rate == null ? this.rate : rate(),
    rateStatus: rateStatus ?? this.rateStatus,
    saving: saving ?? this.saving,
  );
}

/// Drives the Add / Edit transaction screen. [transactionId] null = new.
@riverpod
class TransactionEditor extends _$TransactionEditor {
  static const _uuid = Uuid();

  ExchangeRateRepository get _rates => ref.read(exchangeRateRepositoryProvider);

  @override
  Future<TransactionEditorState> build(String? transactionId) async {
    final home = ref.read(homeCurrencyProvider);
    final now = ref.read(clockProvider).now();

    if (transactionId != null) {
      final t = await ref.read(transactionRepositoryProvider).get(transactionId);
      if (t != null) {
        // Same currency pair as when recorded: keep the frozen rate.
        final keepFrozen = t.homeCurrency.code == home.code;
        final base = TransactionEditorState(
          home: home,
          original: t,
          type: t.type,
          input: MoneyInput.fromMoney(t.amount),
          categoryId: t.categoryId,
          date: t.date,
          paymentMethod: t.paymentMethod,
          title: t.title ?? '',
          note: t.note ?? '',
          rateStatus: keepFrozen ? RateStatus.ready : RateStatus.loading,
          rate: keepFrozen ? _frozenQuote(t) : null,
        );
        return keepFrozen ? base : await _withResolvedRate(base);
      }
    }

    final categories = await ref.read(categoryRepositoryProvider).active(CategoryKind.expense);
    return TransactionEditorState(
      home: home,
      type: TransactionType.expense,
      input: MoneyInput.empty(home),
      categoryId: categories.firstOrNull?.id,
      date: now,
      paymentMethod: PaymentMethod.card,
      rateStatus: RateStatus.ready,
      rate: RateQuote(rate: ExchangeRate.identity(home), fetchedAt: now, isManual: false),
    );
  }

  TransactionEditorState get _s => state.requireValue;
  void _set(TransactionEditorState s) => state = AsyncData(s);

  void appendDigit(int d) => _set(_s.copyWith(input: _s.input.appendDigit(d)));
  void appendDecimal() => _set(_s.copyWith(input: _s.input.appendDecimalSeparator()));
  void backspace() => _set(_s.copyWith(input: _s.input.backspace()));
  void clearAmount() => _set(_s.copyWith(input: _s.input.clear()));
  void setTitle(String v) => _set(_s.copyWith(title: v));
  void setNote(String v) => _set(_s.copyWith(note: v));
  void setPaymentMethod(PaymentMethod m) => _set(_s.copyWith(paymentMethod: m));
  void setCategory(String id) => _set(_s.copyWith(categoryId: () => id));

  /// Keeps the time of day so entries on the same day stay ordered.
  void setDay(DateTime day) {
    final d = _s.date;
    _set(_s.copyWith(date: DateTime(day.year, day.month, day.day, d.hour, d.minute, d.second)));
  }

  Future<void> setType(TransactionType type) async {
    if (type == _s.type) return;
    final kind = type == TransactionType.expense ? CategoryKind.expense : CategoryKind.income;
    final categories = await ref.read(categoryRepositoryProvider).active(kind);
    final keep = categories.any((c) => c.id == _s.categoryId);
    _set(_s.copyWith(type: type, categoryId: keep ? null : () => categories.firstOrNull?.id));
  }

  Future<void> setCurrency(Currency currency) async {
    if (currency == _s.currency) return;
    final next = _s.copyWith(input: _s.input.withCurrency(currency), rateStatus: RateStatus.loading, rate: () => null);
    _set(next);
    _set(await _withResolvedRate(next));
  }

  /// Saves a user-entered rate `1 currency = rate home` and applies it.
  Future<void> saveManualRate(Decimal rate) async {
    final quote = await _rates.saveManualRate(_s.currency.code, _s.home.code, rate);
    _set(_s.copyWith(rate: () => quote, rateStatus: RateStatus.ready));
  }

  Future<TransactionEditorState> _withResolvedRate(TransactionEditorState s) async {
    final original = s.original;
    if (original != null &&
        original.currency == s.currency &&
        original.homeCurrency.code == s.home.code) {
      return s.copyWith(rate: () => _frozenQuote(original), rateStatus: RateStatus.ready);
    }
    final quote = await _rates.findRate(s.currency.code, s.home.code, at: s.isEditing ? s.date : null);
    return s.copyWith(rate: () => quote, rateStatus: quote == null ? RateStatus.missing : RateStatus.ready);
  }

  RateQuote _frozenQuote(TransactionRecord t) => RateQuote(
    rate: ExchangeRate(from: t.currency, to: t.homeCurrency, rate: t.fxRate),
    fetchedAt: t.date,
    isManual: t.rateSource == RateSource.manual,
  );

  /// Persists the transaction and returns it (null if not savable).
  Future<TransactionRecord?> save() async {
    final s = _s;
    if (!s.canSave) return null;
    _set(s.copyWith(saving: true));
    final now = ref.read(clockProvider).now();
    final original = s.original;
    final unchangedMoney = original != null && original.amount == s.amount;

    final quote = s.rate!;
    final record = TransactionRecord(
      id: original?.id ?? _uuid.v4(),
      type: s.type,
      title: s.title.trim().isEmpty ? null : s.title.trim(),
      note: s.note.trim().isEmpty ? null : s.note.trim(),
      amount: s.amount,
      // Untouched amounts keep their frozen conversion exactly as recorded.
      fxRate: unchangedMoney ? original.fxRate : quote.rate.rate,
      homeAmount: unchangedMoney ? original.homeAmount : quote.rate.convert(s.amount),
      rateSource: unchangedMoney
          ? original.rateSource
          : !s.needsConversion
          ? RateSource.identity
          : quote.isManual
          ? RateSource.manual
          : RateSource.api,
      categoryId: s.categoryId!,
      paymentMethod: s.paymentMethod,
      date: s.date,
      createdAt: original?.createdAt ?? now,
      updatedAt: now,
    );
    await ref.read(transactionRepositoryProvider).save(record);
    _set(s.copyWith(saving: false));
    return record;
  }

  Future<void> delete() async {
    final id = _s.original?.id;
    if (id != null) await ref.read(transactionRepositoryProvider).delete(id);
  }
}
