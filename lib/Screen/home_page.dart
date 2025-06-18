import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_frist_project/Controller/home_controller.dart';
import 'package:supabase_frist_project/Screen/login_form.dart';
import 'package:supabase_frist_project/Screen/signup_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Profile Example')),
      body: Obx(() => controller.isLoggedIn ? SignupScreen() : LoginScreen()),
    );
  }
}
