import 'package:flutter/material.dart';
import 'package:smaio/models/model.veiculoloja.dart';

// ignore: must_be_immutable
class WidgetCardDadosVeiculoLoja extends StatelessWidget {
  VeiculoLoja veiloja;
  WidgetCardDadosVeiculoLoja({
    required this.veiloja,
  });

  bool showProgress = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Container(
        child: ListTile(
          title: Text(
            veiloja.vlojVeiDescricao.toString(),
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            '${veiloja.vlojAnoDescricao} - ${veiloja.vlojVeiFabNome}',
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          leading: (veiloja.foto != null)
              ? Container(
                  child: Image.network(
                    veiloja.foto.toString(),
                    fit: BoxFit.contain,
                  ),
                )
              : Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.grey,
                  size: 50,
                ),
        ),
      ),
    );
  }
}
