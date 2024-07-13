import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/blocs/court_bloc.dart';
import 'package:tennis/blocs/reservation_bloc.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/models/reservation.dart';
import 'package:tennis/screens/components/rounded_buttom.dart';

class ReservationCard extends StatelessWidget {
  final ReservationModel reservation;

  const ReservationCard({
    super.key,
    required this.reservation,
  });

  void confirmDelete(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Estas Seguro'),
          content: const Text('Seguro que desea eliminar esta reservación'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => deleteReservation(context),
              child: const Text('Sí'),
            ),
            CupertinoDialogAction(
              child: const Text('No'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  deleteReservation(BuildContext context) {
    BlocProvider.of<ReservationBloc>(context)
        .add(DeleteReservation(idReservation: reservation.id));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourtBloc, CourtState>(
      builder: (context, state) {
        if (state is CourtLoaded) {
          log(state.courts.toString());

          CourtModel court =
              state.courts.where((e) => reservation.idCourt == e.id).first;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cancha ${court.name}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Reservado por: ${reservation.reservedBy}'),
                  Text('Fecha: ${reservation.date}'),
                  Text('Horas: ${reservation.hours}'),
                  Text('Precio: \$${reservation.price}'),
                  RoundedButton(
                    text: "Delete",
                    color: Colors.red.shade400,
                    onPressed: () {
                      confirmDelete(context);
                    },
                  )
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
