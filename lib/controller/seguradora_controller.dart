import 'package:flutter/material.dart';
import 'package:remarcacao_chassi/model/seguradoras.dart';
import '../database/objectbox.g.dart';


class SeguradoraController with ChangeNotifier {
  List<Seguradoras> _itemsSeguradorasConfig = [];

  /// Adicionando novo registro de equipe para a lista de remarcações
  /// parâmetro de entrada: Objeto do tipo Remarcacao
  Future<void> addSeguradora(Seguradoras newSeguradora) async {
    var store = await openStore();
    final box = await store.box<Seguradoras>();
    box.put(newSeguradora);
    store.close();
    _itemsSeguradorasConfig.add(newSeguradora);
    notifyListeners();
  }

  Future<List<Seguradoras>> lerSeguradora(String filtro) async {
    var store = await openStore();
    final box = await store.box<Seguradoras>();
    final query = box.query().build();
    _itemsSeguradorasConfig = query.find();
    List<Seguradoras> retorno = [];
    retorno.addAll(_itemsSeguradorasConfig);
    query.close();
    store.close();
    notifyListeners();
    return retorno;
  }

  /// Ler lista com todas as Remarcações gravadas
  get itemsSeguradorasConfig => _itemsSeguradorasConfig;

  /// Apagar um item da Lista de Remarcações
  Future<void> deleteSeguradora(int idParam) async {
    var store = await openStore();
    final box = await store.box<Seguradoras>();
    box.remove(idParam);
    store.close();
    _itemsSeguradorasConfig.removeWhere((element) => element.id == idParam);
    notifyListeners();
  }

  /// Apagar um item da Lista de Remarcações
  // Future<void> modifyRemarcacao(int idParam, Remarcacao updateRemarcacao, String usuario) async{
  //
  // }

  /// Retorna um número inteiro com quantidade de itens de Remarcação da Lista
  int get itemsCountSeguradora {
    return _itemsSeguradorasConfig.length;
  }
}
