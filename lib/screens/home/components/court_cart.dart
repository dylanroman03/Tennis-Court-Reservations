import 'package:flutter/material.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/screens/components/rounded_buttom.dart';
import 'package:tennis/screens/court-detail/court_detail_screen.dart';

class CourtCard extends StatelessWidget {
  const CourtCard({required this.court, super.key});
  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(court.imageUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  court.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.01),
                  child: Text("Cancha Tipo: ${court.type}"),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.01),
                  child: const Text(
                    'Disponible: ',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  width: size.width * 0.4,
                  child: RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourtDetailScreen(
                            court: court,
                          ),
                        ),
                      );
                    },
                    text: 'Reservar',
                    color: const Color.fromARGB(255, 170, 247, 36),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
