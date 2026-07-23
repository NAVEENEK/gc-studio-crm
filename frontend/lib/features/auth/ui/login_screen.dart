import 'package:flutter/material.dart';
import 'package:frontend/features/auth/ui/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400
              ),
              child:LoginForm(),
              ),
          ),
        )
        ),
    );
  }
}