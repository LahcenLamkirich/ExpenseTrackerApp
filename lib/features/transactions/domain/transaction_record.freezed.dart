// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionRecord {

 String get id; TransactionType get type; Money get amount; Decimal get fxRate; Money get homeAmount; RateSource get rateSource; String get categoryId; PaymentMethod get paymentMethod; DateTime get date; DateTime get createdAt; DateTime get updatedAt; String? get title; String? get note;
/// Create a copy of TransactionRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionRecordCopyWith<TransactionRecord> get copyWith => _$TransactionRecordCopyWithImpl<TransactionRecord>(this as TransactionRecord, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransactionRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionRecord&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.fxRate, _this.fxRate) || other.fxRate == _this.fxRate)&&(identical(other.homeAmount, _this.homeAmount) || other.homeAmount == _this.homeAmount)&&(identical(other.rateSource, _this.rateSource) || other.rateSource == _this.rateSource)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as TransactionRecord;
  return Object.hash(runtimeType,_this.id,_this.type,_this.amount,_this.fxRate,_this.homeAmount,_this.rateSource,_this.categoryId,_this.paymentMethod,_this.date,_this.createdAt,_this.updatedAt,_this.title,_this.note);
}

@override
String toString() {
  final _this = this as TransactionRecord;
  return 'TransactionRecord(id: ${_this.id}, type: ${_this.type}, amount: ${_this.amount}, fxRate: ${_this.fxRate}, homeAmount: ${_this.homeAmount}, rateSource: ${_this.rateSource}, categoryId: ${_this.categoryId}, paymentMethod: ${_this.paymentMethod}, date: ${_this.date}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, title: ${_this.title}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $TransactionRecordCopyWith<$Res>  {
  factory $TransactionRecordCopyWith(TransactionRecord value, $Res Function(TransactionRecord) _then) = _$TransactionRecordCopyWithImpl;
@useResult
$Res call({
 String id, TransactionType type, Money amount, Decimal fxRate, Money homeAmount, RateSource rateSource, String categoryId, PaymentMethod paymentMethod, DateTime date, DateTime createdAt, DateTime updatedAt, String? title, String? note
});




}
/// @nodoc
class _$TransactionRecordCopyWithImpl<$Res>
    implements $TransactionRecordCopyWith<$Res> {
  _$TransactionRecordCopyWithImpl(this._self, this._then);

  final TransactionRecord _self;
  final $Res Function(TransactionRecord) _then;

/// Create a copy of TransactionRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? fxRate = null,Object? homeAmount = null,Object? rateSource = null,Object? categoryId = null,Object? paymentMethod = null,Object? date = null,Object? createdAt = null,Object? updatedAt = null,Object? title = freezed,Object? note = freezed,}) {
  return _then(TransactionRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,fxRate: null == fxRate ? _self.fxRate : fxRate // ignore: cast_nullable_to_non_nullable
as Decimal,homeAmount: null == homeAmount ? _self.homeAmount : homeAmount // ignore: cast_nullable_to_non_nullable
as Money,rateSource: null == rateSource ? _self.rateSource : rateSource // ignore: cast_nullable_to_non_nullable
as RateSource,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionRecord].
extension TransactionRecordPatterns on TransactionRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionRecord value)  $default,){
final _that = this;
switch (_that) {
case _TransactionRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionRecord value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TransactionType type,  Money amount,  Decimal fxRate,  Money homeAmount,  RateSource rateSource,  String categoryId,  PaymentMethod paymentMethod,  DateTime date,  DateTime createdAt,  DateTime updatedAt,  String? title,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionRecord() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.fxRate,_that.homeAmount,_that.rateSource,_that.categoryId,_that.paymentMethod,_that.date,_that.createdAt,_that.updatedAt,_that.title,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TransactionType type,  Money amount,  Decimal fxRate,  Money homeAmount,  RateSource rateSource,  String categoryId,  PaymentMethod paymentMethod,  DateTime date,  DateTime createdAt,  DateTime updatedAt,  String? title,  String? note)  $default,) {final _that = this;
switch (_that) {
case _TransactionRecord():
return $default(_that.id,_that.type,_that.amount,_that.fxRate,_that.homeAmount,_that.rateSource,_that.categoryId,_that.paymentMethod,_that.date,_that.createdAt,_that.updatedAt,_that.title,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TransactionType type,  Money amount,  Decimal fxRate,  Money homeAmount,  RateSource rateSource,  String categoryId,  PaymentMethod paymentMethod,  DateTime date,  DateTime createdAt,  DateTime updatedAt,  String? title,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TransactionRecord() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.fxRate,_that.homeAmount,_that.rateSource,_that.categoryId,_that.paymentMethod,_that.date,_that.createdAt,_that.updatedAt,_that.title,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionRecord extends TransactionRecord {
  const _TransactionRecord({required this.id, required this.type, required this.amount, required this.fxRate, required this.homeAmount, required this.rateSource, required this.categoryId, required this.paymentMethod, required this.date, required this.createdAt, required this.updatedAt, this.title, this.note}): super._();
  

@override final  String id;
@override final  TransactionType type;
@override final  Money amount;
@override final  Decimal fxRate;
@override final  Money homeAmount;
@override final  RateSource rateSource;
@override final  String categoryId;
@override final  PaymentMethod paymentMethod;
@override final  DateTime date;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? title;
@override final  String? note;

/// Create a copy of TransactionRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionRecordCopyWith<_TransactionRecord> get copyWith => __$TransactionRecordCopyWithImpl<_TransactionRecord>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fxRate, fxRate) || other.fxRate == fxRate)&&(identical(other.homeAmount, homeAmount) || other.homeAmount == homeAmount)&&(identical(other.rateSource, rateSource) || other.rateSource == rateSource)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,type,amount,fxRate,homeAmount,rateSource,categoryId,paymentMethod,date,createdAt,updatedAt,title,note);
}

@override
String toString() {
    return 'TransactionRecord(id: $id, type: $type, amount: $amount, fxRate: $fxRate, homeAmount: $homeAmount, rateSource: $rateSource, categoryId: $categoryId, paymentMethod: $paymentMethod, date: $date, createdAt: $createdAt, updatedAt: $updatedAt, title: $title, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TransactionRecordCopyWith<$Res> implements $TransactionRecordCopyWith<$Res> {
  factory _$TransactionRecordCopyWith(_TransactionRecord value, $Res Function(_TransactionRecord) _then) = __$TransactionRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, TransactionType type, Money amount, Decimal fxRate, Money homeAmount, RateSource rateSource, String categoryId, PaymentMethod paymentMethod, DateTime date, DateTime createdAt, DateTime updatedAt, String? title, String? note
});




}
/// @nodoc
class __$TransactionRecordCopyWithImpl<$Res>
    implements _$TransactionRecordCopyWith<$Res> {
  __$TransactionRecordCopyWithImpl(this._self, this._then);

  final _TransactionRecord _self;
  final $Res Function(_TransactionRecord) _then;

/// Create a copy of TransactionRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? fxRate = null,Object? homeAmount = null,Object? rateSource = null,Object? categoryId = null,Object? paymentMethod = null,Object? date = null,Object? createdAt = null,Object? updatedAt = null,Object? title = freezed,Object? note = freezed,}) {
  return _then(_TransactionRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,fxRate: null == fxRate ? _self.fxRate : fxRate // ignore: cast_nullable_to_non_nullable
as Decimal,homeAmount: null == homeAmount ? _self.homeAmount : homeAmount // ignore: cast_nullable_to_non_nullable
as Money,rateSource: null == rateSource ? _self.rateSource : rateSource // ignore: cast_nullable_to_non_nullable
as RateSource,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
