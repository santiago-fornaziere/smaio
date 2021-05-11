import 'package:smaio/controllers/controller.loja.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/models/model.usuario.dart';
import 'package:smaio/pages/form.dashboard.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginLojaPage extends StatefulWidget {
  final Usuario usuario;
  LoginLojaPage({
    required this.usuario,
  });
  @override
  _LoginLojaPage createState() => _LoginLojaPage();
}

class _LoginLojaPage extends State<LoginLojaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: _body(),
    );
  }

  _body() {
    Future<List<Loja>> future =
        LojaApi.getByUsuario(widget.usuario.usuId ?? '15');
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<Loja>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível concluir esta ação!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Loja> query = snapshot.data!;
        return _tela(query);
      },
    );
  }

  _tela(List<Loja> query) {
    return Stack(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow[50],
              borderRadius: BorderRadius.all(
                const Radius.circular(40.0),
              ),
            ),
            padding: EdgeInsets.all(30),
            width: 400,
            height: 415,
            child: _tabelaLojas(query),
          ),
        ),
      ],
    );
  }

  _tabelaLojas(List<Loja> query) {
    return Container(
      padding: EdgeInsets.all(2),
      child: ListView.builder(
        itemCount: query.length,
        itemBuilder: (context, index) {
          var itemLista = query[index];
          return Consumer<Sistema>(builder: (context, sistema, child) {
            return Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(5),
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        utf8convert(itemLista.lojNome.toString()),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        utf8convert(itemLista.lojEmail.toString()),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        sistema.setLoja(itemLista);
                        sistema.setUsuario(widget.usuario);
                        push(context, Dashboard(), replace: false);
                      },
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  onClikLoja(Loja loja) {
    push(context, Dashboard(), replace: false);
  }
}
