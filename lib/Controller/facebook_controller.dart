import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FacebookAuthController extends GetxController {
  final supabase = Supabase.instance.client;
  var isLoading = false.obs;

  Future<void> signInWithFacebook() async {
    try {
      isLoading.value = true;

      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!.token;

        await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.facebook,
          idToken: accessToken,
        );

        // Navigate to profile or home
        Get.toNamed('/profile');
      } else {
        throw Exception("Facebook login failed");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
