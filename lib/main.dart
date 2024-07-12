import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/bloc/login_bloc.dart';
import 'package:tennis/database/database_provider.dart';
import 'package:tennis/repositories/session/session_repository.dart';
import 'package:tennis/screens/welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
              userRepository: SessionRepository(
                databaseProvider: DatabaseProvider.instance,
              ),
            )..add(CheckLoginStatus()),
          ),
        ],
        child: const WelcomeScreen(),
      ),
    );
  }
}
