import 'dart:async';
import 'package:App0Flutter_GabrielleAlmeidaCuba/models/auth.dart';
import 'package:App0Flutter_GabrielleAlmeidaCuba/views/listCart.dart';
import 'package:App0Flutter_GabrielleAlmeidaCuba/views/listProdutos.dart';
import 'package:flutter/material.dart';


class HomePedido extends StatefulWidget {
  HomePedido({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<HomePedido> {

  PageController _pageController = PageController();
  int _selectedIndex = 0;
  int _selectedPage = 0;
  final _pageOptions = [];

  List<Widget> _screens = [ListaProdutos(), ListaCart()];


  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pop's Burguer"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: _signOut)
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.fastfood,
                color: _selectedIndex == 0 ? Colors.green : Colors.grey,
              ),
              title: Text('Lanches',
                style: TextStyle(
                  color: _selectedIndex == 0 ? Colors.green : Colors.grey,
                ),
              )
              //backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                color: _selectedIndex == 1 ? Colors.green : Colors.grey),
            title: Text(
              'Pedidos',
              style: TextStyle(
                  color: _selectedIndex == 1 ? Colors.green : Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
