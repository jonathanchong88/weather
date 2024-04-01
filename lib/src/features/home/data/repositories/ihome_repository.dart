import 'package:weather/src/features/home/domain/models/models.dart';

abstract class IHomeRepository {
  Future<WeatherModel> fetchWeather(String cityName);
}
