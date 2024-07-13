import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<CourtBloc, CourtState>(
      builder: (context, state) {
        if (state is CourtLoaded) {
          CourtModel court =
              state.courts.where((e) => reservation.idCourt == e.id).first;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: size.width * 0.05),
                        child: Image.asset(
                          court.imageUrl,
                          height: size.width * 0.1,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            court.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Reservado por: ${reservation.reservedBy}'),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 18),
                              Text(
                                DateFormat('d-mm-yy').format(reservation.date),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined, size: 18),
                              Text(
                                '${reservation.hours} Horas  |  \$${reservation.price}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.width * 0.05,
                      bottom: size.width * 0.03,
                    ),
                    width: size.width * 0.6,
                    child: RoundedButton(
                      text: "Delete",
                      color: Colors.red.shade400,
                      onPressed: () {
                        confirmDelete(context);
                      },
                    ),
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
