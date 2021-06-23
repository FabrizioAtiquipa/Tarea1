import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectounderway/src/models/producto_model.dart';
import 'package:proyectounderway/src/providers/productos_provider.dart';
import 'package:proyectounderway/src/utils/utils.dart' as utils;
import 'package:proyectounderway/src/utils/global_arguments.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  GlobalArguments _globalArguments = GlobalArguments();
  final form_key = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductModel producto = new ProductModel();
  final productoProvider = new ProductosProvider();
  bool _guardando = false;
  File _foto;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Product Name', style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.camera),
              onPressed: _tomarFoto,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                  key: form_key,
                  child: Column(
                    children: [
                      _mostrarFoto(),
                      _crearNombre(),
                      _crearDescripcion(),
                      _crearDestinoInicio(),
                      _crearDestinoFin(),
                      _crearPrecio(),
                      _crearTipo(),
                      _crearPeso(),
                      _crearDisponoble(),
                      _crearBoton()
                    ],
                  ))),
        ));
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.nombre_carga,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => producto.nombre_carga = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDestinoInicio() {
    return TextFormField(
      initialValue: producto.ubicacion_inicio,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Ubicación de recojo'),
      onSaved: (value) => producto.ubicacion_inicio = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la ubicacion de donde se recogerá la carga';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDestinoFin() {
    return TextFormField(
      initialValue: producto.ubicacion_destino,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Ubicación de destino'),
      onSaved: (value) => producto.ubicacion_destino = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la ubicación a donde desea que llegue su carga';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      initialValue: producto.descripcion_carga,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Descripción del producto'),
      onSaved: (value) => producto.descripcion_carga = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese una breve descripción de su producto';
        } else {
          return null;
        }
      },
    );
  }

   Widget _crearTipo() {
    return TextFormField(
      initialValue: producto.tipo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Tipo de producto'),
      onSaved: (value) => producto.tipo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el tipo de producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPeso() {
    return TextFormField(
      initialValue: producto.peso,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Peso del producto'),
      onSaved: (value) => producto.peso = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el peso del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
        initialValue: producto.precio.toString(),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: 'Precio'),
        onSaved: (value) => producto.precio = double.parse(value),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo numero';
          }
        });
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
        onPressed: (_guardando) ? null : _submit,
        icon: Icon(Icons.save),
        label: Text('Guardar'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xffFFB001)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ))));
  }

  Widget _crearDisponoble() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Color(0xffFFB001),
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  void _submit() async {
    if (!form_key.currentState.validate()) return;
    form_key.currentState.save();
    setState(
      () => _guardando = true,
    );
    if (_foto != null) {
      producto.imagen_url = await productoProvider.subirImagen(_foto);
    }
    if (producto.id == null) {
      producto.owner_id = _globalArguments.uid;
      productoProvider.crearProducto(producto);
      mostrarSnackbar('Registro Creado');
      setState(
        () => _guardando = false,
      );
    } else {
      productoProvider.editarProducto(producto);
      mostrarSnackbar('Registro Actualizado');
      setState(
        () => _guardando = false,
      );
    }
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _mostrarFoto() {
    if (producto.imagen_url != null) {
      return FadeInImage(
        image: NetworkImage(producto.imagen_url),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300,
        fit: BoxFit.contain
      );
    } else {
      if (_foto != null) {
        return Image.file(
          _foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  Future _seleccionarFoto() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _foto = File(pickedImage.path);
      } else {
        print('Imagen no seleccionada');
      }
    });
  }

  Future _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: origen,
      maxHeight: 720,
      maxWidth: 720,
    );

    _foto = (pickedFile != null) ? File(pickedFile.path) : _foto;
    if (_foto != null) {
      producto.imagen_url = null;
    }
    setState(() {});
  }
}
