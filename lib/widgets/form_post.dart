import 'package:crud/herpers/helpers.dart';
import 'package:crud/themes/app_theme.dart';
import 'package:crud/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../provider/post_provider.dart';

class FormPost extends StatefulWidget {
  const FormPost({
    Key? key,
    required this.postForm,
    required this.formValues,
    required this.postProvider,
    required this.title,
    required this.typeForm,
    this.onAction,
  }) : super(key: key);

  final GlobalKey<FormState> postForm;
  final Map<String, dynamic> formValues;
  final PostProvider postProvider;
  final String title;
  final FormType typeForm;
  final VoidCallback? onAction;

  @override
  State<FormPost> createState() => _FormPostState();
}

class _FormPostState extends State<FormPost> {
  bool loadInfo = false;

  @override
  Widget build(BuildContext context) {
    if (loadInfo) {
      return Stack(
        children: [
          Opacity(
            opacity: loadInfo ? 1.0 : 0,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
      );
    }
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          key: widget.postForm,
          child: Column(
            children: [
              const FadeInImage(
                  width: 200,
                  height: 200,
                  placeholder: AssetImage("assets/add_image.png"),
                  image: AssetImage("assets/add_image.png")),
              Text(
                widget.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              CustomInputField(
                  controller:
                      TextEditingController(text: widget.formValues['title']),
                  labelText: "Título",
                  hintText: "Título del post",
                  formProperty: 'title',
                  formValues: widget.formValues),
              CustomInputField(
                controller:
                    TextEditingController(text: widget.formValues['body']),
                labelText: "Descripción",
                hintText: "Descripción del post",
                formProperty: 'body',
                formValues: widget.formValues,
                inputType: TextInputType.multiline,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  child: const SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Center(child: Text("Guardar")),
                  ),
                  onPressed: () {
                    if (widget.typeForm == FormType.add) {
                      onSavePost();
                      return;
                    }

                    onEditPost();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void onSavePost() {
    validate();

    widget.postProvider.savePost(widget.formValues).then((value) {
      if (value) {
        Navigator.pop(context);
        return;
      }

      setState(() {
        loadInfo = false;
      });
    });
  }

  void onEditPost() {
    validate();

    widget.postProvider
        .updatePost(widget.formValues, widget.formValues['id'])
        .then((value) {
      if (value) {
        Navigator.pop(context);
        return;
      }

      setState(() {
        loadInfo = false;
      });
    });
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!widget.postForm.currentState!.validate()) {
      return;
    }

    setState(() {
      loadInfo = true;
    });
  }
}
