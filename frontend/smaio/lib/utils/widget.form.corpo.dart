import 'package:flutter/material.dart';

Row formCorpoCadastro(context, pForm, pWidgets) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            const Radius.circular(5),
          ),
        ),
        child: Form(
          key: pForm,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width / 11),
            height: MediaQuery.of(context).size.height - 160,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: pWidgets,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
