import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_frist_project/Screen/profile.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  var isLoading = false.obs;
  var isVerifying = false.obs;
  var phone = ''.obs;

  final supabase = Supabase.instance.client;

  /// Sign up with email & password
  Future<void> signUp(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await supabase.auth.signUp(
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
          'Check your email',
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

  /// Sign in with email & password
  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        Get.snackbar(
          'Success',
          'Login successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/profile');
      }
    } catch (e) {
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

  /// Sign out the user
  Future<void> signOut() async {
    await supabase.auth.signOut();
    Get.offAllNamed('/login');
  }

  /// Send OTP to phone number
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

  /// Verify OTP code for phone login
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

  /// Google Sign-In Integration
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> signInWithGoogle() async {
    try {
      isLoading(true);
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
      );

      if (response.user != null) {
        Get.off(() => ProfileScreen());
      } else {
        Get.snackbar('Error', 'Google sign-in failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
