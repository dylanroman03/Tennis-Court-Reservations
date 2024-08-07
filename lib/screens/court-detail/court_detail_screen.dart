import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/blocs/court_detail_bloc.dart';
import 'package:tennis/blocs/reservation_bloc.dart';
import 'package:tennis/blocs/wheater_bloc.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/repositories/reservation/reservation_respository_impl.dart';
import 'package:tennis/repositories/wheater/wheater_repository_impl.dart';
import 'package:tennis/screens/court-detail/components/form_court_detail.dart';

class CourtDetailScreen extends StatefulWidget {
  final CourtModel court;

  const CourtDetailScreen({super.key, required this.court});

  @override
  State<CourtDetailScreen> createState() => _CourtDetailScreenState();
}

class _CourtDetailScreenState extends State<CourtDetailScreen> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final TextEditingController clientNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) {
          return CourtDetailBloc(
            reservationRepository:
                RepositoryProvider.of<ReservationRepositoryImpl>(context),
            reservationBloc: BlocProvider.of<ReservationBloc>(context),
          )..add(
              InitializeCourtDetail(
                court: widget.court,
              ),
            );
        }),
        BlocProvider(create: (BuildContext context) {
          return WeatherBloc(weatherRepository: WeatherRepositoryImpl());
        }),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.court.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.74,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.court.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Cancha tipo ${widget.court.type}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.17,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${widget.court.priceByHour}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const Text(
                                    'Por hora',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: size.height * 0.01),
                          child: const Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.grey),
                              SizedBox(width: 5),
                              Text('Disponible: 7:00 am a 4:00 pm'),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            SizedBox(width: 5),
                            Text('Vía Av. Caracas y Av. P° Caroní'),
                          ],
                        ),
                        const FormCourtDetail()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: FloatingActionButton(
                heroTag: 'back',
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                heroTag: 'favorite',
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {},
                child: const Icon(Icons.favorite_border, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
