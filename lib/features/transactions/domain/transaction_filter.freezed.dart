// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionFilter implements DiagnosticableTreeMixin {

 String get query; Set<String> get categoryIds; Set<String> get currencyCodes; TransactionType? get type; DateSpan? get span;
/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionFilterCopyWith<TransactionFilter> get copyWith => _$TransactionFilterCopyWithImpl<TransactionFilter>(this as TransactionFilter, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as TransactionFilter;
  properties
    ..add(DiagnosticsProperty('type', 'TransactionFilter'))
    ..add(DiagnosticsProperty('query', _this.query))..add(DiagnosticsProperty('categoryIds', _this.categoryIds))..add(DiagnosticsProperty('currencyCodes', _this.currencyCodes))..add(DiagnosticsProperty('type', _this.type))..add(DiagnosticsProperty('span', _this.span));
}

@override
bool operator ==(Object other) {
  final _this = this as TransactionFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionFilter&&(identical(other.query, _this.query) || other.query == _this.query)&&const DeepCollectionEquality().equals(other.categoryIds, _this.categoryIds)&&const DeepCollectionEquality().equals(other.currencyCodes, _this.currencyCodes)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.span, _this.span) || other.span == _this.span));
}


@override
int get hashCode {
  final _this = this as TransactionFilter;
  return Object.hash(runtimeType,_this.query,const DeepCollectionEquality().hash(_this.categoryIds),const DeepCollectionEquality().hash(_this.currencyCodes),_this.type,_this.span);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as TransactionFilter;
  return 'TransactionFilter(query: ${_this.query}, categoryIds: ${_this.categoryIds}, currencyCodes: ${_this.currencyCodes}, type: ${_this.type}, span: ${_this.span})';
}


}

/// @nodoc
abstract mixin class $TransactionFilterCopyWith<$Res>  {
  factory $TransactionFilterCopyWith(TransactionFilter value, $Res Function(TransactionFilter) _then) = _$TransactionFilterCopyWithImpl;
@useResult
$Res call({
 String query, Set<String> categoryIds, Set<String> currencyCodes, TransactionType? type, DateSpan? span
});




}
/// @nodoc
class _$TransactionFilterCopyWithImpl<$Res>
    implements $TransactionFilterCopyWith<$Res> {
  _$TransactionFilterCopyWithImpl(this._self, this._then);

  final TransactionFilter _self;
  final $Res Function(TransactionFilter) _then;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? categoryIds = null,Object? currencyCodes = null,Object? type = freezed,Object? span = freezed,}) {
  return _then(TransactionFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,currencyCodes: null == currencyCodes ? _self.currencyCodes : currencyCodes // ignore: cast_nullable_to_non_nullable
as Set<String>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType?,span: freezed == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as DateSpan?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionFilter].
extension TransactionFilterPatterns on TransactionFilter {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionFilter value)  $default,){
final _that = this;
switch (_that) {
case _TransactionFilter():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionFilter value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  Set<String> categoryIds,  Set<String> currencyCodes,  TransactionType? type,  DateSpan? span)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
return $default(_that.query,_that.categoryIds,_that.currencyCodes,_that.type,_that.span);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  Set<String> categoryIds,  Set<String> currencyCodes,  TransactionType? type,  DateSpan? span)  $default,) {final _that = this;
switch (_that) {
case _TransactionFilter():
return $default(_that.query,_that.categoryIds,_that.currencyCodes,_that.type,_that.span);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  Set<String> categoryIds,  Set<String> currencyCodes,  TransactionType? type,  DateSpan? span)?  $default,) {final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
return $default(_that.query,_that.categoryIds,_that.currencyCodes,_that.type,_that.span);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionFilter extends TransactionFilter with DiagnosticableTreeMixin {
  const _TransactionFilter({this.query = '',  Set<String> categoryIds = const <String>{},  Set<String> currencyCodes = const <String>{}, this.type, this.span}): _categoryIds = categoryIds,_currencyCodes = currencyCodes,super._();
  

@override@JsonKey() final  String query;
 final  Set<String> _categoryIds;
@override@JsonKey() Set<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableSetView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_categoryIds);
}

 final  Set<String> _currencyCodes;
@override@JsonKey() Set<String> get currencyCodes {
  if (_currencyCodes is EqualUnmodifiableSetView) return _currencyCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_currencyCodes);
}

@override final  TransactionType? type;
@override final  DateSpan? span;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionFilterCopyWith<_TransactionFilter> get copyWith => __$TransactionFilterCopyWithImpl<_TransactionFilter>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'TransactionFilter'))
    ..add(DiagnosticsProperty('query', query))..add(DiagnosticsProperty('categoryIds', categoryIds))..add(DiagnosticsProperty('currencyCodes', currencyCodes))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('span', span));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionFilter&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.categoryIds, _categoryIds)&&const DeepCollectionEquality().equals(other.currencyCodes, _currencyCodes)&&(identical(other.type, type) || other.type == type)&&(identical(other.span, span) || other.span == span));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_categoryIds),const DeepCollectionEquality().hash(_currencyCodes),type,span);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'TransactionFilter(query: $query, categoryIds: $categoryIds, currencyCodes: $currencyCodes, type: $type, span: $span)';
}


}

/// @nodoc
abstract mixin class _$TransactionFilterCopyWith<$Res> implements $TransactionFilterCopyWith<$Res> {
  factory _$TransactionFilterCopyWith(_TransactionFilter value, $Res Function(_TransactionFilter) _then) = __$TransactionFilterCopyWithImpl;
@override @useResult
$Res call({
 String query, Set<String> categoryIds, Set<String> currencyCodes, TransactionType? type, DateSpan? span
});




}
/// @nodoc
class __$TransactionFilterCopyWithImpl<$Res>
    implements _$TransactionFilterCopyWith<$Res> {
  __$TransactionFilterCopyWithImpl(this._self, this._then);

  final _TransactionFilter _self;
  final $Res Function(_TransactionFilter) _then;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? categoryIds = null,Object? currencyCodes = null,Object? type = freezed,Object? span = freezed,}) {
  return _then(_TransactionFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,currencyCodes: null == currencyCodes ? _self._currencyCodes : currencyCodes // ignore: cast_nullable_to_non_nullable
as Set<String>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType?,span: freezed == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as DateSpan?,
  ));
}


}

// dart format on
