import 'package:tennis/models/court.dart';

abstract class CourtRepository {
  Future<List<CourtModel>> getAllCourts();
  Future<bool> saveCourt(CourtModel court);
}
