import 'package:crud/herpers/helpers.dart';
import 'package:crud/models/models.dart';
import 'package:crud/provider/post_provider.dart';
import 'package:crud/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isEditUser = false;

  @override
  Widget build(BuildContext context) {
    final PostResponse post =
        ModalRoute.of(context)!.settings.arguments as PostResponse;

    final GlobalKey<FormState> editPostForm = GlobalKey<FormState>();

    final postProvider = Provider.of<PostProvider>(context);

    final Map<String, dynamic> formValues = {
      'title': post.title,
      'body': post.body,
      'id': post.id
    };

    return Scaffold(
      body: Center(
          child: CustomScrollView(slivers: [
        if (!isEditUser)
          _CustomAppBar(
              title: post.title ?? "No title",
              uri: "https://picsum.photos/id/${post.id}/400/500"),
        SliverList(
            delegate: SliverChildListDelegate([
          if (!isEditUser) _Overview(overview: post.body ?? "No body"),
          if (isEditUser)
            FormPost(
                postForm: editPostForm,
                formValues: formValues,
                postProvider: postProvider,
                title: "EDITA TU POST",
                typeForm: FormType.edit,
                onAction: setViewCurrent)
        ]))
      ])),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            getIcon(),
            color: Colors.white,
          ),
          onPressed: () => setViewCurrent()),
    );
  }

  getIcon() {
    return !isEditUser ? Icons.edit_note_outlined : Icons.close_outlined;
  }

  setViewCurrent() {
    setState(() {
      isEditUser = !isEditUser;
    });
  }
}

class _CustomAppBar extends StatelessWidget {
  final String title;
  final String uri;

  const _CustomAppBar({required this.title, required this.uri});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          color: Colors.black26,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(uri),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;
  const _Overview({required this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
