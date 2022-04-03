import 'package:flutter/material.dart';

// Moving this into its own widget, since it's used in multiple places.
class ErrorLoadingWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String errorMessage;
  final String buttonText;

  const ErrorLoadingWidget({
    required this.onPressed,
    required this.errorMessage,
    required this.buttonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            // context.read is just a way for Flutter to look up the
            // widget tree, to find the cubit we're talking about.
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: theme.textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
