import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_frist_project/Screen/login_form.dart';
import 'package:supabase_frist_project/Screen/phone_login.dart';
import 'package:supabase_frist_project/Screen/phone_otp.dart';
import 'package:supabase_frist_project/Screen/profile.dart';
import 'package:supabase_frist_project/Screen/signup_screen.dart';
import 'package:supabase_frist_project/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sndedmbmzcdedstciasz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNuZGVkbWJtemNkZWRzdGNpYXN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAwNzQ4MTcsImV4cCI6MjA2NTY1MDgxN30.0-kJ6l0GifH1g7i0zLdnpPww5R5GCKq5diZEGUIlzjI',
  );

  Get.put(AuthController());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/login',
      // initialRoute: '/signup',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/phonelogin', page: () => PhoneLoginScreen()),
        GetPage(name: '/phone', page: () => PhoneOtp()),
      ],
    ),
  );
}
