import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/repositories/court/court_repository.dart';

class CourtBloc extends Bloc<CourtEvent, CourtState> {
  final CourtRepository courtRepository;

  CourtBloc({required this.courtRepository}) : super(CourtInitial()) {
    on<GetCourts>(_onGetCourts);
    on<SaveCourts>(_onSaveCourts);
  }

  void _onGetCourts(GetCourts event, Emitter<CourtState> emit) async {
    try {
      final courts = await courtRepository.getAllCourts();
      emit(CourtLoaded(courts: courts));
    } catch (e) {
      emit(CourtError(message: e.toString()));
    }
  }

  void _onSaveCourts(SaveCourts event, Emitter<CourtState> emit) async {
    try {
      // Simulate a data to be saved
      List<CourtModel> courts = [
        CourtModel(
          id: 1,
          name: 'Epic Box',
          type: 'A',
          imageUrl: 'assets/Enmascarar.png',
          priceByHour: 25,
        ),
        CourtModel(
          id: 2,
          name: 'Sport Box',
          type: 'B',
          imageUrl: 'assets/Enmascarar.png',
          priceByHour: 20,
        ),
        CourtModel(
          id: 3,
          name: 'Cacha Multiple',
          type: 'C',
          imageUrl: 'assets/Enmascarar.png',
          priceByHour: 30,
        ),
      ];

      for (var court in courts) {
        await courtRepository.saveCourt(court);
      }

      emit(CourtsSaved());
    } catch (e) {
      log("Error: $e");
      emit(CourtError(message: e.toString()));
    }
  }
}

// Events
abstract class CourtEvent {}

class GetCourts extends CourtEvent {}

class SaveCourts extends CourtEvent {}

// States
abstract class CourtState {}

class CourtInitial extends CourtState {}

class CourtsSaved extends CourtState {}

class CourtLoaded extends CourtState {
  final List<CourtModel> courts;

  CourtLoaded({required this.courts});
}

class CourtError extends CourtState {
  final String message;

  CourtError({required this.message});
}
