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
    return Column(
      children: [
        for (var element in widget.reservations)
          ReservationCard(
            reservation: element,
          ),
      ],
    );
  }
}
