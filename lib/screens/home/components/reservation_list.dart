import 'package:flutter/material.dart';
import 'package:tennis/models/reservation.dart';
import 'package:tennis/screens/home/components/reservation_cart.dart';

class ReservationList extends StatefulWidget {
  final List<ReservationModel> reservations;

  const ReservationList({super.key, required this.reservations});

  @override
  State<ReservationList> createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.reservations.isEmpty
        ? Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
              top: size.height * 0.01,
            ),
            child: const Text("No has reservado aún"),
          )
        : Column(
            children: [
              for (var element in widget.reservations)
                SizedBox(
                  width: size.width,
                  child: ReservationCard(
                    reservation: element,
                  ),
                ),
            ],
          );
  }
}
