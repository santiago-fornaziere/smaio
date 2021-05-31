import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.loja.dart';
import 'package:smaio/forms/menu.inicial.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:provider/provider.dart';
import 'package:smaio/widgets/geral/bottonNavigationBarSalvar.dart';
import 'package:smaio/widgets/geral/edit.texto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_cep/search_cep.dart';

// ignore: must_be_immutable
class CadastroLoja extends StatefulWidget {
  Loja loja;
  CadastroLoja({
    required this.loja,
  });
  @override
  _CadastroLoja createState() => _CadastroLoja();
}

class _CadastroLoja extends State<CadastroLoja> {
  bool _showProgress = false;

  final _formKey = GlobalKey<FormState>();

  final _razaoSocialController = TextEditingController();
  final _fantasiaController = TextEditingController();
  final _emailController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _fone1Controller = TextEditingController();
  final _fone2Controller = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _numeroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _cepController = TextEditingController();
  final _ibgeController = TextEditingController();

  final _focusRazao = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo:
            '${widget.loja.lojNome.toString()} \n${widget.loja.lojEmail.toString()}',
        mostraIcone: false,
      ),
      bottomNavigationBar:
          Consumer<Sistema>(builder: (context, sistema, child) {
        return WidgetBottonNavigatorBarSalvar(
          context: context,
          showProgress: _showProgress,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                _showProgress = true;
              });

              _fromController();
//              print(widget.loja.lojRazao);
              int retorno = await LojaApi.put(widget.loja);
              if (retorno == 202) {
                setState(() {
                  _showProgress = false;
                });
                sistema.setLoja(widget.loja);
                push(context, MenuInicial(), replace: true);
              } else {
                setState(() {
                  _showProgress = false;
                });
                showSnackMessage(context, 'Erro ao gravar os dados...');
              }
            } else {
              setState(() {
                _showProgress = false;
              });
            }
          },
        );
      }),
      //      backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: corTemaDark,
      body: _body(),
    );
  }

  _body() {
    _toController();
    return Center(
      child: Form(
        key: _formKey,
        child: Container(
          width: 500,
          child: Container(
            margin: EdgeInsets.all(16),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                WidgetEditTexto(
                  context: context,
                  controller: _razaoSocialController,
                  label: 'Razão social',
                  focusNode: _focusRazao,
                  autofocos: true,
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _fantasiaController,
                  label: 'Fantasia (será mostrado no site)',
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _emailController,
                  label: 'e-mail',
                  icone: Icon(Icons.email),
                ),
                _editCep(),
                WidgetEditTexto(
                  context: context,
                  controller: _logradouroController,
                  label: 'Endereço',
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _numeroController,
                  label: 'Número/Complemento',
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _bairroController,
                  label: 'Bairro',
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _cidadeController,
                  label: 'Cidade',
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _fone1Controller,
                  label: 'Fone',
                  icone: Icon(Icons.call),
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _fone2Controller,
                  label: 'Celular (Whatsapp)',
                  icone: Icon(Icons.message),
                ),
                Consumer<Sistema>(builder: (context, sistema, child) {
                  return ElevatedButton(
                    onPressed: () => _buscarLocalizacao(),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          'Atualizar localização',
                          style: TextStyle(
                            fontSize: fontSizePadrao,
                            color: corTextoPadrao,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                WidgetEditTexto(
                  context: context,
                  controller: _latitudeController,
                  label: 'Latitude',
                  enabled: false,
                  icone: Icon(Icons.add_location),
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _longitudeController,
                  label: 'Longitude',
                  enabled: false,
                  icone: Icon(Icons.add_location),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buscarLocalizacao() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied ||
        permission != LocationPermission.deniedForever) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _latitudeController.text = position.latitude.toString();
        _longitudeController.text = position.longitude.toString();
        _fromController();
      });
    }
  }

  _editCep() {
    return Container(
      padding: EdgeInsets.all(23),
      child: TextFormField(
        controller: _cepController,
        keyboardType: TextInputType.number,
        validator: (String? text) {
          return (text!.isEmpty) ? 'Preenchimento obrigatório' : null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[50],
          labelText: 'CEP',
        ),
        onChanged: (value) async {
          if (value.length == 8) {
            final viaCepSearchCep = ViaCepSearchCep();
            final infoCepJSON = await viaCepSearchCep.searchInfoByCep(
                cep: value, returnType: SearchInfoType.json);
            if (infoCepJSON.isRight()) {
              var dados = infoCepJSON.fold((_) => null, (data) => data);
              setState(() {
                _logradouroController.text = dados!.logradouro.toString();
                _bairroController.text = dados.bairro.toString();
                _cidadeController.text = dados.localidade.toString();
                _ibgeController.text = dados.ibge.toString();
                _fromController();
              });
            } else {
              showSnackMessage(context, 'Cep não encontrado...');
            }
          }
        },
      ),
    );
  }

  void _fromController() {
    widget.loja.lojRazao = _razaoSocialController.text;
    widget.loja.lojNome = _fantasiaController.text;
    widget.loja.lojEmail = _emailController.text;
    widget.loja.lojCep = _cepController.text;
    widget.loja.lojLogradouro = _logradouroController.text;
    widget.loja.lojNumero = _numeroController.text;
    widget.loja.lojBairro = _bairroController.text;
    widget.loja.cidNome = _cidadeController.text;
    widget.loja.lojCidId = int.parse(_ibgeController.text);
    widget.loja.lojLatitude = _latitudeController.text;
    widget.loja.lojLongitude = _longitudeController.text;
    widget.loja.lojTelefone1 = _fone1Controller.text;
    widget.loja.lojTelefone2 = _fone2Controller.text;
  }

  void _toController() {
    _razaoSocialController.text = widget.loja.lojRazao.toString();
    _fantasiaController.text = widget.loja.lojNome.toString();
    _emailController.text = widget.loja.lojEmail.toString();
    _cepController.text = widget.loja.lojCep.toString();
    _logradouroController.text = widget.loja.lojLogradouro.toString();
    _numeroController.text = widget.loja.lojNumero.toString();
    _bairroController.text = widget.loja.lojBairro.toString();
    _cidadeController.text = widget.loja.cidNome.toString();
    _ibgeController.text = widget.loja.lojCidId.toString();
    _fone1Controller.text = widget.loja.lojTelefone1.toString();
    _fone2Controller.text = widget.loja.lojTelefone2.toString();
    _latitudeController.text = widget.loja.lojLatitude.toString();
    _longitudeController.text = widget.loja.lojLongitude.toString();
  }
}
