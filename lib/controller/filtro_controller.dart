import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/controller/remarcacao_controller.dart';
import 'package:remarcacao_chassi/model/filtro_status.dart';
import '../database/objectbox.g.dart';

class FiltroStatusController with ChangeNotifier {
  List<FiltroStatus> _itemsFiltroConfig = [];

  /// Adicionando novo registro de equipe para a lista de remarcações
  /// parâmetro de entrada: Objeto do tipo Remarcacao
  Future<void> addFiltro(FiltroStatus newFitro, BuildContext context) async {

    if(_itemsFiltroConfig.isNotEmpty){
      newFitro.id = _itemsFiltroConfig[0].id;
    }

    // Gravando no banco Object Box
    var store = await openStore();
    final box = await store.box<FiltroStatus>();
    box.put(newFitro);
    store.close();

    // EM MEMÓRIA
    if(_itemsFiltroConfig.isEmpty){
      _itemsFiltroConfig.add(newFitro);
    }else{
      var atual = _itemsFiltroConfig[0];
      atual.AceitaNovo = newFitro.AceitaNovo;
      atual.AceitaModificado = newFitro.AceitaModificado;
      atual.AceitaFinalizado = newFitro.AceitaFinalizado;
    }
    // notifyListeners();

    await Provider.of<RemarcacaoController>(context,
        listen: false)
        .lerRemarcacao("", context);

    notifyListeners();
  }

  Future<List<FiltroStatus>> lerFitros(String filtro) async {
    var store = await openStore();
    final box = await store.box<FiltroStatus>();
    final query = await box.query().build();
    _itemsFiltroConfig = await query.find();
    List<FiltroStatus> retorno = [];
    if(_itemsFiltroConfig.isNotEmpty){
      retorno.add(_itemsFiltroConfig[0]);
    }
    query.close();
    store.close();
    notifyListeners();
    return retorno;
  }

  /// Ler lista com todas as Remarcações gravadas
  get itemsFiltroConfig => _itemsFiltroConfig;

  /// Apagar um item da Lista de Remarcações
  Future<void> deleteFiltro(int idParam) async {
    var store = await openStore();
    final box = await store.box<FiltroStatus>();
    box.remove(idParam);
    store.close();
    _itemsFiltroConfig.removeWhere((element) => element.id == idParam);
    notifyListeners();
  }

  /// Modificar um item da Lista de Remarcações
  // Future<void> modifyFiltro(int idParam, bool novoParam, bool modificadoParam, bool impressoParam) async {
  //   var atual = _itemsFiltroConfig.firstWhere((element) => element.id == idParam);
  //   atual.AceitaNovo = novoParam;
  //   atual.AceitaModificado = modificadoParam;
  //   atual.AceitaFinalizado = impressoParam;
  //   notifyListeners();
  // }

  /// Retorna um número inteiro com quantidade de itens de Remarcação da Lista
  int get itemsCountFiltros {
    return _itemsFiltroConfig.length;
  }
}

