import 'package:App0Flutter_GabrielleAlmeidaCuba/views/cadastro.dart';
import 'package:App0Flutter_GabrielleAlmeidaCuba/views/homePedido.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:App0Flutter_GabrielleAlmeidaCuba/routes/appRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/auth.dart';

import 'package:shimmer/shimmer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();

  }


  bool validateAndSave() {
    final _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId = await widget.auth.LoginEmailSenha(_email, _password);

        print('Signed in : ${userId}');
        print('Deu certo');

        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Color.fromRGBO(238, 238, 238, 1),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("images/pops.jpg"),
              ),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                //autofocus: true,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value.isEmpty ? 'E-mail não pode ser vazio' : null,
                onSaved: (value) => _email = value,
                decoration: InputDecoration(
                    icon: Icon(Icons.mail),
                    labelText: "E-mail",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10),
                      ),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: (value) =>
                    value.isEmpty ? 'Password não pode ser vazio' : null,
                onSaved: (value) => _password = value,
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: "Senha",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10),
                      ),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                  height: 60,
                  width: 10,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(148, 8, 37, 10)),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            child: SizedBox(
                              child: Image.asset("images/beber.png"),
                              height: 35,
                              width: 35,
                            ),
                          )
                        ],
                      ),
                      onPressed: validateAndSubmit,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                child: FlatButton(
                  child: Text(
                    "Cadastra-se",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () => {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => CadastroPage()))
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
