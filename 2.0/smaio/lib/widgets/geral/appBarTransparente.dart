import 'package:flutter/material.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetAppBarTransparente extends StatelessWidget
    with PreferredSizeWidget {
  String titulo;
  bool? mostraIcone;
  VoidCallback? onPressed;
  int tema;
  WidgetAppBarTransparente({
    required this.titulo,
    this.mostraIcone,
    this.onPressed,
    required this.tema,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: (mostraIcone ?? false)
          ? Padding(
              padding: const EdgeInsets.all(4),
              child: InkWell(
                onTap: onPressed,
                child: Icon(
                  Icons.settings,
                  color:
                      tema == 1 ? Colors.black : Theme.of(context).primaryColor,
                ),
              ),
            )
          : null,
      title: Text(
        titulo,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.clip,
        style: TextStyle(
          color: corTextoPadrao[0],
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
