import 'package:flutter/material.dart';
import 'package:proyectounderway/constants.dart';
import 'package:proyectounderway/src/models/producto_model.dart';
import 'package:proyectounderway/src/pages/details/components/item_image.dart';
import 'package:proyectounderway/src/pages/details/components/order_button.dart';
import 'package:proyectounderway/src/pages/details/components/title_price_rating.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductModel producto = new ProductModel();
    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    return Stack(
      children: <Widget>[
        ItemImage(
          imgSrc: producto.imagen_url,
        ),
        Expanded(
          child: ItemInfo(),
        ),
      ],
    );
  }
}

class ItemInfo extends StatelessWidget {
  ProductModel producto = new ProductModel();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    return Container(
      margin: EdgeInsets.only(top: 330),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: <Widget>[
          shopeName(name: producto.ubicacion_inicio, destino: producto.ubicacion_destino),
          TitlePriceRating(
            name: producto.nombre_carga,
            numOfReviews: 24,
            rating: 4,
            price: 15,
            onRatingChanged: (value) {},
          ),
          Text(
            producto.descripcion_carga,
            style: TextStyle(
              height: 1.5,
            ),
          ),
          Text(""),
          Text("Peso: "+producto.peso),
          Text("Tipo: "+producto.tipo),
          // Free space  10% of total height
        ],
      ),
    );
  }

  Row shopeName({String name, String destino}) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: ksecondaryColor,
        ),
        SizedBox(width: 10),
        Text(name+" - "+destino),
      ],
    );
  }
}


