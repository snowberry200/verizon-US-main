import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_verizon/bloc/auth_bloc.dart';
import 'package:my_verizon/bloc/auth_event.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.formKey,
    required this.loginController,
    required this.passwordController,
    required this.context,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return;
        }
        if (kDebugMode) {
          print('Login: ${loginController.text}');
        }
        if (kDebugMode) {
          print('Password: ${passwordController.text}');
        }
        context.read<AuthBloc>().add(
          SignInEvent(
            email: loginController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: CupertinoColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: const Size.fromHeight(50),
        fixedSize: const Size(80, 20),
      ),
      child: Text(
        'Sign in',
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
