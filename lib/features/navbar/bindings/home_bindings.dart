import 'package:get/instance_manager.dart';
import 'package:prosnap/features/home/controller/home_controller.dart';
import 'package:prosnap/features/posts/controllers/post_controller.dart';
import 'package:prosnap/features/posts/repository/post_repository.dart';
import 'package:prosnap/features/story/controller/story_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostRepository()); // first

    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => StoryController());
    Get.lazyPut(() => PostController());
  }
}
