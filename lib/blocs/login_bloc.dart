import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis/repositories/session/session_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionRepository sessionRepository;

  LoginBloc({required this.sessionRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
    on<CheckLoginStatus>(_onCheckLoginStatus);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    await sessionRepository.createDatabase();
    await sessionRepository.updateIsLogin();
    emit(LoginSuccess());
  }

  void _onLogoutButtonPressed(
    LogoutButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    await sessionRepository.deleteDatabase();
    await sessionRepository.logout();
    emit(LoginInitial());
  }

  void _onCheckLoginStatus(
    CheckLoginStatus event,
    Emitter<LoginState> emit,
  ) async {
    final isLoggedIn = await sessionRepository.isLoggedIn();
    if (isLoggedIn) {
      emit(LoginSuccess());
    }
  }
}

// Events
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {}

class LogoutButtonPressed extends LoginEvent {}

class CheckLoginStatus extends LoginEvent {}

// States
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}
