import 'dart:math';

import 'package:App0Flutter_GabrielleAlmeidaCuba/data/dataHamburguer.dart';
import 'package:App0Flutter_GabrielleAlmeidaCuba/models/hamburguer.dart';
import 'package:flutter/material.dart';

class Lanches with ChangeNotifier {
  Map<String, Hamburguer> _itens = {...DATA_HAMBURGUER};

  List<Hamburguer> get all {
    return [..._itens.values];
  }

  int get count {
    return _itens.length;
  }

  Hamburguer byIndex(int i) {
    return _itens.values.elementAt(i);
  }

  void put(Hamburguer hamburguer) {
    if (hamburguer == null) {
      return;
    }

    //adicionar
    final id = Random().nextDouble().toString();
    _itens.putIfAbsent(
        id,
        () => Hamburguer(
            id: id,
            nome: hamburguer.nome,
            pao: hamburguer.pao,
            hamburguer: hamburguer.hamburguer,
            queijo: hamburguer.queijo,
            molhos: hamburguer.molhos));

    notifyListeners();
  }

  void remove(Hamburguer hamburguer) {
    if (hamburguer != null && hamburguer.id != null) {
      _itens.remove(hamburguer.id);
      notifyListeners();
    }
  }
}
