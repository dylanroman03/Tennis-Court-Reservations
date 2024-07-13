// weather_bloc.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/repositories/wheater/wheater_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      log("Inside");
      final probability =
          await weatherRepository.getRainProbability(event.date);

      log("Probability $probability");
      emit(WeatherLoaded(rainProbability: probability));
    } catch (e) {
      log("error $e");
      emit(WeatherError(message: e.toString()));
    }
  }
}

// Events
abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final DateTime date;

  FetchWeather({required this.date});
}

// States
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final int rainProbability;

  WeatherLoaded({required this.rainProbability});
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}
