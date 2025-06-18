import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    try {
      final email = emailController.text.trim();
      final password = passwordController.text;

      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        'Login Success',
        'You are now logged in.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        'Invalid credentials or server error.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup() async {
    isLoading.value = true;
    try {
      final email = emailController.text.trim();
      final password = passwordController.text;

      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      Get.snackbar(
        'Signup Success',
        'Please check your email to confirm signup.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        'Something went wrong. Try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
