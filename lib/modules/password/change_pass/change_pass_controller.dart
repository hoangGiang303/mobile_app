import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_app/models/login/login.dart';
import 'package:mobile_app/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/token_managerment.dart';

class ChangePassController extends GetxController{
  late ApiService apiService = ApiService(DioConfig.createDio());
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;

  void toggleAllPasswordVisibility() {
    isPasswordVisible.toggle();
  }


  Future<void> changePassword() async {
    if (await _validateInputs()) {
      String? id = await TokenManager.getId();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('password');
      await apiService.putChangePass(
          id.toString(),
          PassRequest(
              oldPassword: oldPasswordController.text,
              newPassword: newPasswordController.text));
      await prefs.setString('password', newPasswordController.text);
      await TokenManager.removePass();
      await TokenManager.savePass(newPasswordController.text);
      Get.back();
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      isPasswordVisible.value == false;
      Get.snackbar('Thông báo', 'Mật khẩu đã được thay đổi thành công');
    }
  }

  Future<bool> _validateInputs() async {
    String? pass = await TokenManager.getPass();
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Lỗi', 'Vui lòng nhập đủ thông tin');
      return false;
    }

    if (pass != oldPasswordController.text) {
      Get.snackbar('Lỗi', 'Mật khẩu cũ không khớp');
      return false;
    }

    if (newPasswordController.text.length < 6) {
      Get.snackbar('Lỗi', 'Mật khẩu phải có ít nhất 6 ký tự');
      return false;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Lỗi', 'Mật khẩu xác nhận không khớp');
      return false;
    }
    return true;
  }

  void getBack() {
    Get.back();
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    isPasswordVisible.value == false;
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}