import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_frist_project/Screen/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sndedmbmzcdedstciasz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNuZGVkbWJtemNkZWRzdGNpYXN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAwNzQ4MTcsImV4cCI6MjA2NTY1MDgxN30.0-kJ6l0GifH1g7i0zLdnpPww5R5GCKq5diZEGUIlzjI',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Supabase Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}
