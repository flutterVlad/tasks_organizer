import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FadeInContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;

  const FadeInContainer({
    super.key,
    required this.child,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        margin: margin,
        constraints: const BoxConstraints(maxWidth: 300, minWidth: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.shade200,
              blurRadius: 30,
              offset: const Offset(0, 5),
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
