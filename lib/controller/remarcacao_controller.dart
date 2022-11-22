import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/model/remarcacao.dart';
import '../database/objectbox.g.dart';
import '../model/filtro_status.dart';
import 'filtro_controller.dart';

class RemarcacaoController with ChangeNotifier {
  List<Remarcacao> _itemsRemarcacao = [];

  /// Adicionando novo registro de remarcação para a lista de remarcações
  /// parâmetro de entrada: Objeto do tipo Remarcacao
  Future<void> addRemarcacao(Remarcacao newRemarcacao) async {
    switch (newRemarcacao.tipoGravacao) {
      // Registro Novo
      // case TipoGravacaoEnum.N:
      case 'N':
        newRemarcacao.dtGravacao = DateTime.now();
        newRemarcacao.usuarioCriou = newRemarcacao.idUsuario;
        break;
      // Modificação de Registro
      // case TipoGravacaoEnum.M:
      case "M":
        newRemarcacao.dtGravacao = DateTime.now();
        newRemarcacao.usuarioModificou = newRemarcacao.idUsuario;
        break;
      // Aprovação de Registro (Verificação)
      // case TipoGravacaoEnum.A:
      case "A":
        newRemarcacao.dtGravacao = DateTime.now();
        newRemarcacao.dtVerificacao = DateTime.now();
        newRemarcacao.usuarioVerificou = newRemarcacao.idUsuario;
        break;
      // Cancelamento (Verificação)
      //   case TipoGravacaoEnum.C:
      case "C":
        newRemarcacao.dtGravacao = DateTime.now();
        newRemarcacao.dtVerificacao = DateTime.now();
        newRemarcacao.usuarioVerificou = newRemarcacao.idUsuario;
        break;
    }

    var store = await openStore();
    final box = await store.box<Remarcacao>();
    box.put(newRemarcacao);
    store.close();

    _itemsRemarcacao.add(newRemarcacao);
    notifyListeners();
  }

  /// Ler lista com todas as Remarcações gravadas
  Future<List<Remarcacao>> lerRemarcacao(
      String filtro, BuildContext context) async {
    bool swithStatusNovo = true;
    bool swithStatusModificado = true;
    bool swithStatusImpresso = true;
    String StatusEquals = "";
    String StatusEquals2 = "";

    List<FiltroStatus> filtroSalvos = [];
    await Provider.of<FiltroStatusController>(context, listen: false)
        .lerFitros("")
        .then((value) => filtroSalvos.addAll(value));

    if (filtroSalvos.isNotEmpty) {
      var filtro = filtroSalvos[0];
      swithStatusNovo = filtro.AceitaNovo;
      swithStatusModificado = filtro.AceitaModificado;
      swithStatusImpresso = filtro.AceitaFinalizado;

      if (swithStatusNovo && !swithStatusModificado && !swithStatusImpresso) {
        StatusEquals = "N";
      }

      if (!swithStatusNovo && !swithStatusModificado && !swithStatusImpresso) {
        StatusEquals = "X";
      }

      if (!swithStatusNovo && swithStatusModificado && !swithStatusImpresso) {
        StatusEquals = "M";
      }

      if (!swithStatusNovo && !swithStatusModificado && swithStatusImpresso) {
        StatusEquals = "A";
      }

      if (swithStatusNovo && swithStatusModificado && !swithStatusImpresso) {
        StatusEquals = "N";
        StatusEquals2 = "M";
      }

      if (swithStatusNovo && !swithStatusModificado && swithStatusImpresso) {
        StatusEquals = "N";
        StatusEquals2 = "A";
      }

      if (!swithStatusNovo && swithStatusModificado && swithStatusImpresso) {
        StatusEquals = "M";
        StatusEquals2 = "A";
      }
    }

    if (StatusEquals == "") {
      var store = await openStore();
      final box = await store.box<Remarcacao>();
      final query = box.query(Remarcacao_.placa.contains(filtro)).build();
      _itemsRemarcacao = query.find();
      query.close();
      store.close();
    } else {
      if (StatusEquals2 == "") {
        var store = await openStore();
        final box = await store.box<Remarcacao>();
        final query = box
            .query(Remarcacao_.placa
                .contains(filtro)
                .and(Remarcacao_.tipoGravacao.equals(StatusEquals)))
            .build();
        _itemsRemarcacao = query.find();
        query.close();
        store.close();
      } else {
        var store = await openStore();
        final box = await store.box<Remarcacao>();
        final query = box
            .query(Remarcacao_.placa.contains(filtro).and(
                  Remarcacao_.tipoGravacao.equals(StatusEquals).or(
                        Remarcacao_.tipoGravacao.equals(StatusEquals2),
                      ),
                ))
            .build();
        _itemsRemarcacao = query.find();
        query.close();
        store.close();
      }
    }

    List<Remarcacao> retorno = [];
    if (_itemsRemarcacao.isNotEmpty) {
      retorno.addAll(_itemsRemarcacao);
    }

    notifyListeners();
    return retorno;
  }

