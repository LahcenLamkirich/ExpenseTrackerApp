// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

/// ISO code of the home currency; null until onboarding picks one.
 String? get homeCurrencyCode;/// Monthly budget in home-currency minor units; null = no budget.
 int? get monthlyBudgetMinor; bool get budgetAlertEnabled; ThemeMode get themeMode;/// Language tag (`en`, `fr`, `ar`); null follows the device.
 String? get localeCode; bool get appLockEnabled; bool get onboardingCompleted;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.homeCurrencyCode, _this.homeCurrencyCode) || other.homeCurrencyCode == _this.homeCurrencyCode)&&(identical(other.monthlyBudgetMinor, _this.monthlyBudgetMinor) || other.monthlyBudgetMinor == _this.monthlyBudgetMinor)&&(identical(other.budgetAlertEnabled, _this.budgetAlertEnabled) || other.budgetAlertEnabled == _this.budgetAlertEnabled)&&(identical(other.themeMode, _this.themeMode) || other.themeMode == _this.themeMode)&&(identical(other.localeCode, _this.localeCode) || other.localeCode == _this.localeCode)&&(identical(other.appLockEnabled, _this.appLockEnabled) || other.appLockEnabled == _this.appLockEnabled)&&(identical(other.onboardingCompleted, _this.onboardingCompleted) || other.onboardingCompleted == _this.onboardingCompleted));
}


@override
int get hashCode {
  final _this = this as AppSettings;
  return Object.hash(runtimeType,_this.homeCurrencyCode,_this.monthlyBudgetMinor,_this.budgetAlertEnabled,_this.themeMode,_this.localeCode,_this.appLockEnabled,_this.onboardingCompleted);
}

@override
String toString() {
  final _this = this as AppSettings;
  return 'AppSettings(homeCurrencyCode: ${_this.homeCurrencyCode}, monthlyBudgetMinor: ${_this.monthlyBudgetMinor}, budgetAlertEnabled: ${_this.budgetAlertEnabled}, themeMode: ${_this.themeMode}, localeCode: ${_this.localeCode}, appLockEnabled: ${_this.appLockEnabled}, onboardingCompleted: ${_this.onboardingCompleted})';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 String? homeCurrencyCode, int? monthlyBudgetMinor, bool budgetAlertEnabled, ThemeMode themeMode, String? localeCode, bool appLockEnabled, bool onboardingCompleted
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? homeCurrencyCode = freezed,Object? monthlyBudgetMinor = freezed,Object? budgetAlertEnabled = null,Object? themeMode = null,Object? localeCode = freezed,Object? appLockEnabled = null,Object? onboardingCompleted = null,}) {
  return _then(AppSettings(
homeCurrencyCode: freezed == homeCurrencyCode ? _self.homeCurrencyCode : homeCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,monthlyBudgetMinor: freezed == monthlyBudgetMinor ? _self.monthlyBudgetMinor : monthlyBudgetMinor // ignore: cast_nullable_to_non_nullable
as int?,budgetAlertEnabled: null == budgetAlertEnabled ? _self.budgetAlertEnabled : budgetAlertEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,localeCode: freezed == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String?,appLockEnabled: null == appLockEnabled ? _self.appLockEnabled : appLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? homeCurrencyCode,  int? monthlyBudgetMinor,  bool budgetAlertEnabled,  ThemeMode themeMode,  String? localeCode,  bool appLockEnabled,  bool onboardingCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.homeCurrencyCode,_that.monthlyBudgetMinor,_that.budgetAlertEnabled,_that.themeMode,_that.localeCode,_that.appLockEnabled,_that.onboardingCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? homeCurrencyCode,  int? monthlyBudgetMinor,  bool budgetAlertEnabled,  ThemeMode themeMode,  String? localeCode,  bool appLockEnabled,  bool onboardingCompleted)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.homeCurrencyCode,_that.monthlyBudgetMinor,_that.budgetAlertEnabled,_that.themeMode,_that.localeCode,_that.appLockEnabled,_that.onboardingCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? homeCurrencyCode,  int? monthlyBudgetMinor,  bool budgetAlertEnabled,  ThemeMode themeMode,  String? localeCode,  bool appLockEnabled,  bool onboardingCompleted)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.homeCurrencyCode,_that.monthlyBudgetMinor,_that.budgetAlertEnabled,_that.themeMode,_that.localeCode,_that.appLockEnabled,_that.onboardingCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings extends AppSettings {
  const _AppSettings({this.homeCurrencyCode, this.monthlyBudgetMinor, this.budgetAlertEnabled = true, this.themeMode = ThemeMode.system, this.localeCode, this.appLockEnabled = false, this.onboardingCompleted = false}): super._();
  

/// ISO code of the home currency; null until onboarding picks one.
@override final  String? homeCurrencyCode;
/// Monthly budget in home-currency minor units; null = no budget.
@override final  int? monthlyBudgetMinor;
@override@JsonKey() final  bool budgetAlertEnabled;
@override@JsonKey() final  ThemeMode themeMode;
/// Language tag (`en`, `fr`, `ar`); null follows the device.
@override final  String? localeCode;
@override@JsonKey() final  bool appLockEnabled;
@override@JsonKey() final  bool onboardingCompleted;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.homeCurrencyCode, homeCurrencyCode) || other.homeCurrencyCode == homeCurrencyCode)&&(identical(other.monthlyBudgetMinor, monthlyBudgetMinor) || other.monthlyBudgetMinor == monthlyBudgetMinor)&&(identical(other.budgetAlertEnabled, budgetAlertEnabled) || other.budgetAlertEnabled == budgetAlertEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode)&&(identical(other.appLockEnabled, appLockEnabled) || other.appLockEnabled == appLockEnabled)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,homeCurrencyCode,monthlyBudgetMinor,budgetAlertEnabled,themeMode,localeCode,appLockEnabled,onboardingCompleted);
}

@override
String toString() {
    return 'AppSettings(homeCurrencyCode: $homeCurrencyCode, monthlyBudgetMinor: $monthlyBudgetMinor, budgetAlertEnabled: $budgetAlertEnabled, themeMode: $themeMode, localeCode: $localeCode, appLockEnabled: $appLockEnabled, onboardingCompleted: $onboardingCompleted)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 String? homeCurrencyCode, int? monthlyBudgetMinor, bool budgetAlertEnabled, ThemeMode themeMode, String? localeCode, bool appLockEnabled, bool onboardingCompleted
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? homeCurrencyCode = freezed,Object? monthlyBudgetMinor = freezed,Object? budgetAlertEnabled = null,Object? themeMode = null,Object? localeCode = freezed,Object? appLockEnabled = null,Object? onboardingCompleted = null,}) {
  return _then(_AppSettings(
homeCurrencyCode: freezed == homeCurrencyCode ? _self.homeCurrencyCode : homeCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,monthlyBudgetMinor: freezed == monthlyBudgetMinor ? _self.monthlyBudgetMinor : monthlyBudgetMinor // ignore: cast_nullable_to_non_nullable
as int?,budgetAlertEnabled: null == budgetAlertEnabled ? _self.budgetAlertEnabled : budgetAlertEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,localeCode: freezed == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String?,appLockEnabled: null == appLockEnabled ? _self.appLockEnabled : appLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
