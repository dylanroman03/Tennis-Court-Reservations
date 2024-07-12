import 'package:flutter/material.dart';
import 'package:tennis/models/reservation.dart';

class ReservationCard extends StatelessWidget {
  final ReservationModel reservation;

  const ReservationCard({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cancha ${reservation.idCourt}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Reservado por: ${reservation.reservedBy}'),
            Text('Fecha: ${reservation.date}'),
            Text('Horas: ${reservation.hours}'),
            Text('Precio: \$${reservation.price}'),
          ],
        ),
      ),
    );
  }
}
