import 'package:crud/provider/post_provider.dart';
import 'package:crud/router/app_route.dart';
import 'package:crud/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const titleAppBar(title: "Posts"),
        ),
        body: const RenderViewPost(),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.post_add_outlined, color: Colors.white),
            onPressed: () =>
                Navigator.pushNamed(context, AppRoute.addPostScreen)));
  }
}

class RenderViewPost extends StatelessWidget {
  const RenderViewPost({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postProvider = Provider.of<PostProvider>(context);

    if (postProvider.postList.isEmpty) {
      return SizedBox(
          width: double.infinity,
          height: size.height,
          child: const Center(
            child: CircularProgressIndicator(color: AppTheme.primary),
          ));
    }

    return ListView.separated(
      itemCount: postProvider.postList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: (() => {
                  Navigator.pushNamed(context, AppRoute.detailScreen,
                      arguments: postProvider.postList[index])
                }),
            child: PosterItem(
                size: size,
                post: postProvider.postList[index],
                provider: postProvider));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
