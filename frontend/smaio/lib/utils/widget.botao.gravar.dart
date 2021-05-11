import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class BotaoGravar extends ElevatedButton {
  BotaoGravar({
    bool showprogress = false,
    required VoidCallback? onPressed,
    Key? key,
  }) : super(
          key: key,
          onPressed: showprogress ? null : onPressed,
          child: showprogress ? progress : padrao,
        );

  static Widget? padrao = Container(
    height: 50,
    width: 100,
    child: Center(
      child: Row(
        children: [
          Icon(
            Icons.save,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Gravar",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  static Widget? progress = Container(
    height: 50,
    width: 100,
    child: Center(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ),
  );
}
