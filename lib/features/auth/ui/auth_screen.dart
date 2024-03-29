import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_organizer/features/auth/bloc/auth_from_state.dart';
import 'package:tasks_organizer/features/auth/ui/widgets/flush_bar.dart';

import '/features/auth/bloc/auth_bloc.dart';
import 'sign_in_form.dart';
import 'sign_up_form.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state.authFormState is ErrorFromState) {
            FlushBar.showFlushBar(
              context: context,
              message: state.authFormState.toString(),
              textColor: Colors.red.shade500,
              icon: Icons.error_outline,
            );
          }
        },
        builder: (_, AuthState state) {
          return Center(
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeIn,
              child: state.authType == AuthType.signIn
                  ? const SignInForm()
                  : const SignUpForm(),
            ),
          );
        },
      ),
    );
  }
}
