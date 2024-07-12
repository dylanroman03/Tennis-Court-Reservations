import 'package:flutter/material.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/screens/home/components/court_cart.dart';

class CourtList extends StatefulWidget {
  final List<CourtModel> courts;

  const CourtList({super.key, required this.courts});

  @override
  State<CourtList> createState() => _CourtListState();
}

class _CourtListState extends State<CourtList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.courts.length,
      itemBuilder: (context, index) {
        return CourtCard(court: widget.courts[index]);
      },
    );
  }
}
