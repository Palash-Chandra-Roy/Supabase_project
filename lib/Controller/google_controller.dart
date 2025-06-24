import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleController extends GetxController {
  final contactText = 'No contact loaded.'.obs;
  final isLoading = false.obs;

  final SupabaseClient supabase = Supabase.instance.client;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    // Only required for iOS or web. Android doesn't need these.
    // clientId: 'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com',
    serverClientId:
        '449392146096-qk9u3dee956p6sreg1d99b3hnclrns1t.apps.googleusercontent.com',
  );

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar('Cancelled', 'Google sign-in cancelled');
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null || accessToken == null) {
        Get.snackbar('Error', 'Google token not found');
        return;
      }

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user != null) {
        Get.snackbar('Success', 'Login successful');
        Get.offAllNamed('/profile');
      } else {
        Get.snackbar('Failed', 'Google Sign-In failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
