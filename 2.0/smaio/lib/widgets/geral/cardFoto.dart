import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetCardFoto extends StatelessWidget {
  VoidCallback? onPressed;
  String imagePath;
  WidgetCardFoto({
    this.onPressed,
    required this.imagePath,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(
            const Radius.circular(100),
          ),
        ),
        child: Center(
          child: imagePath.isEmpty
              ? Icon(
                  Icons.photo_camera_outlined,
                  size: 50,
                  color: Colors.grey,
                )
              : Image.network(
                  imagePath,
                ),
        ),
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
      ),
    );
  }
}
