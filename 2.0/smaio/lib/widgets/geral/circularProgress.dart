import 'package:flutter/material.dart';

class WidgetCircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
