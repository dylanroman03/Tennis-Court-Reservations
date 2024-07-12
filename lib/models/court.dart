const String createTableCourt = '''CREATE TABLE court (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  type char NOT NULL,
  imageUrl TEXT NOT NULL,
  priceByHour DECIMAL(4.2) NOT NULL
);''';

class CourtModel {
  CourtModel({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.priceByHour,
  });

  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final double priceByHour;

  factory CourtModel.fromJson(Map<String, dynamic> json) => CourtModel(
        id: int.tryParse(json['id'].toString()) ?? 0,
        name: json['name'],
        type: json['type'],
        imageUrl: json['imageUrl'],
        priceByHour: double.tryParse(json['priceByHour'].toString()) ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'imageUrl': imageUrl,
        'priceByHour': priceByHour
      };
}
