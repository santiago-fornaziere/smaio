// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

//import 'package:bfcall/controllers/controller.chamado.anexo.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> downloadAnexo(context, int pID, String pNome) async {
  // Uint8List? retorno = await ChamadoAnexoApi.getAnexo(pID);
  Uint8List? retorno;

// prepare
  final blob = html.Blob([retorno]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  /*
  código para abrir o arquivo em uma nova aba do navegador
  html.window.open(url, "_blank");
  html.Url.revokeObjectUrl(url);
  */

  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = pNome;
  html.document.body!.children.add(anchor);
// download
  anchor.click();
  if (retorno == null) {
    return false;
  } else {
    return false;
  }
}

void abrirArquivo(String _url) async {
  await canLaunch(_url)
      ? await launch(
          _url,
          forceWebView: true,
          enableDomStorage: true,
          enableJavaScript: true,
        )
      : throw 'Não foi possível abrir o arquivo...';
}
