import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis/bloc/login_bloc.dart';
import 'package:tennis/screens/components/rounded_buttom.dart';
import 'package:tennis/screens/home/home_screen.dart';
import 'package:tennis/screens/login/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/Grupo-20.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              top: size.height * 0.1,
              left: size.width * 0.3,
              child: SvgPicture.asset(
                'assets/LOGO.svg',
                width: size.width * 0.4,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: size.width * 0.6,
                  child: RoundedButton(
                    text: 'Iniciar Sesión',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    color: const Color.fromARGB(255, 170, 247, 36),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * 0.6,
                  child: RoundedButton(
                    text: 'Registrarme',
                    onPressed: () {},
                    color: const Color.fromARGB(137, 201, 207, 189),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
