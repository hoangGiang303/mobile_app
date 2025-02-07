import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/service/service.dart';

import '../../../service/token_managerment.dart';

class ForgotPassController extends GetxController {
  late ApiService apiService = ApiService(Dio());
  final RxnString error = RxnString();
  final emailController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isSuccess = false.obs;

  Future<void> sendEmail() async {
    try {
      if (emailController.text.isEmpty) {
        error.value = 'Vui lòng nhập đầy đủ email và mật khẩu';
        return;
      }
      isLoading.value = true;
      await apiService.forgotPass({"email": emailController.text.trim()});
      isSuccess.value = true;
      Get.snackbar('Thông báo', 'Mã đặt lại đã được gửi về email');
    } on DioException catch (dioError) {
      error.value = handleError(dioError);
      Get.snackbar('Lỗi', error.value.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      error.value = 'Lỗi không xác định: ${e.toString()}';
      Get.snackbar('Lỗi', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void getBack() {
    Get.back();
    emailController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
