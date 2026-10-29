// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'er_api_rate_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErApiResponse _$ErApiResponseFromJson(Map<String, dynamic> json) =>
    ErApiResponse(
      result: json['result'] as String?,
      baseCode: json['base_code'] as String?,
      timeLastUpdateUnix: (json['time_last_update_unix'] as num?)?.toInt(),
      rates: (json['rates'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as num),
      ),
      errorType: json['error-type'] as String?,
    );
