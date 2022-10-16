import 'package:camwater_application/auth/login_screen.dart';
import 'package:camwater_application/auth/register_screen.dart';
import 'package:camwater_application/screens/acceuil.dart';
import 'package:camwater_application/screens/box/index_screen.dart';
import 'package:camwater_application/screens/box_screen.dart';
import 'package:camwater_application/screens/commercial_screen.dart';
import 'package:camwater_application/screens/home_screen.dart';
import 'package:camwater_application/screens/production_screen.dart';
import 'package:camwater_application/screens/statement_screen.dart';
import 'package:camwater_application/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}*/

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'index',
        routes: {
          'login': (context) => const LoginScreen(),
          'register': (context) => const RegisterScreen(),
          'sidebar': (context) => NavigationDrawerWidget(),
          'statement': (context) => const StatementScreen(),
          'box': (context) => const BoxScreen(),
          'production': (context) => const ProductionScreen(),
          //'commercial': (context) => const CommercialScreen(),
          'home': (context) => HomeScreen(),
          'acceuil': (context) => AcceuilScreen(),
          'index': (context) => Index(),
        }),
  );
}
