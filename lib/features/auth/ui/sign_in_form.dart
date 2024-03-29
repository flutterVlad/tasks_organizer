import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/validation/text_form_validation.dart';
import '/data/data.dart';
import '/features/auth/bloc/auth_bloc.dart';
import '/features/auth/ui/widgets/submit_button.dart';
import '/features/widgets/fade_in_container.dart';
import 'widgets/form_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  final _formKey = GlobalKey<FormState>();
  bool underline = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = BlocProvider.of<AuthBloc>(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BounceInDown(
            child: const Text(
              'Sign In',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FadeInContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 20,
                    bottom: 10,
                  ),
                  child: CustomFormField(
                    controller: emailController,
                    hintText: 'Email',
                    validator:
                        TextFormValidation.validate(field: FormFieldType.email),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 20,
                    top: 10,
                  ),
                  child: CustomFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: TextFormValidation.validate(
                      field: FormFieldType.password,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FadeIn(
            child: TextButton(
              onHover: (val) {
                setState(() {
                  underline = val;
                });
              },
              onPressed: () {
                bloc.add(NavigateSignUpEvent());
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 14,
                  decoration: underline ? TextDecoration.underline : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SubmitButton(
            animate: true,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                bloc.add(
                  SignInEvent(
                    params: SignInParams(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                    onDone: () {
                      emailController.clear();
                      passwordController.clear();
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
