import 'package:crud/herpers/helpers.dart';
import 'package:crud/provider/post_provider.dart';
import 'package:crud/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> postForm = GlobalKey<FormState>();

    final postProvider = Provider.of<PostProvider>(context);

    final Map<String, dynamic> formValues = {
      'title': "",
      'body': "",
      'userId': 1
    };

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const titleAppBar(title: "Agregar"),
        ),
        body: FormPost(
            postForm: postForm,
            formValues: formValues,
            postProvider: postProvider,
            title: "AGREGA TU NUEVO POST",
            typeForm: FormType.add));
  }
}
