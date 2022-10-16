import 'package:flutter/material.dart';

import '../widget/navigation_drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 100, 0, 1),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            MyMenu(title: 'Acceuil', icon: Icons.home, warna: Colors.green),
            MyMenu(title: 'Caisse', icon: Icons.cases, warna: Colors.green),
            MyMenu(
                title: 'Commercial',
                icon: Icons.account_balance,
                warna: Colors.green),
            MyMenu(
                title: 'Production', icon: Icons.compost, warna: Colors.green),
            MyMenu(
                title: 'Relevé',
                icon: Icons.receipt_sharp,
                warna: Colors.green),
            MyMenu(
                title: 'Utilisateur', icon: Icons.people, warna: Colors.green),
          ],
        ),
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({required this.title, required this.icon, required this.warna});
  final String title;
  final IconData icon;
  final MaterialColor warna;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (title == 'Acceuil') {
            Navigator.pushNamed(context, 'acceuil');
          } else if (title == 'Caisse') {
            Navigator.pushNamed(context, 'box');
          } else if (title == 'Commercial') {
            Navigator.pushNamed(context, 'commercial');
          } else if (title == 'Production') {
            Navigator.pushNamed(context, 'production');
          } else if (title == 'Relevé') {
            Navigator.pushNamed(context, 'statement');
          } else if (title == 'Utilisateur') {
            Navigator.pushNamed(context, 'register');
          }
        },
        splashColor: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 70.0,
                color: warna,
              ),
              Text(
                title,
                style: new TextStyle(fontSize: 17.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
