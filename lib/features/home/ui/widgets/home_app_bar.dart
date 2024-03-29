import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final VoidCallback onPressed;

  @override
  final Size preferredSize;

  const HomeAppBar({
    super.key,
    required this.userName,
    required this.onPressed,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Hi, $userName!',
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.logout_outlined,
            size: 25,
          ),
        ),
      ],
    );
  }
}
