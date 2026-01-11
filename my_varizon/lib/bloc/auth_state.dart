import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  bool get isChecked => false;
  bool get isLoading => false;
  const AuthState();
  @override
  List<Object?> get props => [isChecked];
}

class InitialAuthState extends AuthState {
  const InitialAuthState();
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
  @override
  bool get isLoading => true;
  @override
  List<Object?> get props => [isLoading];
}

class AuthErrorState extends AuthState {
  final String message;
  const AuthErrorState({required this.message});
  @override
  bool get isChecked => false;
  @override
  List<Object?> get props => [message, isChecked];
}

class AuthSigninState extends AuthState {
  final String email;
  final String password;
  const AuthSigninState({required this.email, required this.password});
  @override
  bool get isChecked => false;
  @override
  List<Object?> get props => [email, password, isChecked];
}

class CheckboxState extends AuthState {
  final bool checker;
  const CheckboxState({required this.checker});

  @override
  bool get isChecked => checker;
  @override
  List<Object?> get props => [isChecked];
}

class QuestionAnswerState extends AuthState {
  final String question;
  final String answer;
  const QuestionAnswerState({required this.question, required this.answer});
  @override
  List<Object?> get props => [question, answer];
}
