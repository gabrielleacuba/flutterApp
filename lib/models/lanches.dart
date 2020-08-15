import 'package:flutter/cupertino.dart';

class LanchesHamburguer {
  final String nome;
  final String ingredientes;
  final String valor;
  final String id;

  const LanchesHamburguer({
    this.id,
    @required this.nome,
    @required this.ingredientes,
    @required this.valor,

  });
}