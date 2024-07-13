import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/bloc/reservation_bloc.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/models/reservation.dart';
import 'package:tennis/repositories/reservation/reservation_repository.dart';

class CourtDetailBloc extends Bloc<CourtDetailEvent, CourtDetailState> {
  final ReservationBloc reservationBloc;
  final ReservationRepository reservationRepository;

  CourtDetailBloc({
    required this.reservationBloc,
    required this.reservationRepository,
  }) : super(CourtDetailInitial()) {
    on<InitializeCourtDetail>(_onInitializeCourtDetail);
    on<CheckAvailabilityEvent>(_onCheckAvailability);
    on<AddReservationEvent>(_onAddReservation);
  }

  void _onInitializeCourtDetail(
    InitializeCourtDetail event,
    Emitter<CourtDetailState> emit,
  ) {
    try {
      ReservationState state = reservationBloc.state;

      if (state is ReservationLoaded) {
        final reservations = state.reservations
            .where((reservation) => reservation.idCourt == event.court.id)
            .toList();

        emit(CourtDetailLoaded(
          reservations: reservations,
          isAvailable: false,
          court: event.court,
        ));
      }
    } catch (e) {
      emit(CourtDetailError(error: e.toString()));
    }
  }

  void _onCheckAvailability(
    CheckAvailabilityEvent event,
    Emitter<CourtDetailState> emit,
  ) {
    try {
      final reservationsState = state;
      if (reservationsState is CourtDetailLoaded) {
        final reservations = reservationsState.reservations.where((element) {
          return element.date.year == event.date.year &&
              element.date.month == event.date.month &&
              element.date.day == event.date.day;
        }).toList();

        if (reservations.length < 3) {
          emit(
            CourtDetailLoaded(
              reservations: reservationsState.reservations,
              isAvailable: true,
              court: reservationsState.court,
            ),
          );
        } else {
          emit(
            CourtDetailLoaded(
              reservations: reservationsState.reservations,
              isAvailable: false,
              court: reservationsState.court,
            ),
          );
        }
      } else {
        emit(
          CourtDetailError(error: 'Court details not initialized properly.'),
        );
      }
    } catch (e) {
      emit(CourtDetailError(error: e.toString()));
    }
  }

  Future<void> _onAddReservation(
    AddReservationEvent event,
    Emitter<CourtDetailState> emit,
  ) async {
    try {
      final reservationsState = state;
      if (reservationsState is CourtDetailLoaded) {
        await reservationRepository.save(event.reservation);
        emit(ReservationSuccess());
      } else {
        emit(
          CourtDetailError(error: 'Court details not initialized properly.'),
        );
      }
    } catch (e) {
      emit(CourtDetailError(error: e.toString()));
    }
  }
}

// Events
abstract class CourtDetailEvent {}

class InitializeCourtDetail extends CourtDetailEvent {
  final CourtModel court;

  InitializeCourtDetail({required this.court});
}

class CheckAvailabilityEvent extends CourtDetailEvent {
  final DateTime date;

  CheckAvailabilityEvent({required this.date});
}

class AddReservationEvent extends CourtDetailEvent {
  final ReservationModel reservation;

  AddReservationEvent({required this.reservation});
}

// States for CourtDetailBloc
abstract class CourtDetailState {}

class CourtDetailInitial extends CourtDetailState {}

class CourtDetailLoaded extends CourtDetailState {
  final List<ReservationModel> reservations;
  final bool isAvailable;
  final CourtModel court;

  CourtDetailLoaded({
    required this.court,
    required this.reservations,
    required this.isAvailable,
  });
}

class ReservationSuccess extends CourtDetailState {}

class CourtDetailError extends CourtDetailState {
  final String error;

  CourtDetailError({required this.error});
}
