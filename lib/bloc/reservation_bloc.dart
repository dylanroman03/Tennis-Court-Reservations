import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/models/reservation.dart';
import 'package:tennis/repositories/reservation/reservation_repository.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository reservationRepository;

  ReservationBloc({required this.reservationRepository})
      : super(ReservationInitial()) {
    on<GetReservations>(_onGetReservations);
    on<DeleteReservation>(_onDeleteReservation);
  }

  void _onGetReservations(
    GetReservations event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      final reservations = await reservationRepository.getAllReservations();
      emit(ReservationLoaded(reservations: reservations));
    } catch (e) {
      log("Error $e");
      emit(ReservationError(message: e.toString()));
    }
  }

  Future<void> _onDeleteReservation(
    DeleteReservation event,
    Emitter<ReservationState> emit,
  ) async {
    final id = event.idReservation;
    await reservationRepository.delete(id);
    add(GetReservations());
  }
}

// Events
abstract class ReservationEvent {}

class GetReservations extends ReservationEvent {}

class DeleteReservation extends ReservationEvent {
  final int idReservation;

  DeleteReservation({required this.idReservation});
}

// States
abstract class ReservationState {}

class ReservationInitial extends ReservationState {}

class ReservationLoaded extends ReservationState {
  final List<ReservationModel> reservations;

  ReservationLoaded({required this.reservations});
}

// class ReservationDeleted extends ReservationState {}

class ReservationError extends ReservationState {
  final String message;

  ReservationError({required this.message});
}
