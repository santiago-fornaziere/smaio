import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.texto.dart';
import 'package:smaio/forms/loja/form.loja.contrato.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';
import 'package:smaio/widgets/geral/divider.text.dart';
import 'package:smaio/widgets/geral/edit.CNPJ.dart';
import 'package:smaio/widgets/geral/edit.Email.dart';
import 'package:smaio/widgets/geral/edit.texto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_cep/search_cep.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
// import 'package:smaio/utils/location/utilities/loc.dart';
// import 'package:js/js.dart';

// ignore: must_be_immutable
class CadastroLojaNovo extends StatefulWidget {
  @override
  _CadastroLojaNovo createState() => _CadastroLojaNovo();
}

class _CadastroLojaNovo extends State<CadastroLojaNovo> {
  bool _showProgress = false;

  final _formKey = GlobalKey<FormState>();

  final _razaoSocialController = TextEditingController();
  final _fantasiaController = TextEditingController();
  final _cnpjController = TextEditingController();
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
  final _senhaController = TextEditingController();

  var _loja = LojaUsuario(loja: Loja());

  final _focusRazao = FocusNode();
  final _focusCep = FocusNode();
  final _focusNumero = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastre sua loja na Smaio',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _body(),
    );
  }

  _body() {
    _buscarLocalizacao();
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
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/img/logo-escura.png',
                    height: 80,
                  ),
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _razaoSocialController,
                  label: 'Raz??o social',
                  focusNode: _focusRazao,
                  autofocos: true,
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _fantasiaController,
                  label: 'Fantasia (ser?? mostrado no site)',
                ),
                WidgetEditCNPJ(
                  context: context,
                  controller: _cnpjController,
                  label: 'CNPJ',
                ),
                WidgetDividerTexto(
                  texto: 'Dados de usu??rio',
                ),
                WidgetEditEmail(
                  context: context,
                  controller: _emailController,
                  label: 'e-mail',
                  icone: Icon(Icons.email),
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _senhaController,
                  label: 'Senha',
                  password: true,
                ),
                WidgetDividerTexto(
                  texto: 'Endere??o',
                ),
                _editCep(),
                WidgetEditTexto(
                  context: context,
                  controller: _logradouroController,
                  label: 'Endere??o',
                ),
                WidgetEditTexto(
                  context: context,
                  controller: _numeroController,
                  focusNode: _focusNumero,
                  label: 'N??mero/Complemento',
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
                  enabled: false,
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
                Container(
                  margin: EdgeInsets.all(30),
                  child: !_showProgress
                      ? ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _showProgress = true;
                              });
                              _fromController();

                              String _contrato = await TextoApi.getContrato();

                              push(
                                  context,
                                  CadastroLojaContrato(
                                    loja: _loja,
                                    contrato: _contrato,
                                  ),
                                  replace: false);
                              setState(() {
                                _showProgress = false;
                              });
                            } else {
                              setState(() {
                                _showProgress = false;
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Continuar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : WidgetCircularProgressMini(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _buscarLocalizacao() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.denied ||
            permission != LocationPermission.deniedForever) {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          _latitudeController.text = position.latitude.toString();
          _longitudeController.text = position.longitude.toString();
          return true;
        } else {
          return false;
        }
      } else {
        /*
        getCurrentPosition(
          allowInterop(
            (pos) {
              _latitudeController.text = pos.coords.latitude.toString();
              _longitudeController.text = pos.coords.longitude.toString();
            },
          ),
        );
        */
        _latitudeController.text = '0';
        _longitudeController.text = '0';
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  _editCep() {
    return Container(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(8),
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: _cepController,
        focusNode: _focusCep,
        keyboardType: TextInputType.number,
        validator: (String? text) {
          return (text!.isEmpty) ? 'Preenchimento obrigat??rio' : null;
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
              _focusNumero.requestFocus();
            } else {
              showMessage(
                  context, 'Cep n??o encontrado, por favor, tente novamente.');
              _cepController.clear();
              _focusCep.requestFocus();
            }
          }
        },
      ),
    );
  }

  void _fromController() {
    _loja.loja!.lojRazao = _razaoSocialController.text;
    _loja.loja!.lojNome = _fantasiaController.text;
    _loja.loja!.lojCnpj = _cnpjController.text;
    _loja.loja!.lojEmail = _emailController.text;
    _loja.loja!.lojCep = _cepController.text;
    _loja.loja!.lojLogradouro = _logradouroController.text;
    _loja.loja!.lojNumero = _numeroController.text;
    _loja.loja!.lojBairro = _bairroController.text;
    _loja.loja!.cidNome = _cidadeController.text;
    _loja.loja!.lojCidId = int.parse(_ibgeController.text);
    _loja.loja!.lojLatitude = _latitudeController.text;
    _loja.loja!.lojLongitude = _longitudeController.text;
    _loja.loja!.lojTelefone1 = _fone1Controller.text;
    _loja.loja!.lojTelefone2 = _fone2Controller.text;
    _loja.senha = _senhaController.text;
  }
}
