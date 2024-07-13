import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/bloc/court_bloc.dart';
import 'package:tennis/bloc/login_bloc.dart';
import 'package:tennis/bloc/reservation_bloc.dart';
import 'package:tennis/database/database_provider.dart';
import 'package:tennis/repositories/court/court_repository_impl.dart';
import 'package:tennis/repositories/reservation/reservation_respository_impl.dart';
import 'package:tennis/repositories/session/session_repository.dart';
import 'package:tennis/screens/welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SessionRepository(
            databaseProvider: DatabaseProvider.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => CourtRepositoryImpl(),
        ),
        RepositoryProvider(
          create: (context) => ReservationRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
              sessionRepository:
                  RepositoryProvider.of<SessionRepository>(context),
            )..add(CheckLoginStatus()),
          ),
          BlocProvider(
            create: (context) => CourtBloc(
              courtRepository:
                  RepositoryProvider.of<CourtRepositoryImpl>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ReservationBloc(
              reservationRepository:
                  RepositoryProvider.of<ReservationRepositoryImpl>(context),
            ),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: WelcomeScreen(),
        ),
      ),
    );
  }
}
