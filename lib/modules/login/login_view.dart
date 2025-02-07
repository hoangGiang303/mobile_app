import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/service/app_page.dart';

import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.isLogin.value ? 'Đăng Nhập' : 'Đăng Ký',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.isLogin.value
                        ? controller.emailController
                        : controller.emailSignupController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.isLogin.value
                        ? controller.passwordController
                        : controller.passSignupController,
                    obscureText: !controller.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'Mật Khẩu',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: controller.togglePasswordVisibility,
                          icon: Icon(!controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (controller.isValue.value)
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(controller.error.value.toString(),
                            style: const TextStyle(color: Colors.red))),
                  if (controller.isLogin.value)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: controller.rememberMe.value,
                              onChanged: (bool? value) {
                                controller.rememberMe.value = value!;
                              },
                            ),
                            const Text('Nhớ mật khẩu'),
                          ],
                        ),
                        TextButton(
                          onPressed: (){
                            Get.toNamed(AppRoutes.FORGOTPASS);
                          },
                          child: const Text('Quên mật khẩu?'),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // Nút đăng nhập/đăng ký
                  ElevatedButton(
                    onPressed: controller.isLogin.value
                        ? controller.login
                        : controller.signup,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                        controller.isLogin.value ? 'Đăng Nhập' : 'Đăng Ký'),
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: controller.toggleAuthMode,
                    child: Text(controller.isLogin.value
                        ? 'Chưa có tài khoản? Đăng ký ngay'
                        : 'Đã có tài khoản? Đăng nhập'),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
