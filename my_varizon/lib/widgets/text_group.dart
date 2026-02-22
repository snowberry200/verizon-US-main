import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_verizon/bloc/auth_bloc.dart';
import 'package:my_verizon/bloc/auth_state.dart';

class TextGroupWidget extends StatefulWidget {
  final void Function()? swap;

  const TextGroupWidget({super.key, required this.swap});

  @override
  State<TextGroupWidget> createState() => _TextGroupWidgetState();
}

class _TextGroupWidgetState extends State<TextGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: widget.swap,
                child: Text(
                  state.isSignUpMode ? 'Sign In' : 'Register',
                  style: TextStyle(
                    color: Colors.black,

                    fontWeight: FontWeight.bold,

                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: widget.swap,

                child: Text(
                  'Forgot your Info?',
                  style: TextStyle(
                    color: Colors.black,

                    fontWeight: FontWeight.bold,

                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Make a one-time payment',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,

                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Business Sign in',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
