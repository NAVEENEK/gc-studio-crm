import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/auth/model/login_request.dart';
import 'package:frontend/features/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    //validate all form fields
    if (!_formkey.currentState!.validate()) {
      return;
    }
    //create the login request model
    final request = LoginRequest(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    //call provider
    final authProvider = context.read<AuthProvider>();
    await authProvider.login(request);

    
    if (authProvider.employee != null) {
      //login successful as employee
      context.go(AppRoutes.employeeDashboard);
    } else if (authProvider.agency != null) {
      //login successful as agency
      context.go(AppRoutes.agencyDashboard);
    } else {
      //login failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? "Something went wrong"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Welcome Back",
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Text(
            "Sign in to continue",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 35),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email is required";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: "password",
              prefixIcon: const Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "password is required";
              }
              return null;
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text("Login", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
