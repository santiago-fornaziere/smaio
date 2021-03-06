import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetCardItemLista extends StatelessWidget {
  Item item;
  WidgetCardItemLista({
    required this.item,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.grey[100],
      color: Color.fromRGBO(247, 221, 145, 1),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // foto
            Container(
              height: 120,
              width: (MediaQuery.of(context).size.width / 8) * 1,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    child: (item.iteFoto != null)
                        ? Image.network(
                            item.iteFoto.toString(),
                            width: (MediaQuery.of(context).size.width / 8) * 1,
                            height: 100,
                            fit: BoxFit.contain,
                          )
                        : Icon(
                            Icons.camera_alt_outlined,
                            size: 50,
                            color: Colors.black,
                          ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text(
                          item.iteFotoQtde.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // dados pe??a
            Container(
              height: 120,
              width: (MediaQuery.of(context).size.width / 8) * 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (item.iteDescricao.toString().length > 0)
                      ? Text(
                          '${item.iteDescricao.toString()}',
                          style: TextStyle(
                            fontSize: fontSizePequeno,
                            color: Colors.black,
                          ),
                        )
                      : Container(),
                  Text(
                    (item.iteValor ?? 0) > 0
                        ? 'R\$ ${formatFloat.format(item.iteValor ?? 0)}'
                        : 'Consultar loja',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  (defaultTargetPlatform == TargetPlatform.android ||
                          defaultTargetPlatform == TargetPlatform.iOS)
                      ? Text(
                          'Dist.: ${formatFloat.format(item.iteDistancia)} Km',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        )
                      : Container(),
                  Text(
                    '${item.iteVeiDescricao.toString()}-${item.iteVanoAnoDescricao.toString()}',
                    style: TextStyle(
                      fontSize: fontSizePequeno,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // dados loja
            Container(
              height: 120,
              width: (MediaQuery.of(context).size.width / 8) * 4 - 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.iteLojNome.toString(),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tel.: ${item.iteLojTelefone1.toString()} / ${item.iteLojTelefone2.toString()}',
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${item.iteLojEmail.toString()}',
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${item.iteLojCidNome.toString()}',
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
