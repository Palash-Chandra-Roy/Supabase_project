import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(label: Text('Email')),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(label: Text('Password')),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() => _loading = true);
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      try {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        await Supabase.instance.client.auth.signInWithPassword(
                          email: email,
                          password: password,
                        );
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Login successful'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Login failed'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } finally {
                        setState(() => _loading = false);
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () async {
                      setState(() => _loading = true);
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      try {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        await Supabase.instance.client.auth.signUp(
                          email: email,
                          password: password,
                        );
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Signup successful. Check your email.',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Signup failed'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } finally {
                        setState(() => _loading = false);
                      }
                    },
                    child: const Text('Signup'),
                  ),
                ],
              ),
    );
  }
}
