import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget>? action;
  const AppBarWidget({
    Key? key,
    required this.title,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      excludeHeaderSemantics: true,
      automaticallyImplyLeading: false,
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
