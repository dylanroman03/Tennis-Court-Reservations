import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tennis/repositories/wheater/wheater_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl();

  @override
  Future<int> getRainProbability(DateTime date) async {
    const apiKey = '83415389bbdc60c7a39a430025d1be0b';
    const lat = 39.099724;
    const lon = -94.578331;

    String url = "https://api.openweathermap.org/data/2.5/forecast";
    url += "?lat=$lat&lon=$lon&appid=$apiKey";

    final resp = await http.get(Uri.parse(url));
    double rainProbability = 0;

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      for (var element in data["list"]) {
        DateTime dateElement = DateTime.parse(element["dt_txt"]);
        if (dateElement.day == date.day &&
            dateElement.month == date.month &&
            dateElement.year == date.year) {
          rainProbability = element["pop"] * 100.00;
          if (rainProbability > 0) {
            break;
          }
        }
      }

      return rainProbability.toInt();
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
