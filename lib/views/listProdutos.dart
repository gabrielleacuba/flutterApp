import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListaProdutos extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ListaProdutos> {
  final _formKey = GlobalKey<FormState>();
  var snapshots = Firestore.instance.collection('Lanches').snapshots();
  var db = Firestore.instance;

  String _quantidade;
  String _nome;
  String _id;
  String _descricao;
  double _valor;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: StreamBuilder<QuerySnapshot>(
        stream: snapshots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  leading:
                      CircleAvatar(child: Image.asset('images/IconeTeste.png')),
                  title: Text(item['nome']),
                  subtitle: Text(item['ID'].toString()),
                  trailing: Text(item['valor'].toString()),
                  onTap: () => {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: SingleChildScrollView(
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            item['nome'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  148, 8, 37, 10),
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Image.asset("images/pops.jpg"),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            item['descricao'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[600],
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Quantidade: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (value) => value.isEmpty
                                              ? 'Quantidade não pode ser vazio'
                                              : null,
                                          onSaved: (value) =>
                                              _quantidade = value,
                                          decoration: InputDecoration(
                                              labelText: "Quantidade",
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10),
                                                ),
                                              ),
                                              labelStyle: TextStyle(
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20)),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                      ],
                                    )),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Não"),
                                  onPressed: () {
                                    Navigator.of(context).pop("Cancel");
                                  },
                                ),
                                FlatButton(
                                    child: Text("Adicionar ao carrinho"),
                                    color: Colors.green,
                                    onPressed: () {
                                      _nome = item['nome'];
                                      _id = item['ID'].toString();
                                      _descricao = item['descricao'];
                                      _valor = item['valor'];

                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        adicionarNoCarrinho();
                                        Navigator.of(context).pop();
                                      }
                                    })
                              ],
                            ))
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

    void adicionarNoCarrinho() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await _firebaseAuth.currentUser();

    print(user.uid);
    await Firestore.instance.collection('Carrinho').add({
      "ID": user.uid,
      "nome": _nome,
      "descricao": _descricao,
      "quantidade": _quantidade,
      "valor": _valor
    });
  }
}