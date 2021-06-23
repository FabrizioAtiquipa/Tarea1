import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));
String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        this.id,
        this.owner_id,
        this.nombre_carga = '',
        this.imagen_url,
        this.tipo = '',
        this.ubicacion_inicio = '',
        this.ubicacion_destino = '',
        this.precio = 0.0,
        this.peso = '',
        this.disponible = true,
        this.descripcion_carga = '',
    });

    String id;
    String owner_id;
    String nombre_carga;
    String imagen_url;
    String tipo;
    String ubicacion_inicio;
    String ubicacion_destino;
    double precio;
    String peso;
    bool disponible;
    String descripcion_carga;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        owner_id: json["owner_id"],
        nombre_carga: json["nombre_carga"],
        imagen_url: json["imagen_url"],
        tipo: json["tipo"],
        ubicacion_inicio: json["ubicacion_inicio"],
        ubicacion_destino: json["ubicacion_destino"],
        precio: json["precio"],
        peso: json["peso"],
        disponible: json["disponible"],
        descripcion_carga: json["descripcion_carga"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "owner_id": owner_id,
        "nombre_carga": nombre_carga,
        "imagen_url": imagen_url,
        "tipo": tipo,
        "ubicacion_inicio": ubicacion_inicio,
        "ubicacion_destino": ubicacion_destino,
        "precio": precio,
        "peso": peso,
        "disponible": disponible,
        "descripcion_carga": descripcion_carga,
    };
}
