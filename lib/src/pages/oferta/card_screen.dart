import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Oferta'),
        ),
        body: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            _cardTipo1(),
            SizedBox(height: 15.0),
            _cardTipo1(),
            SizedBox(height: 15.0),
            _cardTipo1(),
            SizedBox(height: 15.0),
            _cardTipo1(),
            SizedBox(height: 15.0),
            _cardTipo1(),
            SizedBox(height: 15.0),
            _cardTipo1(),
            SizedBox(height: 15.0),
            _cardTipo1(),
            SizedBox(height: 15.0),
            _cardTipo1(),
            SizedBox(height: 15.0),
          ],
        ));
  }

  Widget _cardTipo1() {
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
            title: Text('Oferta 1'),
            subtitle: Text(
                'El transportista ofreces 150.50 por su carga.'),
          ),
          Container(
            height: 35.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(onPressed: () {}, child: Text('Aceptar')),
                TextButton(onPressed: () {}, child: Text('Cancelar')),
              ],
            ),
          )
        ],
      ),
    );
  }

}
