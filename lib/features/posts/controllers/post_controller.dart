import 'package:get/get.dart';
import 'package:prosnap/features/posts/repository/post_repository.dart';

class PostController extends GetxController {
  final PostRepository repository = Get.find<PostRepository>();

  var isLoading = false.obs;
  var comments = [].obs;
  var likes = [].obs;

  Future likePost(String postId) async {
    try {
      await repository.likePost(postId);
    } catch (e) {
      print(e);
    }
  }

  Future commentPost(
    String postId,
    String comment, {
    String? parentComment,
  }) async {
    try {
      await repository.commentPost(
        postId: postId,
        comment: comment,
        parentCommment: parentComment,
      );
      getComments(postId);
    } catch (e) {
      print(e);
    }
  }

  Future getComments(String postId) async {
    try {
      isLoading.value = true;
      final res = await repository.getPostComment(postId: postId);
      comments.value = res.data;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future getLikes(String postId) async {
    try {
      final res = await repository.getLikes(postId: postId);
      likes.value = res.data;
    } catch (e) {
      print(e);
    }
  }

  Future deleteComment(String commentId) async {
    try {
      await repository.deleteComment(commentId: commentId);
    } catch (e) {
      print(e);
    }
  }
}
