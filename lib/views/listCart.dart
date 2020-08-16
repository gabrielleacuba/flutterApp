import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth.dart';
import 'dart:async';

class ListaCart extends StatefulWidget {
  ListaCart({this.id});
  final String id;
  @override
  _State createState() => _State();
}

class _State extends State<ListaCart> {
  String _uid_user;

  @override
  void initState() {
    getIdBanco();
  }

  Future<String> getIdBanco() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await _firebaseAuth.currentUser();
    print("Id user" + user.uid);
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    var snapshots = Firestore.instance
        .collection('Carrinho')
        .where('ID', isEqualTo: getIdBanco())
        .snapshots();

    return Scaffold(
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        //future: FirebaseAuth.instance.currentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return
            /* 
            Center(
              child: Text(snapshot.data.uid),
            );*/
            StreamBuilder<QuerySnapshot>(
              
              stream: Firestore.instance
                      .collection('Carrinho')
                      .where('ID', isEqualTo: snapshot.data.uid)
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int i) {
                    var item = snapshot.data.documents[i];

                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      child: ListTile(
                        //isThreeLine: true,
                        leading: CircleAvatar(
                            child: Image.asset('images/IconeTeste.png')),
                        title: Text(item['nome']),
                        subtitle: Text(item['descricao'].toString()),
                        trailing: Text(item['quantidade'].toString()),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
