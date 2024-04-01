import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/src/config/config.dart';

import 'package:weather/src/core/core.dart';
import 'package:weather/src/features/home/domain/models/models.dart';
import 'ihome_repository.dart';

final homeRepoProvider = Provider.autoDispose<IHomeRepository>((ref) {
  return HomeRepository(
    ref.read(apiProvider),
  );
});

class HomeRepository implements IHomeRepository {
  final RestClientDio _api;

  HomeRepository(this._api);

  @override
  Future<WeatherModel> fetchWeather(String cityName) async {
    try {
      final result = await _api.get(
        ApiPath.weatherApi,
        '',
        queryParameters: {
          'q': cityName,
          'units': WeatherUnitEnum.metric.name,
        },
      );
      final weatherModel = WeatherModel.fromJson(result.data);
      // final weatherModel =
      //     WeatherModel.fromJson(jsonDecode(AppStrings.resultJson));
      return weatherModel;
    } on DioException catch (e) {
      throw e.handleFailure();
    }
  }
}
