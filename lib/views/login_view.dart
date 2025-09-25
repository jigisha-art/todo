import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(isLogin ? 'Login' : 'Sign Up', style: Theme.of(context).textTheme.headlineMedium),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (isLogin) {
                    auth.signIn(emailController.text, passwordController.text);
                  } else {
                    auth.signUp(emailController.text, passwordController.text);
                  }
                },
                child: Text(isLogin ? 'Login' : 'Sign Up'),
              ),
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(isLogin ? 'Create Account' : 'Already have account?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}