import 'package:flutter/material.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetAppBarTransparente extends StatelessWidget
    with PreferredSizeWidget {
  String titulo;
  bool? mostraIcone;
  WidgetAppBarTransparente({
    required this.titulo,
    this.mostraIcone,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: (mostraIcone ?? false)
          ? Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/img/logo-amarelo.png',
              ),
            )
          : null,
      title: Text(
        titulo,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.clip,
        style: TextStyle(
          color: corTextoPadrao,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
