import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_frist_project/Screen/login_form.dart';
import 'package:supabase_frist_project/Screen/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;
  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  Future<void> _getAuth() async {
    setState(() {
      _user = Supabase.instance.client.auth.currentUser;
    });
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      setState(() {
        _user = data.session?.user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Profile Example')),
      body: _user == null ? LoginForm() : Profile(),
    );
  }
}
