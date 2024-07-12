import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/repositories/court/court_repository.dart';

class CourtBloc extends Bloc<CourtEvent, CourtState> {
  final CourtRepository courtRepository;

  CourtBloc({required this.courtRepository}) : super(CourtInitial()) {
    on<FetchCourts>(_onFetchCourts);
  }

  void _onFetchCourts(FetchCourts event, Emitter<CourtState> emit) async {
    emit(CourtLoading());
    try {
      final courts = await courtRepository.getAllCourts();
      emit(CourtLoaded(courts: courts));
    } catch (e) {
      emit(CourtError(message: e.toString()));
    }
  }
}

// Events
abstract class CourtEvent {}

class FetchCourts extends CourtEvent {}

// States
abstract class CourtState {}

class CourtInitial extends CourtState {}

class CourtLoading extends CourtState {}

class CourtLoaded extends CourtState {
  final List<CourtModel> courts;

  CourtLoaded({required this.courts});
}

class CourtError extends CourtState {
  final String message;

  CourtError({required this.message});
}
