import 'package:flutter/material.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/models/reservation.dart';
import 'package:tennis/screens/home/components/court_list.dart';
import 'package:tennis/screens/home/components/reservation_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tennis Court'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Acción de cerrar sesión
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Hola Andrea!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Canchas',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: size.height * 0.4,
                child: CourtList(
                  courts: [
                    CourtModel(
                      id: 2,
                      name: "Cancha 1",
                      type: "A",
                      imageUrl: "assets/Enmascarar.png",
                      priceByHour: 20,
                    ),
                    CourtModel(
                      id: 1,
                      name: "Cancha 2",
                      type: "A",
                      imageUrl: "assets/Enmascarar.png",
                      priceByHour: 20,
                    )
                  ],
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Reservas programadas',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ReservationList(
                reservations: [
                  ReservationModel(
                    id: 1,
                    idCourt: 2,
                    date: DateTime.now(),
                    reservedBy: 'Luis',
                    hours: 0,
                    price: 0,
                  ),
                  ReservationModel(
                    id: 2,
                    idCourt: 2,
                    date: DateTime.now(),
                    reservedBy: 'Maria',
                    hours: 0,
                    price: 0,
                  ),
                ],
              ),
            ],
          ),
        )
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        //     BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Reservas'),
        //     BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
        //   ],
        // ),
        );
  }
}
