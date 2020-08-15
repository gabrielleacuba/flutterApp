import 'package:App0Flutter_GabrielleAlmeidaCuba/views/homePedido.dart';
import 'package:flutter/material.dart';
import './loginPage.dart';
import '../models/auth.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _State createState() => _State();
}

enum AuthStatus { naoLogado, logado }

class _State extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.naoLogado;

  @override
  void initState() {
    
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
       _authStatus = userId == null ? AuthStatus.naoLogado : AuthStatus.logado;
      });
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.logado;
    });
  }

  void _signedOut(){
    setState(() {
      _authStatus = AuthStatus.naoLogado;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_authStatus == AuthStatus.naoLogado) {
      return new LoginPage(
        auth: widget.auth,
        onSignedIn: _signedIn,
      );
    } else if (_authStatus == AuthStatus.logado) {
      return new HomePedido(
        auth: widget.auth,
        onSignedOut: _signedOut,
      );
    }
  }
}
