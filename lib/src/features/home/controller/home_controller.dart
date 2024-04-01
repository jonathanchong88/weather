import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather/src/features/home/data/repositories/home_repository.dart';
import 'package:weather/src/features/home/domain/models/models.dart';

part 'home_controller.g.dart';

@riverpod
class AsyncWeather extends _$AsyncWeather {
  @override
  FutureOr<WeatherModel?> build() async {
    return null;
  }

  //
  Future<void> getWeather(String cityName) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final weather = await ref.read(homeRepoProvider).fetchWeather(cityName);
      print(weather.toJson());
      return weather;
    });
  }
  //
  // Future<void> getDetailedWeather(String cityName) async {
  //   state = AsyncValue.loading();
  //
  //   state = await AsyncValue.guard(() async {
  //     final weather = await ref
  //         .watch(weatherRepositoryProvider)
  //         .fetchDetailedWeather(cityName);
  //
  //     return weather;
  //   });
  // }
}
