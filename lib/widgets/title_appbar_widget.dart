import 'package:flutter/material.dart';

class titleAppBar extends StatelessWidget {
  final title;
  const titleAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
