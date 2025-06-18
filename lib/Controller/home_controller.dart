import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  final Rxn<User> user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    _getAuth();
  }

  void _getAuth() {
    user.value = Supabase.instance.client.auth.currentUser;

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      user.value = data.session?.user;
    });
  }

  bool get isLoggedIn => user.value != null;
}
