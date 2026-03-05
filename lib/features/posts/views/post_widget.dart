import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/extensions.dart';
import 'package:prosnap/core/consts/fonts.dart';
import 'package:prosnap/core/models/post.dart';
import 'package:prosnap/features/posts/controllers/post_controller.dart';

class PostWidget extends StatefulWidget {
  final FeedModel post;
  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final PostController postController = Get.find<PostController>();
  final PostController postControllerE = Get.put(PostController());

  bool isLiked = false;
  bool isSaved = false;
  bool showHeart = false;

  int likesCount = 128;
  int commentsCount = 32;

  @override
  Widget build(BuildContext context) {
    final user = widget.post.userId;
    final mediaList = widget.post.media ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(20),

        /// HEADER
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundImage:
                    (user?.profilePicture != null &&
                            user!.profilePicture!.isNotEmpty)
                        ? NetworkImage(user.profilePicture!)
                        : null,
                child:
                    user?.profilePicture == null
                        ? Icon(Icons.person, color: Colours.white, size: 18.sp)
                        : null,
              ),
              horizontalSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.userName ?? "Unknown",
                    style: TextStyle(
                      fontFamily: Fonts.semiBold,
                      fontSize: 13.sp,
                      color: Colours.white,
                    ),
                  ),
                  Text(
                    widget.post.location ?? "",
                    style: TextStyle(
                      fontFamily: Fonts.light,
                      fontSize: 11.sp,
                      color: Colours.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.more_vert, color: Colours.white, size: 20.sp),
            ],
          ),
        ),

        verticalSpace(15),

        /// IMAGE
        if (mediaList.isNotEmpty)
          SizedBox(
            height: 380.h,
            width: double.infinity,
            child: GestureDetector(
              onDoubleTap: _handleDoubleTapLike,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView(
                    children: List.generate(
                      mediaList.length,
                      (index) => CachedNetworkImage(
                        imageUrl: mediaList[index].url ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: showHeart ? 1 : 0,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: showHeart ? 1.3 : 0.5,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 100.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        verticalSpace(15),

        /// ACTION BUTTONS
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              InkWell(
                onTap: _toggleLike,
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colours.white,
                  size: 24.sp,
                ),
              ),
              horizontalSpace(20),
              InkWell(
                onTap: () => _openCommentSheet(context),
                child: Icon(
                  Icons.mode_comment_outlined,
                  color: Colours.white,
                  size: 24.sp,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => setState(() => isSaved = !isSaved),
                child: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Colours.white,
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ),

        verticalSpace(10),

        /// COUNTS
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _openLikesSheet(context),
                child: Text(
                  "$likesCount likes",
                  style: TextStyle(
                    fontFamily: Fonts.semiBold,
                    fontSize: 13.sp,
                    color: Colours.white,
                  ),
                ),
              ),
              verticalSpace(4),
              GestureDetector(
                onTap: () => _openCommentSheet(context),
                child: Text(
                  "View all $commentsCount comments",
                  style: TextStyle(
                    fontFamily: Fonts.light,
                    fontSize: 12.sp,
                    color: Colours.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(12),

        /// CAPTION
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${user?.userName ?? "Unknown"}  ",
                  style: TextStyle(
                    fontFamily: Fonts.semiBold,
                    fontSize: 13.sp,
                    color: Colours.white,
                  ),
                ),
                TextSpan(
                  text: widget.post.caption ?? "",
                  style: TextStyle(
                    fontFamily: Fonts.light,
                    fontSize: 13.sp,
                    color: Colours.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        verticalSpace(20),
        const Divider(color: Colours.divider, thickness: 0.5),
      ],
    );
  }

  /// LIKE
  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likesCount += isLiked ? 1 : -1;
    });

    postController.likePost(widget.post.id!);
  }

  void _handleDoubleTapLike() {
    if (!isLiked) _toggleLike();

    setState(() => showHeart = true);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => showHeart = false);
    });
  }

  /// LIKES SHEET
  void _openLikesSheet(BuildContext context) {
    postController.getLikes(widget.post.id!);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colours.primary,
      builder: (_) {
        return Obx(
          () => ListView.builder(
            itemCount: postController.likes.length,
            itemBuilder: (_, index) {
              final user = postController.likes[index];
              return ListTile(
                title: Text(
                  user.userName,
                  style: const TextStyle(color: Colours.white),
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// COMMENTS
  void _openCommentSheet(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    postController.getComments(widget.post.id!);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colours.primary,
      builder: (_) {
        return Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: postController.comments.length,
                  itemBuilder: (_, index) {
                    final comment = postController.comments[index];
                    return ListTile(
                      title: Text(
                        comment.text,
                        style: const TextStyle(color: Colours.white),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    style: const TextStyle(color: Colours.white),
                    decoration: const InputDecoration(
                      hintText: "Add comment...",
                      hintStyle: TextStyle(color: Colours.grey),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colours.white),
                  onPressed: () {
                    if (commentController.text.trim().isEmpty) return;

                    postController.commentPost(
                      widget.post.id!,
                      commentController.text,
                    );

                    commentController.clear();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
