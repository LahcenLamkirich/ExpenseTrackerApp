// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameKeyMeta = const VerificationMeta(
    'nameKey',
  );
  @override
  late final GeneratedColumn<String> nameKey = GeneratedColumn<String>(
    'name_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _glyphMeta = const VerificationMeta('glyph');
  @override
  late final GeneratedColumn<String> glyph = GeneratedColumn<String>(
    'glyph',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CategoryKind, int> kind =
      GeneratedColumn<int>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CategoryKind>($CategoriesTable.$converterkind);
  static const VerificationMeta _monthlyCapMinorMeta = const VerificationMeta(
    'monthlyCapMinor',
  );
  @override
  late final GeneratedColumn<int> monthlyCapMinor = GeneratedColumn<int>(
    'monthly_cap_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameKey,
    name,
    glyph,
    colorValue,
    kind,
    monthlyCapMinor,
    sortOrder,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_key')) {
      context.handle(
        _nameKeyMeta,
        nameKey.isAcceptableOrUnknown(data['name_key']!, _nameKeyMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('glyph')) {
      context.handle(
        _glyphMeta,
        glyph.isAcceptableOrUnknown(data['glyph']!, _glyphMeta),
      );
    } else if (isInserting) {
      context.missing(_glyphMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('monthly_cap_minor')) {
      context.handle(
        _monthlyCapMinorMeta,
        monthlyCapMinor.isAcceptableOrUnknown(
          data['monthly_cap_minor']!,
          _monthlyCapMinorMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_key'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      glyph: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}glyph'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      kind: $CategoriesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}kind'],
        )!,
      ),
      monthlyCapMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_cap_minor'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryKind, int, int> $converterkind =
      const EnumIndexConverter<CategoryKind>(CategoryKind.values);
}

class CategoryRow extends DataClass implements Insertable<CategoryRow> {
  final String id;

  /// ARB key for built-in categories (localized at display time).
  final String? nameKey;

  /// User-entered name; overrides [nameKey] when set.
  final String? name;

  /// Emoji glyph shown in the category badge.
  final String glyph;

  /// ARGB colour.
  final int colorValue;
  final CategoryKind kind;

  /// Optional monthly cap in the home currency's minor units.
  final int? monthlyCapMinor;
  final int sortOrder;

  /// Soft delete: archived categories keep history intact.
  final bool isArchived;
  const CategoryRow({
    required this.id,
    this.nameKey,
    this.name,
    required this.glyph,
    required this.colorValue,
    required this.kind,
    this.monthlyCapMinor,
    required this.sortOrder,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || nameKey != null) {
      map['name_key'] = Variable<String>(nameKey);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['glyph'] = Variable<String>(glyph);
    map['color_value'] = Variable<int>(colorValue);
    {
      map['kind'] = Variable<int>($CategoriesTable.$converterkind.toSql(kind));
    }
    if (!nullToAbsent || monthlyCapMinor != null) {
      map['monthly_cap_minor'] = Variable<int>(monthlyCapMinor);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      nameKey: nameKey == null && nullToAbsent
          ? const Value.absent()
          : Value(nameKey),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      glyph: Value(glyph),
      colorValue: Value(colorValue),
      kind: Value(kind),
      monthlyCapMinor: monthlyCapMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlyCapMinor),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
    );
  }

  factory CategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRow(
      id: serializer.fromJson<String>(json['id']),
      nameKey: serializer.fromJson<String?>(json['nameKey']),
      name: serializer.fromJson<String?>(json['name']),
      glyph: serializer.fromJson<String>(json['glyph']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      kind: $CategoriesTable.$converterkind.fromJson(
        serializer.fromJson<int>(json['kind']),
      ),
      monthlyCapMinor: serializer.fromJson<int?>(json['monthlyCapMinor']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameKey': serializer.toJson<String?>(nameKey),
      'name': serializer.toJson<String?>(name),
      'glyph': serializer.toJson<String>(glyph),
      'colorValue': serializer.toJson<int>(colorValue),
      'kind': serializer.toJson<int>(
        $CategoriesTable.$converterkind.toJson(kind),
      ),
      'monthlyCapMinor': serializer.toJson<int?>(monthlyCapMinor),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  CategoryRow copyWith({
    String? id,
    Value<String?> nameKey = const Value.absent(),
    Value<String?> name = const Value.absent(),
    String? glyph,
    int? colorValue,
    CategoryKind? kind,
    Value<int?> monthlyCapMinor = const Value.absent(),
    int? sortOrder,
    bool? isArchived,
  }) => CategoryRow(
    id: id ?? this.id,
    nameKey: nameKey.present ? nameKey.value : this.nameKey,
    name: name.present ? name.value : this.name,
    glyph: glyph ?? this.glyph,
    colorValue: colorValue ?? this.colorValue,
    kind: kind ?? this.kind,
    monthlyCapMinor: monthlyCapMinor.present
        ? monthlyCapMinor.value
        : this.monthlyCapMinor,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
  );
  CategoryRow copyWithCompanion(CategoriesCompanion data) {
    return CategoryRow(
      id: data.id.present ? data.id.value : this.id,
      nameKey: data.nameKey.present ? data.nameKey.value : this.nameKey,
      name: data.name.present ? data.name.value : this.name,
      glyph: data.glyph.present ? data.glyph.value : this.glyph,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      kind: data.kind.present ? data.kind.value : this.kind,
      monthlyCapMinor: data.monthlyCapMinor.present
          ? data.monthlyCapMinor.value
          : this.monthlyCapMinor,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRow(')
          ..write('id: $id, ')
          ..write('nameKey: $nameKey, ')
          ..write('name: $name, ')
          ..write('glyph: $glyph, ')
          ..write('colorValue: $colorValue, ')
          ..write('kind: $kind, ')
          ..write('monthlyCapMinor: $monthlyCapMinor, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameKey,
    name,
    glyph,
    colorValue,
    kind,
    monthlyCapMinor,
    sortOrder,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRow &&
          other.id == this.id &&
          other.nameKey == this.nameKey &&
          other.name == this.name &&
          other.glyph == this.glyph &&
          other.colorValue == this.colorValue &&
          other.kind == this.kind &&
          other.monthlyCapMinor == this.monthlyCapMinor &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived);
}

class CategoriesCompanion extends UpdateCompanion<CategoryRow> {
  final Value<String> id;
  final Value<String?> nameKey;
  final Value<String?> name;
  final Value<String> glyph;
  final Value<int> colorValue;
  final Value<CategoryKind> kind;
  final Value<int?> monthlyCapMinor;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.nameKey = const Value.absent(),
    this.name = const Value.absent(),
    this.glyph = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.kind = const Value.absent(),
    this.monthlyCapMinor = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    this.nameKey = const Value.absent(),
    this.name = const Value.absent(),
    required String glyph,
    required int colorValue,
    required CategoryKind kind,
    this.monthlyCapMinor = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       glyph = Value(glyph),
       colorValue = Value(colorValue),
       kind = Value(kind);
  static Insertable<CategoryRow> custom({
    Expression<String>? id,
    Expression<String>? nameKey,
    Expression<String>? name,
    Expression<String>? glyph,
    Expression<int>? colorValue,
    Expression<int>? kind,
    Expression<int>? monthlyCapMinor,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameKey != null) 'name_key': nameKey,
      if (name != null) 'name': name,
      if (glyph != null) 'glyph': glyph,
      if (colorValue != null) 'color_value': colorValue,
      if (kind != null) 'kind': kind,
      if (monthlyCapMinor != null) 'monthly_cap_minor': monthlyCapMinor,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String?>? nameKey,
    Value<String?>? name,
    Value<String>? glyph,
    Value<int>? colorValue,
    Value<CategoryKind>? kind,
    Value<int?>? monthlyCapMinor,
    Value<int>? sortOrder,
    Value<bool>? isArchived,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      nameKey: nameKey ?? this.nameKey,
      name: name ?? this.name,
      glyph: glyph ?? this.glyph,
      colorValue: colorValue ?? this.colorValue,
      kind: kind ?? this.kind,
      monthlyCapMinor: monthlyCapMinor ?? this.monthlyCapMinor,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameKey.present) {
      map['name_key'] = Variable<String>(nameKey.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (glyph.present) {
      map['glyph'] = Variable<String>(glyph.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(
        $CategoriesTable.$converterkind.toSql(kind.value),
      );
    }
    if (monthlyCapMinor.present) {
      map['monthly_cap_minor'] = Variable<int>(monthlyCapMinor.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('nameKey: $nameKey, ')
          ..write('name: $name, ')
          ..write('glyph: $glyph, ')
          ..write('colorValue: $colorValue, ')
          ..write('kind: $kind, ')
          ..write('monthlyCapMinor: $monthlyCapMinor, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TransactionType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TransactionType>($TransactionsTable.$convertertype);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    check: () => ComparableExpr(amountMinor).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _homeCurrencyCodeMeta = const VerificationMeta(
    'homeCurrencyCode',
  );
  @override
  late final GeneratedColumn<String> homeCurrencyCode = GeneratedColumn<String>(
    'home_currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> fxRate =
      GeneratedColumn<String>(
        'fx_rate',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Decimal>($TransactionsTable.$converterfxRate);
  static const VerificationMeta _homeAmountMinorMeta = const VerificationMeta(
    'homeAmountMinor',
  );
  @override
  late final GeneratedColumn<int> homeAmountMinor = GeneratedColumn<int>(
    'home_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RateSource, int> rateSource =
      GeneratedColumn<int>(
        'rate_source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<RateSource>($TransactionsTable.$converterrateSource);
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, int>
  paymentMethod = GeneratedColumn<int>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<PaymentMethod>($TransactionsTable.$converterpaymentMethod);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    title,
    amountMinor,
    currencyCode,
    homeCurrencyCode,
    fxRate,
    homeAmountMinor,
    rateSource,
    categoryId,
    paymentMethod,
    date,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('home_currency_code')) {
      context.handle(
        _homeCurrencyCodeMeta,
        homeCurrencyCode.isAcceptableOrUnknown(
          data['home_currency_code']!,
          _homeCurrencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeCurrencyCodeMeta);
    }
    if (data.containsKey('home_amount_minor')) {
      context.handle(
        _homeAmountMinorMeta,
        homeAmountMinor.isAcceptableOrUnknown(
          data['home_amount_minor']!,
          _homeAmountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeAmountMinorMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: $TransactionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      homeCurrencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_currency_code'],
      )!,
      fxRate: $TransactionsTable.$converterfxRate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fx_rate'],
        )!,
      ),
      homeAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}home_amount_minor'],
      )!,
      rateSource: $TransactionsTable.$converterrateSource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}rate_source'],
        )!,
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      paymentMethod: $TransactionsTable.$converterpaymentMethod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}payment_method'],
        )!,
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransactionType, int, int> $convertertype =
      const EnumIndexConverter<TransactionType>(TransactionType.values);
  static TypeConverter<Decimal, String> $converterfxRate =
      const DecimalConverter();
  static JsonTypeConverter2<RateSource, int, int> $converterrateSource =
      const EnumIndexConverter<RateSource>(RateSource.values);
  static JsonTypeConverter2<PaymentMethod, int, int> $converterpaymentMethod =
      const EnumIndexConverter<PaymentMethod>(PaymentMethod.values);
}

class TransactionRow extends DataClass implements Insertable<TransactionRow> {
  final String id;
  final TransactionType type;

  /// Merchant / payee, e.g. "Espresso Lab".
  final String? title;

  /// Original amount in minor units of [currencyCode]; always positive,
  /// the sign comes from [type].
  final int amountMinor;
  final String currencyCode;

  /// Home currency at the time the transaction was recorded.
  final String homeCurrencyCode;

  /// Rate `currencyCode → homeCurrencyCode` frozen at transaction time.
  final Decimal fxRate;

  /// Converted amount in [homeCurrencyCode] minor units, frozen.
  final int homeAmountMinor;
  final RateSource rateSource;
  final String categoryId;
  final PaymentMethod paymentMethod;
  final DateTime date;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TransactionRow({
    required this.id,
    required this.type,
    this.title,
    required this.amountMinor,
    required this.currencyCode,
    required this.homeCurrencyCode,
    required this.fxRate,
    required this.homeAmountMinor,
    required this.rateSource,
    required this.categoryId,
    required this.paymentMethod,
    required this.date,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['type'] = Variable<int>(
        $TransactionsTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['amount_minor'] = Variable<int>(amountMinor);
    map['currency_code'] = Variable<String>(currencyCode);
    map['home_currency_code'] = Variable<String>(homeCurrencyCode);
    {
      map['fx_rate'] = Variable<String>(
        $TransactionsTable.$converterfxRate.toSql(fxRate),
      );
    }
    map['home_amount_minor'] = Variable<int>(homeAmountMinor);
    {
      map['rate_source'] = Variable<int>(
        $TransactionsTable.$converterrateSource.toSql(rateSource),
      );
    }
    map['category_id'] = Variable<String>(categoryId);
    {
      map['payment_method'] = Variable<int>(
        $TransactionsTable.$converterpaymentMethod.toSql(paymentMethod),
      );
    }
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      type: Value(type),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      amountMinor: Value(amountMinor),
      currencyCode: Value(currencyCode),
      homeCurrencyCode: Value(homeCurrencyCode),
      fxRate: Value(fxRate),
      homeAmountMinor: Value(homeAmountMinor),
      rateSource: Value(rateSource),
      categoryId: Value(categoryId),
      paymentMethod: Value(paymentMethod),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionRow(
      id: serializer.fromJson<String>(json['id']),
      type: $TransactionsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      title: serializer.fromJson<String?>(json['title']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      homeCurrencyCode: serializer.fromJson<String>(json['homeCurrencyCode']),
      fxRate: serializer.fromJson<Decimal>(json['fxRate']),
      homeAmountMinor: serializer.fromJson<int>(json['homeAmountMinor']),
      rateSource: $TransactionsTable.$converterrateSource.fromJson(
        serializer.fromJson<int>(json['rateSource']),
      ),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      paymentMethod: $TransactionsTable.$converterpaymentMethod.fromJson(
        serializer.fromJson<int>(json['paymentMethod']),
      ),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<int>(
        $TransactionsTable.$convertertype.toJson(type),
      ),
      'title': serializer.toJson<String?>(title),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'homeCurrencyCode': serializer.toJson<String>(homeCurrencyCode),
      'fxRate': serializer.toJson<Decimal>(fxRate),
      'homeAmountMinor': serializer.toJson<int>(homeAmountMinor),
      'rateSource': serializer.toJson<int>(
        $TransactionsTable.$converterrateSource.toJson(rateSource),
      ),
      'categoryId': serializer.toJson<String>(categoryId),
      'paymentMethod': serializer.toJson<int>(
        $TransactionsTable.$converterpaymentMethod.toJson(paymentMethod),
      ),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TransactionRow copyWith({
    String? id,
    TransactionType? type,
    Value<String?> title = const Value.absent(),
    int? amountMinor,
    String? currencyCode,
    String? homeCurrencyCode,
    Decimal? fxRate,
    int? homeAmountMinor,
    RateSource? rateSource,
    String? categoryId,
    PaymentMethod? paymentMethod,
    DateTime? date,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TransactionRow(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title.present ? title.value : this.title,
    amountMinor: amountMinor ?? this.amountMinor,
    currencyCode: currencyCode ?? this.currencyCode,
    homeCurrencyCode: homeCurrencyCode ?? this.homeCurrencyCode,
    fxRate: fxRate ?? this.fxRate,
    homeAmountMinor: homeAmountMinor ?? this.homeAmountMinor,
    rateSource: rateSource ?? this.rateSource,
    categoryId: categoryId ?? this.categoryId,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TransactionRow copyWithCompanion(TransactionsCompanion data) {
    return TransactionRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      homeCurrencyCode: data.homeCurrencyCode.present
          ? data.homeCurrencyCode.value
          : this.homeCurrencyCode,
      fxRate: data.fxRate.present ? data.fxRate.value : this.fxRate,
      homeAmountMinor: data.homeAmountMinor.present
          ? data.homeAmountMinor.value
          : this.homeAmountMinor,
      rateSource: data.rateSource.present
          ? data.rateSource.value
          : this.rateSource,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('homeCurrencyCode: $homeCurrencyCode, ')
          ..write('fxRate: $fxRate, ')
          ..write('homeAmountMinor: $homeAmountMinor, ')
          ..write('rateSource: $rateSource, ')
          ..write('categoryId: $categoryId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    title,
    amountMinor,
    currencyCode,
    homeCurrencyCode,
    fxRate,
    homeAmountMinor,
    rateSource,
    categoryId,
    paymentMethod,
    date,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.amountMinor == this.amountMinor &&
          other.currencyCode == this.currencyCode &&
          other.homeCurrencyCode == this.homeCurrencyCode &&
          other.fxRate == this.fxRate &&
          other.homeAmountMinor == this.homeAmountMinor &&
          other.rateSource == this.rateSource &&
          other.categoryId == this.categoryId &&
          other.paymentMethod == this.paymentMethod &&
          other.date == this.date &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionsCompanion extends UpdateCompanion<TransactionRow> {
  final Value<String> id;
  final Value<TransactionType> type;
  final Value<String?> title;
  final Value<int> amountMinor;
  final Value<String> currencyCode;
  final Value<String> homeCurrencyCode;
  final Value<Decimal> fxRate;
  final Value<int> homeAmountMinor;
  final Value<RateSource> rateSource;
  final Value<String> categoryId;
  final Value<PaymentMethod> paymentMethod;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.homeCurrencyCode = const Value.absent(),
    this.fxRate = const Value.absent(),
    this.homeAmountMinor = const Value.absent(),
    this.rateSource = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required TransactionType type,
    this.title = const Value.absent(),
    required int amountMinor,
    required String currencyCode,
    required String homeCurrencyCode,
    required Decimal fxRate,
    required int homeAmountMinor,
    required RateSource rateSource,
    required String categoryId,
    required PaymentMethod paymentMethod,
    required DateTime date,
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       amountMinor = Value(amountMinor),
       currencyCode = Value(currencyCode),
       homeCurrencyCode = Value(homeCurrencyCode),
       fxRate = Value(fxRate),
       homeAmountMinor = Value(homeAmountMinor),
       rateSource = Value(rateSource),
       categoryId = Value(categoryId),
       paymentMethod = Value(paymentMethod),
       date = Value(date),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TransactionRow> custom({
    Expression<String>? id,
    Expression<int>? type,
    Expression<String>? title,
    Expression<int>? amountMinor,
    Expression<String>? currencyCode,
    Expression<String>? homeCurrencyCode,
    Expression<String>? fxRate,
    Expression<int>? homeAmountMinor,
    Expression<int>? rateSource,
    Expression<String>? categoryId,
    Expression<int>? paymentMethod,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (homeCurrencyCode != null) 'home_currency_code': homeCurrencyCode,
      if (fxRate != null) 'fx_rate': fxRate,
      if (homeAmountMinor != null) 'home_amount_minor': homeAmountMinor,
      if (rateSource != null) 'rate_source': rateSource,
      if (categoryId != null) 'category_id': categoryId,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<TransactionType>? type,
    Value<String?>? title,
    Value<int>? amountMinor,
    Value<String>? currencyCode,
    Value<String>? homeCurrencyCode,
    Value<Decimal>? fxRate,
    Value<int>? homeAmountMinor,
    Value<RateSource>? rateSource,
    Value<String>? categoryId,
    Value<PaymentMethod>? paymentMethod,
    Value<DateTime>? date,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      amountMinor: amountMinor ?? this.amountMinor,
      currencyCode: currencyCode ?? this.currencyCode,
      homeCurrencyCode: homeCurrencyCode ?? this.homeCurrencyCode,
      fxRate: fxRate ?? this.fxRate,
      homeAmountMinor: homeAmountMinor ?? this.homeAmountMinor,
      rateSource: rateSource ?? this.rateSource,
      categoryId: categoryId ?? this.categoryId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      date: date ?? this.date,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $TransactionsTable.$convertertype.toSql(type.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (homeCurrencyCode.present) {
      map['home_currency_code'] = Variable<String>(homeCurrencyCode.value);
    }
    if (fxRate.present) {
      map['fx_rate'] = Variable<String>(
        $TransactionsTable.$converterfxRate.toSql(fxRate.value),
      );
    }
    if (homeAmountMinor.present) {
      map['home_amount_minor'] = Variable<int>(homeAmountMinor.value);
    }
    if (rateSource.present) {
      map['rate_source'] = Variable<int>(
        $TransactionsTable.$converterrateSource.toSql(rateSource.value),
      );
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<int>(
        $TransactionsTable.$converterpaymentMethod.toSql(paymentMethod.value),
      );
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('homeCurrencyCode: $homeCurrencyCode, ')
          ..write('fxRate: $fxRate, ')
          ..write('homeAmountMinor: $homeAmountMinor, ')
          ..write('rateSource: $rateSource, ')
          ..write('categoryId: $categoryId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RateSnapshotsTable extends RateSnapshots
    with TableInfo<$RateSnapshotsTable, RateSnapshotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RateSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _baseCodeMeta = const VerificationMeta(
    'baseCode',
  );
  @override
  late final GeneratedColumn<String> baseCode = GeneratedColumn<String>(
    'base_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerUpdatedAtMeta = const VerificationMeta(
    'providerUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> providerUpdatedAt =
      GeneratedColumn<DateTime>(
        'provider_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isManualMeta = const VerificationMeta(
    'isManual',
  );
  @override
  late final GeneratedColumn<bool> isManual = GeneratedColumn<bool>(
    'is_manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_manual" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    baseCode,
    fetchedAt,
    providerUpdatedAt,
    provider,
    isManual,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rate_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<RateSnapshotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('base_code')) {
      context.handle(
        _baseCodeMeta,
        baseCode.isAcceptableOrUnknown(data['base_code']!, _baseCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_baseCodeMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('provider_updated_at')) {
      context.handle(
        _providerUpdatedAtMeta,
        providerUpdatedAt.isAcceptableOrUnknown(
          data['provider_updated_at']!,
          _providerUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('is_manual')) {
      context.handle(
        _isManualMeta,
        isManual.isAcceptableOrUnknown(data['is_manual']!, _isManualMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RateSnapshotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RateSnapshotRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      baseCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_code'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      providerUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}provider_updated_at'],
      ),
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      isManual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_manual'],
      )!,
    );
  }

  @override
  $RateSnapshotsTable createAlias(String alias) {
    return $RateSnapshotsTable(attachedDatabase, alias);
  }
}

class RateSnapshotRow extends DataClass implements Insertable<RateSnapshotRow> {
  final int id;
  final String baseCode;
  final DateTime fetchedAt;

  /// Provider's own "last updated" timestamp, when available.
  final DateTime? providerUpdatedAt;
  final String provider;
  final bool isManual;
  const RateSnapshotRow({
    required this.id,
    required this.baseCode,
    required this.fetchedAt,
    this.providerUpdatedAt,
    required this.provider,
    required this.isManual,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['base_code'] = Variable<String>(baseCode);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    if (!nullToAbsent || providerUpdatedAt != null) {
      map['provider_updated_at'] = Variable<DateTime>(providerUpdatedAt);
    }
    map['provider'] = Variable<String>(provider);
    map['is_manual'] = Variable<bool>(isManual);
    return map;
  }

  RateSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return RateSnapshotsCompanion(
      id: Value(id),
      baseCode: Value(baseCode),
      fetchedAt: Value(fetchedAt),
      providerUpdatedAt: providerUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(providerUpdatedAt),
      provider: Value(provider),
      isManual: Value(isManual),
    );
  }

  factory RateSnapshotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RateSnapshotRow(
      id: serializer.fromJson<int>(json['id']),
      baseCode: serializer.fromJson<String>(json['baseCode']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      providerUpdatedAt: serializer.fromJson<DateTime?>(
        json['providerUpdatedAt'],
      ),
      provider: serializer.fromJson<String>(json['provider']),
      isManual: serializer.fromJson<bool>(json['isManual']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'baseCode': serializer.toJson<String>(baseCode),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'providerUpdatedAt': serializer.toJson<DateTime?>(providerUpdatedAt),
      'provider': serializer.toJson<String>(provider),
      'isManual': serializer.toJson<bool>(isManual),
    };
  }

  RateSnapshotRow copyWith({
    int? id,
    String? baseCode,
    DateTime? fetchedAt,
    Value<DateTime?> providerUpdatedAt = const Value.absent(),
    String? provider,
    bool? isManual,
  }) => RateSnapshotRow(
    id: id ?? this.id,
    baseCode: baseCode ?? this.baseCode,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    providerUpdatedAt: providerUpdatedAt.present
        ? providerUpdatedAt.value
        : this.providerUpdatedAt,
    provider: provider ?? this.provider,
    isManual: isManual ?? this.isManual,
  );
  RateSnapshotRow copyWithCompanion(RateSnapshotsCompanion data) {
    return RateSnapshotRow(
      id: data.id.present ? data.id.value : this.id,
      baseCode: data.baseCode.present ? data.baseCode.value : this.baseCode,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      providerUpdatedAt: data.providerUpdatedAt.present
          ? data.providerUpdatedAt.value
          : this.providerUpdatedAt,
      provider: data.provider.present ? data.provider.value : this.provider,
      isManual: data.isManual.present ? data.isManual.value : this.isManual,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RateSnapshotRow(')
          ..write('id: $id, ')
          ..write('baseCode: $baseCode, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('providerUpdatedAt: $providerUpdatedAt, ')
          ..write('provider: $provider, ')
          ..write('isManual: $isManual')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    baseCode,
    fetchedAt,
    providerUpdatedAt,
    provider,
    isManual,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RateSnapshotRow &&
          other.id == this.id &&
          other.baseCode == this.baseCode &&
          other.fetchedAt == this.fetchedAt &&
          other.providerUpdatedAt == this.providerUpdatedAt &&
          other.provider == this.provider &&
          other.isManual == this.isManual);
}

class RateSnapshotsCompanion extends UpdateCompanion<RateSnapshotRow> {
  final Value<int> id;
  final Value<String> baseCode;
  final Value<DateTime> fetchedAt;
  final Value<DateTime?> providerUpdatedAt;
  final Value<String> provider;
  final Value<bool> isManual;
  const RateSnapshotsCompanion({
    this.id = const Value.absent(),
    this.baseCode = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.providerUpdatedAt = const Value.absent(),
    this.provider = const Value.absent(),
    this.isManual = const Value.absent(),
  });
  RateSnapshotsCompanion.insert({
    this.id = const Value.absent(),
    required String baseCode,
    required DateTime fetchedAt,
    this.providerUpdatedAt = const Value.absent(),
    required String provider,
    this.isManual = const Value.absent(),
  }) : baseCode = Value(baseCode),
       fetchedAt = Value(fetchedAt),
       provider = Value(provider);
  static Insertable<RateSnapshotRow> custom({
    Expression<int>? id,
    Expression<String>? baseCode,
    Expression<DateTime>? fetchedAt,
    Expression<DateTime>? providerUpdatedAt,
    Expression<String>? provider,
    Expression<bool>? isManual,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseCode != null) 'base_code': baseCode,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (providerUpdatedAt != null) 'provider_updated_at': providerUpdatedAt,
      if (provider != null) 'provider': provider,
      if (isManual != null) 'is_manual': isManual,
    });
  }

  RateSnapshotsCompanion copyWith({
    Value<int>? id,
    Value<String>? baseCode,
    Value<DateTime>? fetchedAt,
    Value<DateTime?>? providerUpdatedAt,
    Value<String>? provider,
    Value<bool>? isManual,
  }) {
    return RateSnapshotsCompanion(
      id: id ?? this.id,
      baseCode: baseCode ?? this.baseCode,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      providerUpdatedAt: providerUpdatedAt ?? this.providerUpdatedAt,
      provider: provider ?? this.provider,
      isManual: isManual ?? this.isManual,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (baseCode.present) {
      map['base_code'] = Variable<String>(baseCode.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (providerUpdatedAt.present) {
      map['provider_updated_at'] = Variable<DateTime>(providerUpdatedAt.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (isManual.present) {
      map['is_manual'] = Variable<bool>(isManual.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RateSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('baseCode: $baseCode, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('providerUpdatedAt: $providerUpdatedAt, ')
          ..write('provider: $provider, ')
          ..write('isManual: $isManual')
          ..write(')'))
        .toString();
  }
}

class $RateEntriesTable extends RateEntries
    with TableInfo<$RateEntriesTable, RateEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RateEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _snapshotIdMeta = const VerificationMeta(
    'snapshotId',
  );
  @override
  late final GeneratedColumn<int> snapshotId = GeneratedColumn<int>(
    'snapshot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rate_snapshots (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _quoteCodeMeta = const VerificationMeta(
    'quoteCode',
  );
  @override
  late final GeneratedColumn<String> quoteCode = GeneratedColumn<String>(
    'quote_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> rate =
      GeneratedColumn<String>(
        'rate',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Decimal>($RateEntriesTable.$converterrate);
  @override
  List<GeneratedColumn> get $columns => [snapshotId, quoteCode, rate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rate_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<RateEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('snapshot_id')) {
      context.handle(
        _snapshotIdMeta,
        snapshotId.isAcceptableOrUnknown(data['snapshot_id']!, _snapshotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_snapshotIdMeta);
    }
    if (data.containsKey('quote_code')) {
      context.handle(
        _quoteCodeMeta,
        quoteCode.isAcceptableOrUnknown(data['quote_code']!, _quoteCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {snapshotId, quoteCode};
  @override
  RateEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RateEntryRow(
      snapshotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snapshot_id'],
      )!,
      quoteCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_code'],
      )!,
      rate: $RateEntriesTable.$converterrate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rate'],
        )!,
      ),
    );
  }

  @override
  $RateEntriesTable createAlias(String alias) {
    return $RateEntriesTable(attachedDatabase, alias);
  }

  static TypeConverter<Decimal, String> $converterrate =
      const DecimalConverter();
}

class RateEntryRow extends DataClass implements Insertable<RateEntryRow> {
  final int snapshotId;
  final String quoteCode;
  final Decimal rate;
  const RateEntryRow({
    required this.snapshotId,
    required this.quoteCode,
    required this.rate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['snapshot_id'] = Variable<int>(snapshotId);
    map['quote_code'] = Variable<String>(quoteCode);
    {
      map['rate'] = Variable<String>(
        $RateEntriesTable.$converterrate.toSql(rate),
      );
    }
    return map;
  }

  RateEntriesCompanion toCompanion(bool nullToAbsent) {
    return RateEntriesCompanion(
      snapshotId: Value(snapshotId),
      quoteCode: Value(quoteCode),
      rate: Value(rate),
    );
  }

  factory RateEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RateEntryRow(
      snapshotId: serializer.fromJson<int>(json['snapshotId']),
      quoteCode: serializer.fromJson<String>(json['quoteCode']),
      rate: serializer.fromJson<Decimal>(json['rate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'snapshotId': serializer.toJson<int>(snapshotId),
      'quoteCode': serializer.toJson<String>(quoteCode),
      'rate': serializer.toJson<Decimal>(rate),
    };
  }

  RateEntryRow copyWith({int? snapshotId, String? quoteCode, Decimal? rate}) =>
      RateEntryRow(
        snapshotId: snapshotId ?? this.snapshotId,
        quoteCode: quoteCode ?? this.quoteCode,
        rate: rate ?? this.rate,
      );
  RateEntryRow copyWithCompanion(RateEntriesCompanion data) {
    return RateEntryRow(
      snapshotId: data.snapshotId.present
          ? data.snapshotId.value
          : this.snapshotId,
      quoteCode: data.quoteCode.present ? data.quoteCode.value : this.quoteCode,
      rate: data.rate.present ? data.rate.value : this.rate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RateEntryRow(')
          ..write('snapshotId: $snapshotId, ')
          ..write('quoteCode: $quoteCode, ')
          ..write('rate: $rate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(snapshotId, quoteCode, rate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RateEntryRow &&
          other.snapshotId == this.snapshotId &&
          other.quoteCode == this.quoteCode &&
          other.rate == this.rate);
}

class RateEntriesCompanion extends UpdateCompanion<RateEntryRow> {
  final Value<int> snapshotId;
  final Value<String> quoteCode;
  final Value<Decimal> rate;
  final Value<int> rowid;
  const RateEntriesCompanion({
    this.snapshotId = const Value.absent(),
    this.quoteCode = const Value.absent(),
    this.rate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RateEntriesCompanion.insert({
    required int snapshotId,
    required String quoteCode,
    required Decimal rate,
    this.rowid = const Value.absent(),
  }) : snapshotId = Value(snapshotId),
       quoteCode = Value(quoteCode),
       rate = Value(rate);
  static Insertable<RateEntryRow> custom({
    Expression<int>? snapshotId,
    Expression<String>? quoteCode,
    Expression<String>? rate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (snapshotId != null) 'snapshot_id': snapshotId,
      if (quoteCode != null) 'quote_code': quoteCode,
      if (rate != null) 'rate': rate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RateEntriesCompanion copyWith({
    Value<int>? snapshotId,
    Value<String>? quoteCode,
    Value<Decimal>? rate,
    Value<int>? rowid,
  }) {
    return RateEntriesCompanion(
      snapshotId: snapshotId ?? this.snapshotId,
      quoteCode: quoteCode ?? this.quoteCode,
      rate: rate ?? this.rate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (snapshotId.present) {
      map['snapshot_id'] = Variable<int>(snapshotId.value);
    }
    if (quoteCode.present) {
      map['quote_code'] = Variable<String>(quoteCode.value);
    }
    if (rate.present) {
      map['rate'] = Variable<String>(
        $RateEntriesTable.$converterrate.toSql(rate.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RateEntriesCompanion(')
          ..write('snapshotId: $snapshotId, ')
          ..write('quoteCode: $quoteCode, ')
          ..write('rate: $rate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrackedCurrenciesTable extends TrackedCurrencies
    with TableInfo<$TrackedCurrenciesTable, TrackedCurrencyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackedCurrenciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [code, sortOrder, isEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tracked_currencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackedCurrencyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  TrackedCurrencyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackedCurrencyRow(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
    );
  }

  @override
  $TrackedCurrenciesTable createAlias(String alias) {
    return $TrackedCurrenciesTable(attachedDatabase, alias);
  }
}

class TrackedCurrencyRow extends DataClass
    implements Insertable<TrackedCurrencyRow> {
  final String code;
  final int sortOrder;
  final bool isEnabled;
  const TrackedCurrencyRow({
    required this.code,
    required this.sortOrder,
    required this.isEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  TrackedCurrenciesCompanion toCompanion(bool nullToAbsent) {
    return TrackedCurrenciesCompanion(
      code: Value(code),
      sortOrder: Value(sortOrder),
      isEnabled: Value(isEnabled),
    );
  }

  factory TrackedCurrencyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackedCurrencyRow(
      code: serializer.fromJson<String>(json['code']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  TrackedCurrencyRow copyWith({
    String? code,
    int? sortOrder,
    bool? isEnabled,
  }) => TrackedCurrencyRow(
    code: code ?? this.code,
    sortOrder: sortOrder ?? this.sortOrder,
    isEnabled: isEnabled ?? this.isEnabled,
  );
  TrackedCurrencyRow copyWithCompanion(TrackedCurrenciesCompanion data) {
    return TrackedCurrencyRow(
      code: data.code.present ? data.code.value : this.code,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackedCurrencyRow(')
          ..write('code: $code, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, sortOrder, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackedCurrencyRow &&
          other.code == this.code &&
          other.sortOrder == this.sortOrder &&
          other.isEnabled == this.isEnabled);
}

class TrackedCurrenciesCompanion extends UpdateCompanion<TrackedCurrencyRow> {
  final Value<String> code;
  final Value<int> sortOrder;
  final Value<bool> isEnabled;
  final Value<int> rowid;
  const TrackedCurrenciesCompanion({
    this.code = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackedCurrenciesCompanion.insert({
    required String code,
    this.sortOrder = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code);
  static Insertable<TrackedCurrencyRow> custom({
    Expression<String>? code,
    Expression<int>? sortOrder,
    Expression<bool>? isEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackedCurrenciesCompanion copyWith({
    Value<String>? code,
    Value<int>? sortOrder,
    Value<bool>? isEnabled,
    Value<int>? rowid,
  }) {
    return TrackedCurrenciesCompanion(
      code: code ?? this.code,
      sortOrder: sortOrder ?? this.sortOrder,
      isEnabled: isEnabled ?? this.isEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackedCurrenciesCompanion(')
          ..write('code: $code, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $RateSnapshotsTable rateSnapshots = $RateSnapshotsTable(this);
  late final $RateEntriesTable rateEntries = $RateEntriesTable(this);
  late final $TrackedCurrenciesTable trackedCurrencies =
      $TrackedCurrenciesTable(this);
  late final Index transactionsDateIdx = Index(
    'transactions_date_idx',
    'CREATE INDEX transactions_date_idx ON transactions (date)',
  );
  late final Index transactionsCategoryDateIdx = Index(
    'transactions_category_date_idx',
    'CREATE INDEX transactions_category_date_idx ON transactions (category_id, date)',
  );
  late final Index transactionsCurrencyIdx = Index(
    'transactions_currency_idx',
    'CREATE INDEX transactions_currency_idx ON transactions (currency_code)',
  );
  late final Index rateSnapshotsFetchedIdx = Index(
    'rate_snapshots_fetched_idx',
    'CREATE INDEX rate_snapshots_fetched_idx ON rate_snapshots (fetched_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    transactions,
    rateSnapshots,
    rateEntries,
    trackedCurrencies,
    transactionsDateIdx,
    transactionsCategoryDateIdx,
    transactionsCurrencyIdx,
    rateSnapshotsFetchedIdx,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'rate_snapshots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('rate_entries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  Value<String?> nameKey,
  Value<String?> name,
  required String glyph,
  required int colorValue,
  required CategoryKind kind,
  Value<int?> monthlyCapMinor,
  Value<int> sortOrder,
  Value<bool> isArchived,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String?> nameKey,
  Value<String?> name,
  Value<String> glyph,
  Value<int> colorValue,
  Value<CategoryKind> kind,
  Value<int?> monthlyCapMinor,
  Value<int> sortOrder,
  Value<bool> isArchived,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, CategoryRow> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<TransactionRow>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'categories__id__transactions__category_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameKey => $composableBuilder(
    column: $table.nameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get glyph => $composableBuilder(
    column: $table.glyph,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CategoryKind, CategoryKind, int> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get monthlyCapMinor => $composableBuilder(
    column: $table.monthlyCapMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameKey => $composableBuilder(
    column: $table.nameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get glyph => $composableBuilder(
    column: $table.glyph,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlyCapMinor => $composableBuilder(
    column: $table.monthlyCapMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameKey =>
      $composableBuilder(column: $table.nameKey, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get glyph =>
      $composableBuilder(column: $table.glyph, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CategoryKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get monthlyCapMinor => $composableBuilder(
    column: $table.monthlyCapMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          CategoryRow,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (CategoryRow, $$CategoriesTableReferences),
          CategoryRow,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> nameKey = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String> glyph = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<CategoryKind> kind = const Value.absent(),
                Value<int?> monthlyCapMinor = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                nameKey: nameKey,
                name: name,
                glyph: glyph,
                colorValue: colorValue,
                kind: kind,
                monthlyCapMinor: monthlyCapMinor,
                sortOrder: sortOrder,
                isArchived: isArchived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> nameKey = const Value.absent(),
                Value<String?> name = const Value.absent(),
                required String glyph,
                required int colorValue,
                required CategoryKind kind,
                Value<int?> monthlyCapMinor = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                nameKey: nameKey,
                name: name,
                glyph: glyph,
                colorValue: colorValue,
                kind: kind,
                monthlyCapMinor: monthlyCapMinor,
                sortOrder: sortOrder,
                isArchived: isArchived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, CategoryRow>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedDataByColumns<
                      CategoryRow,
                      $CategoriesTable,
                      TransactionRow,
                      $TransactionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'category_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      CategoryRow,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (CategoryRow, $$CategoriesTableReferences),
      CategoryRow,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required TransactionType type,
      Value<String?> title,
      required int amountMinor,
      required String currencyCode,
      required String homeCurrencyCode,
      required Decimal fxRate,
      required int homeAmountMinor,
      required RateSource rateSource,
      required String categoryId,
      required PaymentMethod paymentMethod,
      required DateTime date,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<TransactionType> type,
      Value<String?> title,
      Value<int> amountMinor,
      Value<String> currencyCode,
      Value<String> homeCurrencyCode,
      Value<Decimal> fxRate,
      Value<int> homeAmountMinor,
      Value<RateSource> rateSource,
      Value<String> categoryId,
      Value<PaymentMethod> paymentMethod,
      Value<DateTime> date,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('transactions__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransactionType, TransactionType, int>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homeCurrencyCode => $composableBuilder(
    column: $table.homeCurrencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Decimal, Decimal, String> get fxRate =>
      $composableBuilder(
        column: $table.fxRate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get homeAmountMinor => $composableBuilder(
    column: $table.homeAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RateSource, RateSource, int> get rateSource =>
      $composableBuilder(
        column: $table.rateSource,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, int>
  get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homeCurrencyCode => $composableBuilder(
    column: $table.homeCurrencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fxRate => $composableBuilder(
    column: $table.fxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get homeAmountMinor => $composableBuilder(
    column: $table.homeAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rateSource => $composableBuilder(
    column: $table.rateSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get homeCurrencyCode => $composableBuilder(
    column: $table.homeCurrencyCode,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Decimal, String> get fxRate =>
      $composableBuilder(column: $table.fxRate, builder: (column) => column);

  GeneratedColumn<int> get homeAmountMinor => $composableBuilder(
    column: $table.homeAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RateSource, int> get rateSource =>
      $composableBuilder(
        column: $table.rateSource,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<PaymentMethod, int> get paymentMethod =>
      $composableBuilder(
        column: $table.paymentMethod,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          TransactionRow,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (TransactionRow, $$TransactionsTableReferences),
          TransactionRow,
          PrefetchHooks Function({bool categoryId})
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<TransactionType> type = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> homeCurrencyCode = const Value.absent(),
                Value<Decimal> fxRate = const Value.absent(),
                Value<int> homeAmountMinor = const Value.absent(),
                Value<RateSource> rateSource = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<PaymentMethod> paymentMethod = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                type: type,
                title: title,
                amountMinor: amountMinor,
                currencyCode: currencyCode,
                homeCurrencyCode: homeCurrencyCode,
                fxRate: fxRate,
                homeAmountMinor: homeAmountMinor,
                rateSource: rateSource,
                categoryId: categoryId,
                paymentMethod: paymentMethod,
                date: date,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required TransactionType type,
                Value<String?> title = const Value.absent(),
                required int amountMinor,
                required String currencyCode,
                required String homeCurrencyCode,
                required Decimal fxRate,
                required int homeAmountMinor,
                required RateSource rateSource,
                required String categoryId,
                required PaymentMethod paymentMethod,
                required DateTime date,
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                type: type,
                title: title,
                amountMinor: amountMinor,
                currencyCode: currencyCode,
                homeCurrencyCode: homeCurrencyCode,
                fxRate: fxRate,
                homeAmountMinor: homeAmountMinor,
                rateSource: rateSource,
                categoryId: categoryId,
                paymentMethod: paymentMethod,
                date: date,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, TransactionRow>(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$TransactionsTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$TransactionsTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      TransactionRow,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (TransactionRow, $$TransactionsTableReferences),
      TransactionRow,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$RateSnapshotsTableCreateCompanionBuilder =
    RateSnapshotsCompanion Function({
      Value<int> id,
      required String baseCode,
      required DateTime fetchedAt,
      Value<DateTime?> providerUpdatedAt,
      required String provider,
      Value<bool> isManual,
    });
typedef $$RateSnapshotsTableUpdateCompanionBuilder =
    RateSnapshotsCompanion Function({
      Value<int> id,
      Value<String> baseCode,
      Value<DateTime> fetchedAt,
      Value<DateTime?> providerUpdatedAt,
      Value<String> provider,
      Value<bool> isManual,
    });

final class $$RateSnapshotsTableReferences
    extends
        BaseReferences<_$AppDatabase, $RateSnapshotsTable, RateSnapshotRow> {
  $$RateSnapshotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$RateEntriesTable, List<RateEntryRow>>
  _rateEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rateEntries,
    aliasName: 'rate_snapshots__id__rate_entries__snapshot_id',
  );

  $$RateEntriesTableProcessedTableManager get rateEntriesRefs {
    final manager = $$RateEntriesTableTableManager(
      $_db,
      $_db.rateEntries,
    ).filter((f) => f.snapshotId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_rateEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RateSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $RateSnapshotsTable> {
  $$RateSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCode => $composableBuilder(
    column: $table.baseCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get providerUpdatedAt => $composableBuilder(
    column: $table.providerUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rateEntriesRefs(
    Expression<bool> Function($$RateEntriesTableFilterComposer f) f,
  ) {
    final $$RateEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rateEntries,
      getReferencedColumn: (t) => t.snapshotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RateEntriesTableFilterComposer(
            $db: $db,
            $table: $db.rateEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RateSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $RateSnapshotsTable> {
  $$RateSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCode => $composableBuilder(
    column: $table.baseCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get providerUpdatedAt => $composableBuilder(
    column: $table.providerUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RateSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RateSnapshotsTable> {
  $$RateSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get baseCode =>
      $composableBuilder(column: $table.baseCode, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get providerUpdatedAt => $composableBuilder(
    column: $table.providerUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<bool> get isManual =>
      $composableBuilder(column: $table.isManual, builder: (column) => column);

  Expression<T> rateEntriesRefs<T extends Object>(
    Expression<T> Function($$RateEntriesTableAnnotationComposer a) f,
  ) {
    final $$RateEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rateEntries,
      getReferencedColumn: (t) => t.snapshotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RateEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.rateEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RateSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RateSnapshotsTable,
          RateSnapshotRow,
          $$RateSnapshotsTableFilterComposer,
          $$RateSnapshotsTableOrderingComposer,
          $$RateSnapshotsTableAnnotationComposer,
          $$RateSnapshotsTableCreateCompanionBuilder,
          $$RateSnapshotsTableUpdateCompanionBuilder,
          (RateSnapshotRow, $$RateSnapshotsTableReferences),
          RateSnapshotRow,
          PrefetchHooks Function({bool rateEntriesRefs})
        > {
  $$RateSnapshotsTableTableManager(_$AppDatabase db, $RateSnapshotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RateSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RateSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RateSnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> baseCode = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<DateTime?> providerUpdatedAt = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<bool> isManual = const Value.absent(),
              }) => RateSnapshotsCompanion(
                id: id,
                baseCode: baseCode,
                fetchedAt: fetchedAt,
                providerUpdatedAt: providerUpdatedAt,
                provider: provider,
                isManual: isManual,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String baseCode,
                required DateTime fetchedAt,
                Value<DateTime?> providerUpdatedAt = const Value.absent(),
                required String provider,
                Value<bool> isManual = const Value.absent(),
              }) => RateSnapshotsCompanion.insert(
                id: id,
                baseCode: baseCode,
                fetchedAt: fetchedAt,
                providerUpdatedAt: providerUpdatedAt,
                provider: provider,
                isManual: isManual,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RateSnapshotsTable, RateSnapshotRow>(table),
                  $$RateSnapshotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rateEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (rateEntriesRefs) db.rateEntries],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (rateEntriesRefs)
                    await $_getPrefetchedDataByColumns<
                      RateSnapshotRow,
                      $RateSnapshotsTable,
                      RateEntryRow,
                      $RateEntriesTable
                    >(
                      currentTable: table,
                      referencedTable: $$RateSnapshotsTableReferences
                          ._rateEntriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RateSnapshotsTableReferences(
                            db,
                            table,
                            p0,
                          ).rateEntriesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'snapshot_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RateSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RateSnapshotsTable,
      RateSnapshotRow,
      $$RateSnapshotsTableFilterComposer,
      $$RateSnapshotsTableOrderingComposer,
      $$RateSnapshotsTableAnnotationComposer,
      $$RateSnapshotsTableCreateCompanionBuilder,
      $$RateSnapshotsTableUpdateCompanionBuilder,
      (RateSnapshotRow, $$RateSnapshotsTableReferences),
      RateSnapshotRow,
      PrefetchHooks Function({bool rateEntriesRefs})
    >;
typedef $$RateEntriesTableCreateCompanionBuilder =
    RateEntriesCompanion Function({
      required int snapshotId,
      required String quoteCode,
      required Decimal rate,
      Value<int> rowid,
    });
typedef $$RateEntriesTableUpdateCompanionBuilder =
    RateEntriesCompanion Function({
      Value<int> snapshotId,
      Value<String> quoteCode,
      Value<Decimal> rate,
      Value<int> rowid,
    });

final class $$RateEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $RateEntriesTable, RateEntryRow> {
  $$RateEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RateSnapshotsTable _snapshotIdTable(_$AppDatabase db) => db
      .rateSnapshots
      .createAlias('rate_entries__snapshot_id__rate_snapshots__id');

  $$RateSnapshotsTableProcessedTableManager get snapshotId {
    final $_column = $_itemColumn<int>('snapshot_id')!;

    final manager = $$RateSnapshotsTableTableManager(
      $_db,
      $_db.rateSnapshots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_snapshotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RateEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $RateEntriesTable> {
  $$RateEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get quoteCode => $composableBuilder(
    column: $table.quoteCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Decimal, Decimal, String> get rate =>
      $composableBuilder(
        column: $table.rate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$RateSnapshotsTableFilterComposer get snapshotId {
    final $$RateSnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snapshotId,
      referencedTable: $db.rateSnapshots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RateSnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.rateSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RateEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $RateEntriesTable> {
  $$RateEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get quoteCode => $composableBuilder(
    column: $table.quoteCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  $$RateSnapshotsTableOrderingComposer get snapshotId {
    final $$RateSnapshotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snapshotId,
      referencedTable: $db.rateSnapshots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RateSnapshotsTableOrderingComposer(
            $db: $db,
            $table: $db.rateSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RateEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RateEntriesTable> {
  $$RateEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get quoteCode =>
      $composableBuilder(column: $table.quoteCode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Decimal, String> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  $$RateSnapshotsTableAnnotationComposer get snapshotId {
    final $$RateSnapshotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snapshotId,
      referencedTable: $db.rateSnapshots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RateSnapshotsTableAnnotationComposer(
            $db: $db,
            $table: $db.rateSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RateEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RateEntriesTable,
          RateEntryRow,
          $$RateEntriesTableFilterComposer,
          $$RateEntriesTableOrderingComposer,
          $$RateEntriesTableAnnotationComposer,
          $$RateEntriesTableCreateCompanionBuilder,
          $$RateEntriesTableUpdateCompanionBuilder,
          (RateEntryRow, $$RateEntriesTableReferences),
          RateEntryRow,
          PrefetchHooks Function({bool snapshotId})
        > {
  $$RateEntriesTableTableManager(_$AppDatabase db, $RateEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RateEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RateEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RateEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> snapshotId = const Value.absent(),
                Value<String> quoteCode = const Value.absent(),
                Value<Decimal> rate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RateEntriesCompanion(
                snapshotId: snapshotId,
                quoteCode: quoteCode,
                rate: rate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int snapshotId,
                required String quoteCode,
                required Decimal rate,
                Value<int> rowid = const Value.absent(),
              }) => RateEntriesCompanion.insert(
                snapshotId: snapshotId,
                quoteCode: quoteCode,
                rate: rate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RateEntriesTable, RateEntryRow>(table),
                  $$RateEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({snapshotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (snapshotId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.snapshotId,
                        referencedTable: $$RateEntriesTableReferences
                            ._snapshotIdTable(db),
                        referencedColumn: $$RateEntriesTableReferences
                            ._snapshotIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RateEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RateEntriesTable,
      RateEntryRow,
      $$RateEntriesTableFilterComposer,
      $$RateEntriesTableOrderingComposer,
      $$RateEntriesTableAnnotationComposer,
      $$RateEntriesTableCreateCompanionBuilder,
      $$RateEntriesTableUpdateCompanionBuilder,
      (RateEntryRow, $$RateEntriesTableReferences),
      RateEntryRow,
      PrefetchHooks Function({bool snapshotId})
    >;
typedef $$TrackedCurrenciesTableCreateCompanionBuilder =
    TrackedCurrenciesCompanion Function({
      required String code,
      Value<int> sortOrder,
      Value<bool> isEnabled,
      Value<int> rowid,
    });
typedef $$TrackedCurrenciesTableUpdateCompanionBuilder =
    TrackedCurrenciesCompanion Function({
      Value<String> code,
      Value<int> sortOrder,
      Value<bool> isEnabled,
      Value<int> rowid,
    });

class $$TrackedCurrenciesTableFilterComposer
    extends Composer<_$AppDatabase, $TrackedCurrenciesTable> {
  $$TrackedCurrenciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrackedCurrenciesTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackedCurrenciesTable> {
  $$TrackedCurrenciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrackedCurrenciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackedCurrenciesTable> {
  $$TrackedCurrenciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);
}

class $$TrackedCurrenciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackedCurrenciesTable,
          TrackedCurrencyRow,
          $$TrackedCurrenciesTableFilterComposer,
          $$TrackedCurrenciesTableOrderingComposer,
          $$TrackedCurrenciesTableAnnotationComposer,
          $$TrackedCurrenciesTableCreateCompanionBuilder,
          $$TrackedCurrenciesTableUpdateCompanionBuilder,
          (
            TrackedCurrencyRow,
            BaseReferences<
              _$AppDatabase,
              $TrackedCurrenciesTable,
              TrackedCurrencyRow
            >,
          ),
          TrackedCurrencyRow,
          PrefetchHooks Function()
        > {
  $$TrackedCurrenciesTableTableManager(
    _$AppDatabase db,
    $TrackedCurrenciesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackedCurrenciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackedCurrenciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackedCurrenciesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackedCurrenciesCompanion(
                code: code,
                sortOrder: sortOrder,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackedCurrenciesCompanion.insert(
                code: code,
                sortOrder: sortOrder,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrackedCurrenciesTable, TrackedCurrencyRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $TrackedCurrenciesTable,
                    TrackedCurrencyRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrackedCurrenciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackedCurrenciesTable,
      TrackedCurrencyRow,
      $$TrackedCurrenciesTableFilterComposer,
      $$TrackedCurrenciesTableOrderingComposer,
      $$TrackedCurrenciesTableAnnotationComposer,
      $$TrackedCurrenciesTableCreateCompanionBuilder,
      $$TrackedCurrenciesTableUpdateCompanionBuilder,
      (
        TrackedCurrencyRow,
        BaseReferences<
          _$AppDatabase,
          $TrackedCurrenciesTable,
          TrackedCurrencyRow
        >,
      ),
      TrackedCurrencyRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$RateSnapshotsTableTableManager get rateSnapshots =>
      $$RateSnapshotsTableTableManager(_db, _db.rateSnapshots);
  $$RateEntriesTableTableManager get rateEntries =>
      $$RateEntriesTableTableManager(_db, _db.rateEntries);
  $$TrackedCurrenciesTableTableManager get trackedCurrencies =>
      $$TrackedCurrenciesTableTableManager(_db, _db.trackedCurrencies);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App-wide database. Overridden with an in-memory database in tests.

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// App-wide database. Overridden with an in-memory database in tests.

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// App-wide database. Overridden with an in-memory database in tests.
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';
