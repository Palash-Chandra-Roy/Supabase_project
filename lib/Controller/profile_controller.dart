import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final usernameController = TextEditingController();
  final websiteController = TextEditingController();

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw 'User not logged in';

      final data =
          await Supabase.instance.client.from('profiles').select().match({
            'id': userId,
          }).maybeSingle();

      if (data != null) {
        usernameController.text = data['username'] ?? 'Name';
        websiteController.text = data['website'] ?? '';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error loading profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProfile() async {
    try {
      isLoading.value = true;
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw 'User not logged in';

      final username = usernameController.text;
      final website = websiteController.text;

      await Supabase.instance.client.from('profiles').upsert({
        'id': userId,
        'username': username,
        'website': website,
      });

      Get.snackbar(
        'Success',
        'Profile updated',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error saving profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    // Optionally: Navigate to login screen
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    usernameController.dispose();
    websiteController.dispose();
    super.onClose();
  }
}
