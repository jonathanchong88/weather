import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/src/features/home/controller/home_controller.dart';
import 'package:weather/src/features/home/domain/models/models.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<WeatherModel?>>(asyncWeatherProvider, (_, state) {
      state.maybeMap(
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.error.toString()),
              ),
            );
          },
          orElse: () => {});
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Search"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(asyncWeatherProvider);

            return state.maybeWhen(
              data: (WeatherModel? weather) {
                if (weather == null) {
                  return buildInitialInput();
                }

                return buildColumnWithData(context, weather);
              },
              error: (error, _) {
                return buildInitialInput();
              },
              loading: () => buildLoading(),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return const Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, WeatherModel weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.name,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.main.temp.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        Text(
          // Display the temperature with 1 decimal place
          weather.weather.first.main,
          style: TextStyle(fontSize: 60),
        ),
        CircleAvatar(
          radius: 70,
          child: Image.network(weather.weather.first.iconUrl),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends ConsumerWidget {
  const CityInputField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(ref, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(WidgetRef ref, String cityName) {
    ref.read(asyncWeatherProvider.notifier).getWeather(cityName);
  }
}
