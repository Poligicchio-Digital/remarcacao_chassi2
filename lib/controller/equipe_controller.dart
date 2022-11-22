import 'package:flutter/material.dart';
import 'package:remarcacao_chassi/database/objectbox_database.dart';
import 'package:remarcacao_chassi/model/equipes.dart';
import 'package:remarcacao_chassi/model/remarcacao.dart';
import '../database/objectbox.g.dart';

class EquipeController with ChangeNotifier {
  List<Equipes> _itemsEquipeConfig = [];

  /// Adicionando novo registro de equipe para a lista de remarcações
  /// parâmetro de entrada: Objeto do tipo Remarcacao
  Future<void> addEquipe(Equipes newEquipe) async {
    // Gravando no banco Object Box
    var store = await openStore();
    final box = await store.box<Equipes>();
    box.put(newEquipe);
    _itemsEquipeConfig.add(newEquipe);
    store.close();
    notifyListeners();
  }

  Future<List<Equipes>>
  lerEquipes(String filtro) async {
    var store = await openStore();
    final box = await store.box<Equipes>();
    final query = box.query().build();
    _itemsEquipeConfig = query.find();
    List<Equipes> retorno = [];
    retorno.addAll(_itemsEquipeConfig);
    query.close();
    store.close();
    notifyListeners();
    return retorno;
  }

  /// Ler lista com todas as Remarcações gravadas
  get itemsEquipeConfig => _itemsEquipeConfig;

  /// Apagar um item da Lista de Remarcações
  Future<void> deleteEquipe(int idParam) async {
    var store = await openStore();
    final box = await store.box<Equipes>();
    box.remove(idParam);
    store.close();
    _itemsEquipeConfig.removeWhere((element) => element.id == idParam);
    notifyListeners();
  }

  /// Modificar um item da Lista de Remarcações
  Future<void> modifyRemarcacao(
      int idParam, Remarcacao updateRemarcacao, String usuario) async {}

  /// Retorna um número inteiro com quantidade de itens de Remarcação da Lista
  int get itemsCountEquipes {
    return _itemsEquipeConfig.length;
  }
}

