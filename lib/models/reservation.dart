const String createTableReservation =
    '''CREATE TABLE IF NOT EXISTS reservation (
  id INTEGER PRIMARY KEY,
  idCourt INTEGER NOT NULL,
  date DATETIME NOT NULL,
  reservedBy TEXT NOT NULL,
  hours INTEGER NOT NULL,
  price DECIMAL(4.2) NOT NULL
)''';

class ReservationModel {
  final int id;
  final int idCourt;
  final DateTime date;
  final String reservedBy;
  final int hours;
  final double price;

  ReservationModel({
    required this.id,
    required this.idCourt,
    required this.date,
    required this.reservedBy,
    required this.hours,
    required this.price,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> e) => ReservationModel(
        id: int.tryParse(e['id'].toString()) ?? 0,
        idCourt: int.tryParse(e['idCourt'].toString()) ?? 0,
        date: DateTime.parse(e['date']),
        reservedBy: e['reservedBy'],
        hours: int.tryParse(e['hours'].toString()) ?? 0,
        price: double.tryParse(e['price'].toString()) ?? 0.00,
      );
}
