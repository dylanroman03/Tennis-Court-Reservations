import 'package:tennis/models/reservation.dart';

abstract class ReservationRepository {
  Future<bool> save(ReservationModel reservation);
  Future<bool> delete(int id);
  Future<List<ReservationModel>> getAllReservations();
}
