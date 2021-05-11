import 'package:flutter/material.dart';

showBFDialog(BuildContext context, Widget pChild) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          content: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                right: 0,
                top: 0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Icons.close,
                      size: 25,
                    ),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 600,
                  width: (MediaQuery.of(context).size.width < 700)
                      ? MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width / 8)
                      : 700,
                  padding: EdgeInsets.all(1),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical, child: pChild),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
