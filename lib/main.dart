import 'package:App0Flutter_GabrielleAlmeidaCuba/models/hamburguer.dart';
import 'package:App0Flutter_GabrielleAlmeidaCuba/provider/lanches.dart';
import 'package:App0Flutter_GabrielleAlmeidaCuba/routes/appRoutes.dart';
import 'package:App0Flutter_GabrielleAlmeidaCuba/views/cadastro.dart';
import 'package:App0Flutter_GabrielleAlmeidaCuba/models/auth.dart';

import 'package:App0Flutter_GabrielleAlmeidaCuba/views/homePedido.dart';

import 'package:App0Flutter_GabrielleAlmeidaCuba/views/loginPage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:App0Flutter_GabrielleAlmeidaCuba/views/root_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Lanches(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pops Burguer',
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //home: SplashScreen(),

          routes: {
            AppRoutes.INICIO: (_) => RootPage(auth: new Auth()),
            AppRoutes.HOME: (_) => HomePedido(),

            AppRoutes.CADASTRO_FORM: (_) => CadastroPage(),
          },
        ));
  }
}
