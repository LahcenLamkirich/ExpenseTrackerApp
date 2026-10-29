// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_editor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives the Add / Edit transaction screen. [transactionId] null = new.

@ProviderFor(TransactionEditor)
final transactionEditorProvider = TransactionEditorFamily._();

/// Drives the Add / Edit transaction screen. [transactionId] null = new.
final class TransactionEditorProvider
    extends $AsyncNotifierProvider<TransactionEditor, TransactionEditorState> {
  /// Drives the Add / Edit transaction screen. [transactionId] null = new.
  TransactionEditorProvider._({
    required TransactionEditorFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'transactionEditorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionEditorHash();

  @override
  String toString() {
    return r'transactionEditorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TransactionEditor create() => TransactionEditor();

  @override
  bool operator ==(Object other) {
    return other is TransactionEditorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionEditorHash() => r'b5b7bf7895dd02460a50fd271b0b8e7f242c47fc';

/// Drives the Add / Edit transaction screen. [transactionId] null = new.

final class TransactionEditorFamily extends $Family
    with
        $ClassFamilyOverride<
          TransactionEditor,
          AsyncValue<TransactionEditorState>,
          TransactionEditorState,
          FutureOr<TransactionEditorState>,
          String?
        > {
  TransactionEditorFamily._()
    : super(
        retry: null,
        name: r'transactionEditorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Drives the Add / Edit transaction screen. [transactionId] null = new.

  TransactionEditorProvider call(String? transactionId) =>
      TransactionEditorProvider._(argument: transactionId, from: this);

  @override
  String toString() => r'transactionEditorProvider';
}

/// Drives the Add / Edit transaction screen. [transactionId] null = new.

abstract class _$TransactionEditor
    extends $AsyncNotifier<TransactionEditorState> {
  late final _$args = ref.$arg as String?;
  String? get transactionId => _$args;

  FutureOr<TransactionEditorState> build(String? transactionId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<TransactionEditorState>, TransactionEditorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TransactionEditorState>,
                TransactionEditorState
              >,
              AsyncValue<TransactionEditorState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
