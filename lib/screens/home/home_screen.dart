import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/blocs/court_bloc.dart';
import 'package:tennis/blocs/login_bloc.dart';
import 'package:tennis/blocs/reservation_bloc.dart';
import 'package:tennis/screens/home/components/court_list.dart';
import 'package:tennis/screens/home/components/reservation_list.dart';
import 'package:tennis/screens/welcome/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginInitial) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tennis Court'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LogoutButtonPressed());
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
              BlocBuilder<CourtBloc, CourtState>(
                builder: (context, state) {
                  if (state is CourtLoaded) {
                    return SizedBox(
                      height: size.height * 0.4,
                      child: CourtList(courts: state.courts),
                    );
                  } else {
                    BlocProvider.of<CourtBloc>(context).add(GetCourts());
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
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
              BlocBuilder<ReservationBloc, ReservationState>(
                builder: (context, state) {
                  if (state is ReservationLoaded) {
                    return ReservationList(
                      reservations: state.reservations,
                    );
                  } else {
                    BlocProvider.of<ReservationBloc>(context)
                        .add(GetReservations());
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
