import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool animate;

  const SubmitButton({
    super.key,
    required this.onPressed,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    return BounceInUp(
      animate: animate,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.deepPurple.shade300,
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
