import 'package:flutter/material.dart';
import 'package:proyectounderway/constants.dart';
import 'package:proyectounderway/src/pages/details/components/app_bar.dart';
import 'package:proyectounderway/src/pages/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(),
      body: Body(),
    );
  }
}
