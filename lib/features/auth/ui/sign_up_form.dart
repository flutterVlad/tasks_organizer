import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_organizer/core/validation/text_form_validation.dart';
import 'package:tasks_organizer/data/data.dart';

import 'package:tasks_organizer/features/auth/bloc/auth_bloc.dart';

import 'widgets/form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  final _formKey = GlobalKey<FormState>();
  bool underline = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
              'Sign Up',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FadeIn(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0),
              constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.shade200,
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
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
                      controller: nameController,
                      hintText: 'Name',
                      validator: TextFormValidation.validate(
                          field: FormFieldType.name),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: CustomFormField(
                      controller: emailController,
                      hintText: 'Email',
                      validator: TextFormValidation.validate(
                          field: FormFieldType.email),
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
                bloc.add(NavigateSignInEvent());
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 14,
                  decoration: underline ? TextDecoration.underline : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          BounceInUp(
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  bloc.add(
                    SignUpEvent(
                      params: SignUpParams(
                        userName: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                      onDone: () {
                        nameController.clear();
                        emailController.clear();
                        passwordController.clear();
                      },
                    ),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.deepPurple.shade300,
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
