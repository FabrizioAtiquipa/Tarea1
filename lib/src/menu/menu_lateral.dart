import 'package:flutter/material.dart';
import 'package:proyectounderway/src/menu/background_lateral.dart';
import 'package:proyectounderway/src/pages/Map/map_page.dart';
import 'package:proyectounderway/src/pages/products/home_page.dart';
import 'package:proyectounderway/src/pages/products/transportista_page.dart';
import 'package:proyectounderway/src/utils/global_arguments.dart';

class LateraPage extends StatefulWidget {
  @override
  _LateraPageState createState() => _LateraPageState();
}

class _LateraPageState extends State<LateraPage> {
  GlobalArguments _globalArguments = GlobalArguments();
  
  @override
  Widget build(BuildContext context) {
    final name = _globalArguments.name;
    final email = _globalArguments.email;
    final urlImagen = _globalArguments.url_perfil;
    return Drawer(
      child: Material(
        color: Colors.green,
        child: Stack(
          children: [
            crearFondo(context),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              children: [
                _menuHeader(
                  urlImagen: urlImagen,
                  name: name,
                  email: email,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      _menuItem(
                          text: 'Mis Cargas',
                          icon: Icons.calendar_today,
                          onClicked: () => selectedItem(context, 0)),
                      SizedBox(height: 15),
                      _menuItem(text: 'Mapa', icon: Icons.map_outlined,onClicked: () => selectedItem(context, 1)),
                      SizedBox(height: 15),
                      _menuItem(
                          text: 'Modo Transportista', icon: Icons.workspaces_outline,onClicked: () => selectedItem(context, 2)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({String text, IconData icon, VoidCallback onClicked}) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Widget _menuHeader({String urlImagen, String name, String email}) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35.0,
              child: CircleAvatar(
                  maxRadius: 30, backgroundImage: NetworkImage(urlImagen)),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MapScreen(),
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Transportista(),
      ));
      break;
  }
}
