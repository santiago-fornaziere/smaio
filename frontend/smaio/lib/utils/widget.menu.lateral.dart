import 'package:smaio/controllers/controller.menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:smaio/notifiers/notifier.item.dart';
import 'package:smaio/notifiers/notifier.peca.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:provider/provider.dart';
import 'package:smaio/notifiers/notifier.veiculo.dart';

// ignore: must_be_immutable
class DrawerList extends StatelessWidget {
  final String usuNivel;
  DrawerList({
    required this.usuNivel,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _listaOpcoes(context),
    );
  }

  ListView _listaOpcoes(BuildContext context) {
    return ListView(
      shrinkWrap: false,
      children: <Widget>[
        UserAccountsDrawerHeader(
            accountName: Consumer<Sistema>(builder: (context, sistema, child) {
              return Text(sistema.usuario!.usuNome.toString());
            }),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/img/avatar_usuario.png"),
              backgroundColor: Colors.white,
            ),
            accountEmail: Consumer<Sistema>(builder: (context, sistema, child) {
              return Text(sistema.usuario!.usuEmail.toString());
            })),
        _dashboard(context),
        _item(context),
        _perfilEmpresa(context),
      ],
    );
  }

  _item(BuildContext context) {
    return Consumer<Itens>(builder: (context, lista, child) {
      return ListTile(
        leading: Icon(
          Icons.shopping_cart,
          size: 50,
          color: Colors.blueGrey,
        ),
        hoverColor: Colors.greenAccent[50],
        title: Text(
          "Itens para venda",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("Lançamento de peças para venda"),
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.blueGrey,
        ),
        onTap: () {
          lista.setItens([]);
          onClikItens(context);
        },
      );
    });
  }

  _dashboard(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.dashboard,
        size: 50,
        color: Colors.blueGrey,
      ),
      hoverColor: Colors.greenAccent[50],
      title: Text(
        "Dashboard",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text("tela inicial"),
      trailing: Icon(
        Icons.navigate_next,
        color: Colors.blueGrey,
      ),
      onTap: () => onClickDashboard(context),
    );
  }

  _veiculos(BuildContext context) {
    return Consumer<Veiculos>(builder: (context, lista, child) {
      return ListTile(
        leading: Icon(
          Icons.car_repair,
          size: 50,
          color: Colors.blueGrey,
        ),
        hoverColor: Colors.greenAccent[50],
        title: Text(
          "Veículos",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("Opções de veículos"),
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.blueGrey,
        ),
        onTap: () {
          lista.setVeiculos([]);
          onClikVeiculos(context);
        },
      );
    });
  }

  _pecas(BuildContext context) {
    return Consumer<Pecas>(builder: (context, lista, child) {
      return ListTile(
        leading: Icon(
          Icons.app_registration,
          size: 50,
          color: Colors.blueGrey,
        ),
        hoverColor: Colors.greenAccent[50],
        title: Text(
          "Peças",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("Cadastro de peças e subgrupos"),
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.blueGrey,
        ),
        onTap: () {
          lista.setPecas([]);
          onClikPecas(context);
        },
      );
    });
  }

  Widget _perfilEmpresa(BuildContext context) {
    if (usuNivel == 'Smaio') {
      return Column(
        children: [
          _veiculos(context),
          _pecas(context),
        ],
      );
    } else {
      return Container();
    }
  }
}
