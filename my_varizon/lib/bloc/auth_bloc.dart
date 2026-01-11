import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_verizon/bloc/auth_event.dart';
import 'package:my_verizon/bloc/auth_state.dart';
import 'package:my_verizon/database/database.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Database database;
  AuthBloc({required this.database}) : super(InitialAuthState()) {
    on<SignInEvent>(_onSignInEvent);
    on<QuestionAnswerEvent>(_onQuestionAnswerEvent);
    on<CheckboxEvent>(_onCheckboxEvent);
  }

  FutureOr<void> _onSignInEvent(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    try {
      await Future.delayed(const Duration(seconds: 3));

      final result = await database.getData(
        userID: event.email,
        password: event.password,
        securityQuestion: '',
        securityQuestionAnswer: '',
      );

      if (kDebugMode) {
        if (kDebugMode) {
          print('Query result: $result');
        }
      } // Debug print

      if (result.isNotEmpty) {
        if (kDebugMode) {
          print('Authentication successful, emitting AuthSigninState');
        }
        emit(AuthSigninState(email: event.email, password: event.password));
      } else {
        if (kDebugMode) {
          print('Authentication failed, emitting AuthErrorState');
        }
        emit(
          AuthErrorState(
            message: 'Authentication failed. Please check your credentials.',
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in sign in: $e');
      } // Debug print
      emit(AuthErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _onQuestionAnswerEvent(
    QuestionAnswerEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 3));

    try {
      final result = await database.getData(
        userID: '',
        password: '',
        securityQuestion: event.question,
        securityQuestionAnswer: event.answer,
      );
      if (result.isNotEmpty) {
        emit(
          QuestionAnswerState(question: event.question, answer: event.answer),
        );
      }
    } catch (e) {
      AuthErrorState(message: e.toString());
    }
  }

  FutureOr<void> _onCheckboxEvent(
    CheckboxEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(CheckboxState(checker: event.isChecked));
  }
}
