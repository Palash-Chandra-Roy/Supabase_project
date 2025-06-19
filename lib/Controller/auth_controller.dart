import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  var isLoading = false.obs;
  var isVerifying = false.obs;
  var phone = ''.obs;

  Future<void> signUp(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        Get.snackbar(
          'Success',
          'Signup successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/login');
      } else {
        Get.snackbar(
          'Email Verification Required',
          'Check your email to confirm signup',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      print("✅ User: ${response.user}");
      print("✅ Session: ${response.session}");

      if (response.user != null) {
        Get.snackbar(
          'Success',
          'Login successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Redirect to Profile screen
        Get.offAllNamed('/profile');
      }
    } catch (e) {
      print("❌ Login Error: $e");

      Get.snackbar(
        'Login Failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    Get.offAllNamed('/login');
  }

  final supabase = Supabase.instance.client;

  Future<void> sendOtp() async {
    isLoading.value = true;
    try {
      final number = phoneController.text.trim();
      await supabase.auth.signInWithOtp(phone: number);
      phone.value = number;
      Get.snackbar('Success', 'OTP sent to $number');
      Get.toNamed('/verify');
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    isVerifying.value = true;
    try {
      final token = otpController.text.trim();
      final number = phone.value;
      final res = await supabase.auth.verifyOTP(
        phone: number,
        token: token,
        type: OtpType.sms,
      );

      if (res.user != null) {
        Get.snackbar(
          'Login Successful',
          'Welcome!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isVerifying.value = false;
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
