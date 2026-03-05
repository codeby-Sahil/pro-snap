import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';
import 'package:prosnap/features/home/controller/home_controller.dart';
import 'package:prosnap/features/posts/views/post_widget.dart';
import 'package:prosnap/features/story/controller/story_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends GetWidget<HomeController> {
  HomeScreen({super.key});

  Widget verticalSpace(double h) => SizedBox(height: h.h);
  Widget horizontalSpace(double w) => SizedBox(width: w.w);

  @override
  Widget build(BuildContext context) {
    final storyController = Get.find<StoryController>();

    return Scaffold(
      backgroundColor: Colours.primary,
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getInitialFeed();
          await storyController.getStories(); // ✅ Proper refresh
        },
        child: SafeArea(
          child: CustomScrollView(
            controller: controller.postScrollController,
            slivers: [
              /// ================= HEADER =================
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Text(
                    "PRO SNAP",
                    style: TextStyle(
                      fontFamily: Fonts.bold,
                      fontSize: 22.sp,
                      letterSpacing: 4,
                      color: Colours.white,
                    ),
                  ),
                ),
              ),

              /// ================= STORIES =================
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100.h,
                  child: Obx(() {
                    if (storyController.isLoading.value) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: 6,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: Column(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 65.h,
                                    width: 65.h,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                verticalSpace(8),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 40.w,
                                    height: 10.h,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }

                    return ListView.builder(
                      controller: storyController.scrollController,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: storyController.stories.length,
                      itemBuilder: (_, index) {
                        final story = storyController.stories[index];

                        final imageUrl =
                            story.stories?.isNotEmpty == true
                                ? story.stories!.first.media?.url
                                : null;

                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: Column(
                            children: [
                              Container(
                                height: 65.h,
                                width: 65.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colours.white,
                                    width: 1,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colours.divider,
                                  backgroundImage:
                                      imageUrl != null && imageUrl.isNotEmpty
                                          ? CachedNetworkImageProvider(imageUrl)
                                          : null,
                                  child:
                                      imageUrl == null
                                          ? Icon(
                                            Icons.person,
                                            color: Colours.white,
                                            size: 20.sp,
                                          )
                                          : null,
                                ),
                              ),
                              verticalSpace(8),
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  story.user?.userName ?? "User",
                                  style: TextStyle(
                                    fontFamily: Fonts.light,
                                    fontSize: 11.sp,
                                    color: Colours.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),

              /// ================= POSTS =================
              SliverToBoxAdapter(
                child: Divider(color: Colours.divider, thickness: 0.5),
              ),
              Obx(() {
                if (controller.isPostsloading.value) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, __) => PostShimmer(),
                      childCount: 6,
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final post = controller.posts[index];
                    return KeyedSubtree(
                      key: ValueKey(post.id ?? index),
                      child: PostWidget(post: controller.posts[index]),
                    );
                  }, childCount: controller.posts.length),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/// ================= POST ITEM =================
class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  CircleAvatar(radius: 20.r, backgroundColor: Colors.white),
                  SizedBox(width: 10.w),
                  Container(width: 120.w, height: 12.h, color: Colors.white),
                ],
              ),
            ),
            Container(width: 1.sw, height: 300.h, color: Colors.white),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 10.h, width: 200.w, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(height: 10.h, width: 150.w, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
