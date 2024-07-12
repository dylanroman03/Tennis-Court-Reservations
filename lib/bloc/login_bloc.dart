import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/repositories/session/session_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<CheckLoginStatus>(_onCheckLoginStatus);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    await userRepository.createDatabase();
    await userRepository.updateIsLogin();
    emit(LoginSuccess());
  }

  void _onCheckLoginStatus(
    CheckLoginStatus event,
    Emitter<LoginState> emit,
  ) async {
    final isLoggedIn = await userRepository.isLoggedIn();
    if (isLoggedIn) {
      emit(LoginSuccess());
    }
  }
}

// Events
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {}

class CheckLoginStatus extends LoginEvent {}

// Estates
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}
