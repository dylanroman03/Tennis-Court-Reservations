import 'package:tennis/models/reservation.dart';

abstract class ReservationRepository {
  Future<bool> save(ReservationModel reservation);
  Future<bool> delete(ReservationModel reservation);
  Future<List<ReservationModel>> getAllReservations();
}
