import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/service/app_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login/login.dart';
import '../../service/service.dart';
import '../../service/token_managerment.dart';

class LoginController extends GetxController {
  late ApiService apiService = ApiService(DioConfig.createDio());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailSignupController = TextEditingController();
  final passSignupController = TextEditingController();

  RxBool isLogin = true.obs;
  RxBool isValue = false.obs;
  RxBool rememberMe = false.obs;
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  RxBool isPasswordVisible = false.obs;

  @override
  void onInit() {
    loadSavedCredentials();
    super.onInit();
  }
  void toggleAuthMode() {
    isLogin.toggle();
  }

  void forgotPassword() {
    Get.snackbar('Thông báo', 'Kiểm tra email để đặt lại mật khẩu');
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('remember_me') == true) {
      rememberMe.value = true;
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    }
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      isValue.value = true;
      error.value = 'Vui lòng nhập đầy đủ email và mật khẩu';
      return;
    }

    isValue.value = false;
    isLoading.value = true;
    error.value = null;
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe.value) {
      await prefs.setBool('remember_me', true);
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
    } else {
      await prefs.remove('remember_me');
      await prefs.remove('email');
      await prefs.remove('password');
    }

    try {
      final response = await apiService.login(
        LoginRequest(username: emailController.text.trim(), password: passwordController.text.trim()),
      );
      await TokenManager.saveAccessToken(response.accessToken.toString());
      await TokenManager.saveRefreshToken(response.refreshToken.toString());
      await TokenManager.saveId(response.id.toString());
      await TokenManager.savePass(passwordController.text);
      String? accessToken = await TokenManager.getAccessToken();
      print('Access Token: $accessToken');
      Get.snackbar('Thành công', 'Đăng nhập thành công');
      Get.offAndToNamed(AppRoutes.MAIN);
    } on DioException catch (dioError) {
      error.value = handleError(dioError);
      Get.snackbar('Lỗi', error.value.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      error.value = 'Lỗi không xác định: ${e.toString()}';
      Get.snackbar('Đăng nhập thất bại', e.toString(), snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup() async {
    if (emailSignupController.text.isEmpty || passSignupController.text.isEmpty) {
      isValue.value = true;
      error.value = 'Vui lòng nhập đầy đủ email và mật khẩu';
      return;
    }

    isValue.value = false;
    isLoading.value = true;
    error.value = null;
    final prefs = await SharedPreferences.getInstance();
    try {
      await apiService.signup(
        LoginRequest(username: emailSignupController.text.trim(), password: passSignupController.text.trim()),
      );
      Get.snackbar('Thành công', 'Đăng ký thành công');
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('remember_me', true);
      await prefs.setString('email', emailSignupController.text);
      await prefs.setString('password', passSignupController.text);
      await TokenManager.clearTokens();
      await TokenManager.removeId();
      final response = await apiService.login(
        LoginRequest(username: emailSignupController.text.trim(), password: passSignupController.text.trim()),
      );
      await TokenManager.saveAccessToken(response.accessToken.toString());
      await TokenManager.saveRefreshToken(response.refreshToken.toString());
      await TokenManager.saveId(response.id.toString());
      await TokenManager.savePass(passSignupController.text);
      emailSignupController.clear();
      passSignupController.clear();
      Future.delayed(const Duration(seconds: 1),(){
        Get.offAndToNamed(AppRoutes.MAIN);
      });
    } on DioException catch (dioError) {
      error.value = dioError.response?.data['error'];
      Get.snackbar('Lỗi', error.value.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      error.value = 'Lỗi không xác định: ${e.toString()}';
      Get.snackbar('Đăng nhập thất bại', e.toString(), snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailSignupController.dispose();
    passSignupController.dispose();
    super.onClose();
  }
}
