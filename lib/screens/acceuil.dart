import 'package:camwater_application/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class AcceuilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Acceuil'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 100, 0, 1),
        ),
      );
}
