import 'dart:math';
import 'package:crud/provider/post_provider.dart';
import 'package:crud/themes/app_theme.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class PosterItem extends StatelessWidget {
  const PosterItem({
    Key? key,
    required this.size,
    required this.post,
    required this.provider,
  }) : super(key: key);

  final Size size;
  final PostResponse post;
  final PostProvider provider;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          provider.deletePost(post);
        },
        background: const ColoredBox(
            color: AppTheme.primary,
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 35,
                  ),
                ))),
        child: PostItemBody(post: post, size: size));
  }
}

class PostItemBody extends StatelessWidget {
  const PostItemBody({
    Key? key,
    required this.post,
    required this.size,
  }) : super(key: key);

  final PostResponse post;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image:
                  NetworkImage("https://picsum.photos/id/${post.id}/300/300"),
              imageErrorBuilder: ((context, error, stackTrace) => Image.asset(
                    "assets/image_holder.png",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  )),
              height: 100,
              width: 100,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: size.width * 0.6,
            height: min(120, 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title ?? "No title",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17),
                ),
                const SizedBox(height: 7),
                Text(
                  textAlign: TextAlign.justify,
                  post.body ?? "No body",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
