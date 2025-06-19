import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_frist_project/controller/auth_controller.dart';

class PhoneOtp extends StatelessWidget {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.otpController,
              decoration: const InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isVerifying.value ? null : controller.verifyOtp,
                child:
                    controller.isVerifying.value
                        ? const CircularProgressIndicator()
                        : const Text('Verify OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
