import 'package:get/get.dart';
import 'package:mobile_app/modules/password/forgot_pass/forgot_pass_controller.dart';

class ForgotPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPassController>(() => ForgotPassController());
  }
}