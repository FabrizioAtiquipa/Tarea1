import 'package:flutter/material.dart';
import 'package:proyectounderway/src/models/oferta_model.dart';
import 'package:proyectounderway/src/providers/ofertas_provider.dart';

class CardPage extends StatelessWidget {
  final ofertasProvider = new OfertasProvider();
  OfferModel oferta = new OfferModel();
  String carga_id = "";

  @override
  Widget build(BuildContext context) {
    final String oferData = ModalRoute.of(context).settings.arguments;
    if (oferData != null) {
      carga_id = oferData;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Oferta'),
        ),
        body: _crearListado(),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: ofertasProvider.cargarOfertas(carga_id),
        builder:
            (BuildContext context, AsyncSnapshot<List<OfferModel>> snapshot) {
          if (snapshot.hasData) {
            final ofertas = snapshot.data;
            return ListView.builder(
                itemCount: ofertas.length,
                itemBuilder: (context, i) => _cardTipo1(context, ofertas[i]));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _cardTipo1(BuildContext context, OfferModel oferta) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          ListTile(
            leading: Image(
              width: 55.0,
              image: AssetImage('assets/fondolateral.jpg'),
            ),
            title: Text('Nueva oferta'),
            subtitle: Text(
                'El transportista ofreces ${oferta.precio} soles por su carga.'),
          ),
          Container(
            height: 35.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(onPressed: () {}, child: Text('Aceptar')),
                TextButton(onPressed: () {
                  ofertasProvider.borrarOferta(carga_id,oferta.id);
                  Navigator.pushNamed(context, 'oferta', arguments: carga_id);
                }, child: Text('Cancelar')),
              ],
            ),
          )
        ],
      ),
    );
  }

}
