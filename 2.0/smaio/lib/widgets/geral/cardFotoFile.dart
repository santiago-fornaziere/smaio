import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetCardFotoFile extends StatelessWidget {
  VoidCallback? onPressed;
  String image;
  WidgetCardFotoFile({
    this.onPressed,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 100,
        width: 100,
        color: Colors.black38,
        child: image.isEmpty
            ? Icon(
                Icons.photo_camera_outlined,
                size: 50,
                color: Colors.grey,
              )
            : Image.network(
                image,
                fit: BoxFit.contain,
                height: 100,
              ),
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
      ),
    );
  }
}
