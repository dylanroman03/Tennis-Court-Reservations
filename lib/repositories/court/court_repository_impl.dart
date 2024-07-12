import 'package:tennis/database/database_provider.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/repositories/court/court_repository.dart';

class CourtRepositoryImpl implements CourtRepository {
  final DatabaseProvider db;

  CourtRepositoryImpl({required this.db});

  @override
  Future<bool> saveCourt(CourtModel court) async {
    int savedRows = await db.executeInsert(
      '''INSERT INTO court  (id, name, type, imageUrl, priceByHour) 
      VALUES (?, ?, ?, ?, ?)''',
      [
        court.id,
        court.name,
        court.type,
        court.imageUrl,
        court.priceByHour,
      ],
    );

    return savedRows > 0;
  }

  @override
  Future<List<CourtModel>> getAllCourts() async {
    List<Map<String, dynamic>> resp;
    resp = await db.executeQuery("SELECT * FROM court");

    return resp.map((e) => CourtModel.fromJson(e)).toList();
  }
}
