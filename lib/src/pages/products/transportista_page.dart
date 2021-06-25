import 'package:flutter/material.dart';
import 'package:proyectounderway/src/menu/menu_lateral.dart';
import 'package:proyectounderway/src/providers/productos_provider.dart';
import 'package:proyectounderway/src/providers/ofertas_provider.dart';
import 'package:proyectounderway/src/models/producto_model.dart';
import 'package:proyectounderway/src/models/oferta_model.dart';
import 'package:proyectounderway/src/utils/global_arguments.dart';

class Transportista extends StatefulWidget {
  @override
  _TransportistaState createState() => _TransportistaState();
}

class _TransportistaState extends State<Transportista> {

  final productosProvider = new ProductosProvider();
  final ofertaProvider = new OfertasProvider();
  OfferModel oferta = new OfferModel();
  GlobalArguments _globalArguments = GlobalArguments();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Transportista'),
      ),
      drawer: LateraPage(),
      body: _crearListado(),
    );
  }
  Widget _crearListado() {
    return FutureBuilder(
        future: productosProvider.cargarTodosLosProductos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data;
            return ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, i) => _crearItem(context, productos[i]));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, ProductModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          productosProvider.borrarProducto(producto.id);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Card(
              shadowColor: Color(0xFF282727),
              clipBehavior: Clip.antiAlias,
              borderOnForeground: true,
              child: Column(
                children: [
                  (producto.imagen_url == null)
                      ? Image(image: AssetImage('assets/no-image.png'))
                      : FadeInImage(
                          image: NetworkImage(producto.imagen_url),
                          placeholder: AssetImage('assets/jar-loading.gif'),
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover),
                  ListTile(
                    title:
                        Text('${producto.nombre_carga} - ${producto.tipo}'),
                    subtitle: Text('${producto.descripcion_carga}'),
                  ),
                  ButtonBar(alignment: MainAxisAlignment.end, children: [
                    TextButton.icon(
                      onPressed: () {
                        _mostrarAlert(context, producto.id);
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffFFB001)),
                      ),
                      label: Text('Ofertar'),
                      icon: Icon(Icons.monetization_on),
                    ),
                    TextButton.icon(
                      onPressed: () => Navigator.pushNamed(context, 'detalles',arguments: producto)
                          .then((value) => setState(() {})),
                      //onPressed: () {Navigator.pushNamed(context, 'detalles');},
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffFFB001)),
                      ),
                      label: Text('Detalles'),
                      icon: Icon(Icons.book_online_outlined),
                    )
                  ]),
                ],
              )),
        ));
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: '0',
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onChanged: (value) => oferta.precio = double.parse(value),
    );
  }

  void _mostrarAlert(BuildContext context, String carga_id) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Ofertar'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Enviar Oferta'),
                _crearPrecio()
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              TextButton(
                  onPressed: () {_submit(carga_id);},
                  child: Text('Enviar')),
            ],
          );
        });
  }
  
  void _submit(String carga_id) async {
    oferta.transportista_id = _globalArguments.uid;
    ofertaProvider.crearOferta(oferta, carga_id);
    Navigator.of(context).pop();
  }
}
