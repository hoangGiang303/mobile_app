import 'package:get/get.dart';
import 'package:mobile_app/modules/password/change_pass/change_pass_controller.dart';

class ChangePassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePassController>(() => ChangePassController());
  }
}