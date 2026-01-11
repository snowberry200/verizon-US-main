import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  const SignInEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class CheckboxEvent extends AuthEvent {
  const CheckboxEvent({required this.isChecked});
  final bool isChecked;

  @override
  List<Object?> get props => [isChecked];
}

class QuestionAnswerEvent extends AuthEvent {
  final String question;
  final String answer;
  const QuestionAnswerEvent({required this.question, required this.answer});
  @override
  List<Object?> get props => [question, answer];
}
