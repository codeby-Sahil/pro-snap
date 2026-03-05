import 'package:get/instance_manager.dart';
import 'package:prosnap/features/home/controller/home_controller.dart';
import 'package:prosnap/features/story/controller/story_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(StoryController());
  }
}
