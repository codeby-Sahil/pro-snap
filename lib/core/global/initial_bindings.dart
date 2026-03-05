import 'package:get/get.dart';
import 'package:prosnap/core/network/api_client.dart';
import 'package:prosnap/features/auth/controllers/auth_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiClient>(() => ApiClient());
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
