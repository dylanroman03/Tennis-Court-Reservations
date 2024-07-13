import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
          title: SvgPicture.asset(
            'assets/LOGO.svg',
            width: size.width * 0.2,
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: <Color>[
                  Color.fromARGB(255, 128, 188, 0),
                  Color.fromARGB(255, 4, 68, 121)
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LogoutButtonPressed());
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      bottom: size.height * 0.01,
                      top: size.height * 0.02,
                    ),
                    child: const Text(
                      'Hola Andrea!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      top: size.height * 0.01,
                    ),
                    child: const Text(
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
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      top: size.height * 0.01,
                    ),
                    child: const Text(
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
          ],
        ),
      ),
    );
  }
}
