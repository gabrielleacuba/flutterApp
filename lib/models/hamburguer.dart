import 'package:flutter/cupertino.dart';

class Hamburguer {
  final String id;
  final String nome;
  final String pao;
  final String hamburguer;
  final String queijo;
  final String molhos;

  const Hamburguer({
    this.id,
    @required this.nome,
    @required this.pao,
    @required this.hamburguer,
    @required this.queijo,
    @required this.molhos,
  });
}
