import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_frist_project/controller/auth_controller.dart';

class PhoneLoginScreen extends StatelessWidget {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number (+880...)',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.sendOtp,
                child:
                    controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text('Send OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
