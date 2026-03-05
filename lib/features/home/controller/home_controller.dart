import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosnap/core/global/globals.dart';
import 'package:prosnap/core/models/post.dart';
import 'package:prosnap/core/network/api_exception.dart';
import 'package:prosnap/features/home/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository = HomeRepository();
  final ScrollController postScrollController = ScrollController();
  RxList<FeedModel> posts = <FeedModel>[].obs;
  RxBool isPostsloading = false.obs;
  int postPage = 1;
  bool morePostAvailable = true;
  bool loadingNextPost = false;

  @override
  void onInit() {
    super.onInit();
    getInitialFeed();
    postScrollController.addListener(() {
      if (postScrollController.position.pixels >=
          postScrollController.position.maxScrollExtent - 300) {
        loadNextPost();
      }
    });
  }

  getInitialFeed() async {
    isPostsloading.value = true;
    try {
      this.posts.clear();
      Map response = await repository.getFeed();
      final List posts = response['data']['posts'];
      this.posts.addAll(posts.map((e) => FeedModel.fromJson(e)).toList());
      postPage = response['data']['pagination']['page'];
      morePostAvailable = response['data']['pagination']['hasNext'];
    } catch (e) {
      if (e is ApiException) {
        Get.snackbar("Error..!!", e.message);
      }
      if (e is NoInternetException) {
        Get.snackbar("Error..!!", e.message);
      }
      logger.e(e);
    } finally {
      isPostsloading.value = false;
    }
  }

  Future<void> loadNextPost() async {
    if (loadingNextPost || !morePostAvailable) return;

    loadingNextPost = true;

    try {
      Map response = await repository.getFeed(page: postPage + 1);
      final List postsJson = response['data']['posts'];
      posts.addAll(postsJson.map((e) => FeedModel.fromJson(e)).toList());
      postPage = response['data']['pagination']['page'];
      morePostAvailable = response['data']['pagination']['hasNext'];
    } catch (e) {
      if (e is ApiException) logger.e(e.message);

      if (e is NoInternetException) {
        Get.snackbar("No Internet!!", e.message);
      }

      logger.e(e);
    } finally {
      loadingNextPost = false;
    }
  }
}
