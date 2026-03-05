import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosnap/core/global/globals.dart';
import 'package:prosnap/core/models/story.dart';
import 'package:prosnap/core/network/api_exception.dart';
import 'package:prosnap/features/story/repository/story_repository.dart';

class StoryController extends GetxController {
  final StoryRepository repository = StoryRepository();

  RxList<Story> stories = <Story>[].obs; // ✅ MAKE REACTIVE
  RxBool isLoading = false.obs;
  RxBool isLoadingNext = false.obs;

  int page = 1;
  bool hasNext = true;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getStories();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 50) {
        loadNext();
      }
    });
  }

  Future<void> getStories() async {
    try {
      page = 1;
      hasNext = true;
      stories.clear();

      isLoading.value = true;

      Map response = await repository.getStories(page: page);
      List data = response['data']['stories'];
      stories.assignAll(data.map((e) => Story.fromJson(e)).toList());
      page = response['data']['pagination']['page'];
      hasNext = response['data']['pagination']['hasNext'];
    } catch (e) {
      if (e is ApiException || e is NoInternetException) {
        Get.snackbar("Error", e.toString());
      }
      logger.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadNext() async {
    if (isLoadingNext.value || !hasNext) return;

    try {
      isLoadingNext.value = true;

      Map response = await repository.getStories(page: page + 1);
      List data = response['data']['stories'];
      stories.addAll(data.map((e) => Story.fromJson(e)).toList());
      page = response['data']['pagination']['page'];
      hasNext = response['data']['pagination']['hasNext'];
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingNext.value = false;
    }
  }
}
