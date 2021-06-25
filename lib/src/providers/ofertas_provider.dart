import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proyectounderway/src/models/oferta_model.dart';
import 'package:proyectounderway/src/utils/global_arguments.dart';

class OfertasProvider {
  final String _url = 'underway-105f6-default-rtdb.firebaseio.com';
  GlobalArguments _globalArguments = GlobalArguments();

  Future<bool> crearOferta(OfferModel oferta, String carga_id) async {
    final url = Uri.https(_url, 'cargas/${carga_id}/ofertas.json');
    final resp = await http.post(url, body: offerModelToJson(oferta));
    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }
}
