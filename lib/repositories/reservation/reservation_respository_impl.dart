import 'package:tennis/database/database_provider.dart';
import 'package:tennis/models/reservation.dart';
import 'package:tennis/repositories/reservation/reservation_repository.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  DatabaseProvider db = DatabaseProvider.instance;
  ReservationRepositoryImpl();

  @override
  Future<bool> save(ReservationModel reservation) async {
    int savedRows = await db.executeInsert(
      '''INSERT INTO reservation (id, idCourt, date, reservedBy, hours, price) 
      VALUES (?, ?, ?, ?, ?, ?)''',
      [
        reservation.id,
        reservation.idCourt,
        reservation.date.toIso8601String(),
        reservation.reservedBy,
        reservation.hours,
        reservation.price,
      ],
    );

    return savedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    int deletedRows = await db.executeDelete(
      'DELETE FROM reservation WHERE id = ?',
      items: [id],
    );

    return deletedRows > 0;
  }

  @override
  Future<List<ReservationModel>> getAllReservations() async {
    List<Map<String, dynamic>> resp;
    resp = await db.executeQuery('SELECT * FROM reservation ORDER BY date');

    return resp.map((e) => ReservationModel.fromJson(e)).toList();
  }
}
