import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/modules/password/forgot_pass/forgot_pass_controller.dart';
import 'package:mobile_app/service/color_app.dart';
import 'package:mobile_app/utils/widget/button_common.dart';

class ForgotPassView extends GetView<ForgotPassController> {
  const ForgotPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quên mật khẩu'),
        leading: IconButton(
            onPressed: () {
              controller.getBack();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "Vui lòng nhập Email để lấy mã đặt lại mật khẩu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )),
            const SizedBox(height: 16),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            Obx(() {
              return ButtonCommon(
                textButton: controller.isLoading.value
                    ? "Đang gửi..."
                    : "Lấy mã xác nhận",
                onTap:
                    controller.isLoading.value ? () {} : controller.sendEmail,
                fontWeight: FontWeight.bold,
                enableIcon: false,
                bgColor: primaryColor,
                borderColor: primaryColor,
                textColor: Colors.white,
              );
            }),
          ],
        ),
      ),
    );
  }
}
