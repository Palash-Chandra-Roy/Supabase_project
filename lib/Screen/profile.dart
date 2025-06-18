// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../controller/auth_controller.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = Supabase.instance.client.auth.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
//         centerTitle: true,
//         title: const Text("Profile"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => AuthController.to.signOut(),
//           ),
//         ],
//       ),
//       body: Center(
//         child:
//             user == null
//                 ? const Text("No user found")
//                 : Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Email: ${user.email}"),
//                     Text("Email: ${user.phone}"),
//                     Text("Email: ${user.phone}"),
//                     Text("Email: ${user.email}"),
//                     Text("Email: ${user.email}"),
//                     Text("Email: ${user.email}"),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () => AuthController.to.signOut(),
//                       child: const Text("Logout"),
//                     ),
//                   ],
//                 ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controller/auth_controller.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AuthController.to.signOut(),
          ),
        ],
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child:
              user == null
                  ? Text("No user found")
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Email: ${user.email}"),
                      Text("Username: ${profileController.usernameController}"),
                      Text("Website: ${profileController.usernameController}"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => AuthController.to.signOut(),
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
        );
      }),
    );
  }
}