  get itemsRemarcacao => _itemsRemarcacao;

  // get itemsRemarcacao => () {
  //   // await lerRemarcacao;
  //   _itemsRemarcacao;
  // };

  /// Apagar um item da Lista de Remarcações
  Future<void> deleteRemarcacao(int idParam) async {
    var store = await openStore();
    final box = await store.box<Remarcacao>();
    box.remove(idParam);
    store.close();
    _itemsRemarcacao.removeWhere((element) => element.id == idParam);
    notifyListeners();
  }

  /// Apagar um item da Lista de Remarcações
  Future<void> modifyRemarcacao(
      int idParam, Remarcacao updateRemarcacao, String usuario) async {
    var atual = _itemsRemarcacao.firstWhere((item) => item.id == idParam);
    if (updateRemarcacao != atual && atual.id != null) {
      atual.tipoVeiculo =
          updateRemarcacao.tipoVeiculo; // Moto / Reboque / Outros
      atual.proprietario = updateRemarcacao.proprietario; //PROPRIETÁRIO XXXX
      atual.marcaModelo = updateRemarcacao.marcaModelo; //MARCA/MODELO XXXX
      atual.placa = updateRemarcacao.placa; //PLACA XXXX
      atual.nChassi = updateRemarcacao.nChassi; //Nº CHASSI XXXX
      atual.nMotor = updateRemarcacao.nMotor; //Nº MOTOR XX
      atual.nVidro = updateRemarcacao.nVidro; //Nº VIDRO
      atual.oficioNum = updateRemarcacao.oficioNum; //OFÍCIO DE Nº XXXX
      atual.numProtocolo = updateRemarcacao.numProtocolo; //Nº PROTOCOLO XXXX
      atual.local = updateRemarcacao.local; // Novo Local
      atual.equipe = updateRemarcacao.equipe; // Novo Equipe
      atual.seguradora = updateRemarcacao.seguradora; // Seguradora
      atual.idUsuario = updateRemarcacao.idUsuario;
      atual.foto1 = updateRemarcacao.foto1; //Foto numero 1 XXXX
      atual.foto2 = updateRemarcacao.foto2; //Foto numero 2 XXXX
      atual.foto3 = updateRemarcacao.foto3; //Foto numero 3 XXXX
      atual.foto4 = updateRemarcacao.foto4; //Foto numero 4 XXXX
      atual.descricaoFoto1 =
          updateRemarcacao.descricaoFoto1; //Foto numero 4 XXXX
      atual.descricaoFoto2 =
          updateRemarcacao.descricaoFoto2; //Foto numero 4 XXXX
      atual.descricaoFoto3 =
          updateRemarcacao.descricaoFoto3; //Foto numero 4 XXXX
      atual.descricaoFoto4 =
          updateRemarcacao.descricaoFoto4; //Foto numero 4 XXXX
      atual.usuarioModificou = usuario; //Usuario criou
      // late String usuarioVerificou; //Usuario verificou
      atual.dtVerificacao = DateTime.now(); //Data Verificação
      atual.tipoGravacao = updateRemarcacao.tipoGravacao;
    }

    var store = await openStore();
    final box = await store.box<Remarcacao>();
    box.put(atual);
    store.close();
    notifyListeners();
    // _itemsRemarcacao.removeWhere((element) => element.id == idParam);
  }

  /// Retorna um número inteiro com quantidade de itens de Remarcação da Lista
  int get itemsCount {
    return _itemsRemarcacao.length;
  }
}
