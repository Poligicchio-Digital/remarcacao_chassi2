import 'package:flutter/material.dart';
import 'package:remarcacao_chassi/model/funcionario.dart';
import '../database/objectbox.g.dart';

class FuncionarioController with ChangeNotifier {
  List<Funcionario> _itemsFuncionariosConfig = [];

  /// Adicionando novo registro de equipe para a lista de remarcações
  /// parâmetro de entrada: Objeto do tipo Remarcacao
  Future<void> addFuncionario(Funcionario newFuncionario) async {
    var store = await openStore();
    final box = await store.box<Funcionario>();
    box.put(newFuncionario);
    _itemsFuncionariosConfig.add(newFuncionario);
    store.close();
    notifyListeners();
  }

  Future<List<Funcionario>> lerFuncionario(String filtro) async {
    var store = await openStore();
    final box = await store.box<Funcionario>();
    final query = box.query().build();
    _itemsFuncionariosConfig = query.find();
    List<Funcionario> retorno = [];
    retorno.addAll(_itemsFuncionariosConfig);
    query.close();
    store.close();
    notifyListeners();
    return retorno;
  }

  /// Ler lista com todas as Remarcações gravadas
  get itemsFuncionariosConfig => _itemsFuncionariosConfig;

  /// Apagar um item da Lista de Remarcações
  Future<void> deleteFuncionario(int idParam) async {
    var store = await openStore();
    final box = await store.box<Funcionario>();
    box.remove(idParam);
    store.close();
    _itemsFuncionariosConfig.removeWhere((element) => element.id == idParam);
    notifyListeners();
  }

  /// Apagar um item da Lista de Remarcações
  // Future<void> modifyRemarcacao(
  //     int idParam, Remarcacao updateRemarcacao, String usuario) async {}

  /// Retorna um número inteiro com quantidade de itens de Remarcação da Lista
  int get itemsCountFuncionarios {
    return _itemsFuncionariosConfig.length;
  }
}
