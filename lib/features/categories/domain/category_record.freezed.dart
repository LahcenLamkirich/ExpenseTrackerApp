// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryRecord {

 String get id; String get glyph; int get colorValue; CategoryKind get kind; String? get nameKey; String? get name; int? get monthlyCapMinor; int get sortOrder; bool get isArchived;
/// Create a copy of CategoryRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryRecordCopyWith<CategoryRecord> get copyWith => _$CategoryRecordCopyWithImpl<CategoryRecord>(this as CategoryRecord, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryRecord&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.glyph, _this.glyph) || other.glyph == _this.glyph)&&(identical(other.colorValue, _this.colorValue) || other.colorValue == _this.colorValue)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.nameKey, _this.nameKey) || other.nameKey == _this.nameKey)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.monthlyCapMinor, _this.monthlyCapMinor) || other.monthlyCapMinor == _this.monthlyCapMinor)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.isArchived, _this.isArchived) || other.isArchived == _this.isArchived));
}


@override
int get hashCode {
  final _this = this as CategoryRecord;
  return Object.hash(runtimeType,_this.id,_this.glyph,_this.colorValue,_this.kind,_this.nameKey,_this.name,_this.monthlyCapMinor,_this.sortOrder,_this.isArchived);
}

@override
String toString() {
  final _this = this as CategoryRecord;
  return 'CategoryRecord(id: ${_this.id}, glyph: ${_this.glyph}, colorValue: ${_this.colorValue}, kind: ${_this.kind}, nameKey: ${_this.nameKey}, name: ${_this.name}, monthlyCapMinor: ${_this.monthlyCapMinor}, sortOrder: ${_this.sortOrder}, isArchived: ${_this.isArchived})';
}


}

/// @nodoc
abstract mixin class $CategoryRecordCopyWith<$Res>  {
  factory $CategoryRecordCopyWith(CategoryRecord value, $Res Function(CategoryRecord) _then) = _$CategoryRecordCopyWithImpl;
@useResult
$Res call({
 String id, String glyph, int colorValue, CategoryKind kind, String? nameKey, String? name, int? monthlyCapMinor, int sortOrder, bool isArchived
});




}
/// @nodoc
class _$CategoryRecordCopyWithImpl<$Res>
    implements $CategoryRecordCopyWith<$Res> {
  _$CategoryRecordCopyWithImpl(this._self, this._then);

  final CategoryRecord _self;
  final $Res Function(CategoryRecord) _then;

/// Create a copy of CategoryRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? glyph = null,Object? colorValue = null,Object? kind = null,Object? nameKey = freezed,Object? name = freezed,Object? monthlyCapMinor = freezed,Object? sortOrder = null,Object? isArchived = null,}) {
  return _then(CategoryRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,glyph: null == glyph ? _self.glyph : glyph // ignore: cast_nullable_to_non_nullable
as String,colorValue: null == colorValue ? _self.colorValue : colorValue // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CategoryKind,nameKey: freezed == nameKey ? _self.nameKey : nameKey // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,monthlyCapMinor: freezed == monthlyCapMinor ? _self.monthlyCapMinor : monthlyCapMinor // ignore: cast_nullable_to_non_nullable
as int?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryRecord].
extension CategoryRecordPatterns on CategoryRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryRecord value)  $default,){
final _that = this;
switch (_that) {
case _CategoryRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryRecord value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String glyph,  int colorValue,  CategoryKind kind,  String? nameKey,  String? name,  int? monthlyCapMinor,  int sortOrder,  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryRecord() when $default != null:
return $default(_that.id,_that.glyph,_that.colorValue,_that.kind,_that.nameKey,_that.name,_that.monthlyCapMinor,_that.sortOrder,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String glyph,  int colorValue,  CategoryKind kind,  String? nameKey,  String? name,  int? monthlyCapMinor,  int sortOrder,  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _CategoryRecord():
return $default(_that.id,_that.glyph,_that.colorValue,_that.kind,_that.nameKey,_that.name,_that.monthlyCapMinor,_that.sortOrder,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String glyph,  int colorValue,  CategoryKind kind,  String? nameKey,  String? name,  int? monthlyCapMinor,  int sortOrder,  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _CategoryRecord() when $default != null:
return $default(_that.id,_that.glyph,_that.colorValue,_that.kind,_that.nameKey,_that.name,_that.monthlyCapMinor,_that.sortOrder,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryRecord extends CategoryRecord {
  const _CategoryRecord({required this.id, required this.glyph, required this.colorValue, required this.kind, this.nameKey, this.name, this.monthlyCapMinor, this.sortOrder = 0, this.isArchived = false}): super._();
  

@override final  String id;
@override final  String glyph;
@override final  int colorValue;
@override final  CategoryKind kind;
@override final  String? nameKey;
@override final  String? name;
@override final  int? monthlyCapMinor;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  bool isArchived;

/// Create a copy of CategoryRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryRecordCopyWith<_CategoryRecord> get copyWith => __$CategoryRecordCopyWithImpl<_CategoryRecord>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.glyph, glyph) || other.glyph == glyph)&&(identical(other.colorValue, colorValue) || other.colorValue == colorValue)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.nameKey, nameKey) || other.nameKey == nameKey)&&(identical(other.name, name) || other.name == name)&&(identical(other.monthlyCapMinor, monthlyCapMinor) || other.monthlyCapMinor == monthlyCapMinor)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,glyph,colorValue,kind,nameKey,name,monthlyCapMinor,sortOrder,isArchived);
}

@override
String toString() {
    return 'CategoryRecord(id: $id, glyph: $glyph, colorValue: $colorValue, kind: $kind, nameKey: $nameKey, name: $name, monthlyCapMinor: $monthlyCapMinor, sortOrder: $sortOrder, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$CategoryRecordCopyWith<$Res> implements $CategoryRecordCopyWith<$Res> {
  factory _$CategoryRecordCopyWith(_CategoryRecord value, $Res Function(_CategoryRecord) _then) = __$CategoryRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String glyph, int colorValue, CategoryKind kind, String? nameKey, String? name, int? monthlyCapMinor, int sortOrder, bool isArchived
});




}
/// @nodoc
class __$CategoryRecordCopyWithImpl<$Res>
    implements _$CategoryRecordCopyWith<$Res> {
  __$CategoryRecordCopyWithImpl(this._self, this._then);

  final _CategoryRecord _self;
  final $Res Function(_CategoryRecord) _then;

/// Create a copy of CategoryRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? glyph = null,Object? colorValue = null,Object? kind = null,Object? nameKey = freezed,Object? name = freezed,Object? monthlyCapMinor = freezed,Object? sortOrder = null,Object? isArchived = null,}) {
  return _then(_CategoryRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,glyph: null == glyph ? _self.glyph : glyph // ignore: cast_nullable_to_non_nullable
as String,colorValue: null == colorValue ? _self.colorValue : colorValue // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CategoryKind,nameKey: freezed == nameKey ? _self.nameKey : nameKey // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,monthlyCapMinor: freezed == monthlyCapMinor ? _self.monthlyCapMinor : monthlyCapMinor // ignore: cast_nullable_to_non_nullable
as int?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
