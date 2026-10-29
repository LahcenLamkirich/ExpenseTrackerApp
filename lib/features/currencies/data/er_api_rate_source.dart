import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:flossi/features/currencies/domain/remote_rate_source.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'er_api_rate_source.g.dart';

/// https://open.er-api.com — free, no API key, includes MAD.
class ErApiRateSource implements RemoteRateSource {
  ErApiRateSource(this._client, {Uri? baseUri, this.timeout = const Duration(seconds: 10)})
    : _baseUri = baseUri ?? Uri.parse('https://open.er-api.com/v6/latest/');

  final http.Client _client;
  final Uri _baseUri;
  final Duration timeout;

  static const providerId = 'open.er-api.com';

  @override
  Future<RemoteRates> fetchLatest(String base) async {
    final uri = _baseUri.resolve(base.toUpperCase());
    final response = await _client.get(uri).timeout(timeout);
    if (response.statusCode != 200) {
      throw RateFetchException('HTTP ${response.statusCode}');
    }
    final json = jsonDecode(response.body);
    if (json is! Map<String, dynamic>) throw const RateFetchException('Malformed body');
    final dto = ErApiResponse.fromJson(json);
    if (dto.result != 'success' || dto.rates == null || dto.baseCode == null) {
      throw RateFetchException(dto.errorType ?? 'Unexpected response');
    }
    return RemoteRates(
      base: dto.baseCode!,
      provider: providerId,
      providerUpdatedAt: dto.timeLastUpdateUnix == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(dto.timeLastUpdateUnix! * 1000, isUtc: true).toLocal(),
      rates: {
        for (final MapEntry(:key, :value) in dto.rates!.entries)
          // JSON numbers arrive as num; their shortest string form is the
          // provider's exact decimal, so parse that (never compute in double).
          if (value > 0) key.toUpperCase(): Decimal.parse(value.toString()),
      },
    );
  }
}

@JsonSerializable(createToJson: false)
class ErApiResponse {
  const ErApiResponse({this.result, this.baseCode, this.timeLastUpdateUnix, this.rates, this.errorType});

  factory ErApiResponse.fromJson(Map<String, dynamic> json) => _$ErApiResponseFromJson(json);

  final String? result;
  @JsonKey(name: 'base_code')
  final String? baseCode;
  @JsonKey(name: 'time_last_update_unix')
  final int? timeLastUpdateUnix;
  final Map<String, num>? rates;
  @JsonKey(name: 'error-type')
  final String? errorType;
}
