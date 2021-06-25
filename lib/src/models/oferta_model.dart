import 'dart:convert';

OfferModel offerModelFromJson(String str) => OfferModel.fromJson(json.decode(str));
String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
    OfferModel({
        this.id,
        this.precio = 0.0,
        this.transportista_id = '',
    });

    String id;
    double precio;
    String transportista_id;

    factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        precio: json["precio"],
        transportista_id: json["transportista_id"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "precio": precio,
        "transportista_id": transportista_id
    };
}
