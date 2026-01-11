import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_verizon/bloc/auth_bloc.dart';
import 'package:my_verizon/bloc/auth_state.dart';
import 'package:my_verizon/form/checkbox.dart';
import 'package:my_verizon/homepage.dart';
import 'package:my_verizon/layout/layout.dart';
import 'package:my_verizon/question_widget.dart/question_page.dart';
import 'package:my_verizon/widgets/email_textfield.dart';
import 'package:my_verizon/widgets/password_text_fields.dart';
import 'package:my_verizon/widgets/sign_in_button.dart';
import 'package:my_verizon/widgets/text_group.dart';
import 'package:my_verizon/widgets/text_widget.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _canShowSnackBar = true;

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    _canShowSnackBar = false;

    super.dispose();
  }

  FormPage formPage = FormPage();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (kDebugMode) {
          print('FormWidget listener called with state: ${state.runtimeType}');
        }

        if (state is AuthSigninState) {
          if (kDebugMode) {
            print('Navigating to QuestionPage...');
          }
          if (mounted && _canShowSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Authenticated to Question and Answer Page "),
                backgroundColor: Colors.green,
              ),
            );
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => QuestionPage(
                    userID: state.email,
                    password: state.password,
                  ),
            ),
          );
        }

        if (state is AuthErrorState) {
          if (kDebugMode) {
            print('Error state: ${state.message}');
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                  LayOutWidget.isMobile(context)
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
              children: [
                LayOutWidget.isMobile(context)
                    ? SizedBox(height: 0)
                    : SizedBox(height: 80),
                TextWidget(),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'User ID or verizon mobile number',
                      style: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),

                EmailTextField(loginController: loginController),
                SizedBox(height: LayOutWidget.isMobile(context) ? 10 : 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
                PasswordTextField(passwordController: passwordController),
                SizedBox(height: LayOutWidget.isMobile(context) ? 10 : 20),
                CheckboxWidget(),
                SizedBox(height: LayOutWidget.isMobile(context) ? 10 : 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width:
                        LayOutWidget.isMobile(context)
                            ? width / 4
                            : LayOutWidget.isDesktop(context)
                            ? width / 8
                            : LayOutWidget.isTablet(context)
                            ? width / 6
                            : width / 4,

                    child:
                        state.isLoading
                            ? SizedBox(
                              height: 50,
                              child: Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    strokeCap: StrokeCap.round,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      CupertinoColors.systemBlue,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            : SignInButton(
                              formKey: formKey,
                              loginController: loginController,
                              passwordController: passwordController,
                              context: context,
                            ),
                  ),
                ),

                SizedBox(height: LayOutWidget.isMobile(context) ? 10 : 20),
                Align(alignment: Alignment.topLeft, child: TextGroupWidget()),
              ],
            ),
          ),
        );
      },
    );
  }
}
