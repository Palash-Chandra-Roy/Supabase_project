import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_frist_project/Controller/google_controller.dart';

import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final contactController = Get.put(GoogleController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthController.to;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () =>
              auth.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: "Email"),
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed:
                              () => auth.signIn(
                                emailController.text,
                                passwordController.text,
                              ),
                          child: const Text("Login"),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/signup');
                          },
                          child: const Text(" Sign up"),
                        ),

                        ElevatedButton(
                          onPressed:
                              () =>
                                  Get.find<GoogleController>()
                                      .signInWithGoogle(),
                          child: Text('Sign in with Google'),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}
