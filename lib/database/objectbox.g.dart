// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../model/equipes.dart';
import '../model/filtro_status.dart';
import '../model/funcionario.dart';
import '../model/remarcacao.dart';
import '../model/seguradoras.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1571229257080599010),
      name: 'Equipes',
      lastPropertyId: const IdUid(2, 3742594129947613834),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 343572093289988198),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3742594129947613834),
            name: 'descricaoEquipe',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 2402174908766000985),
      name: 'Funcionario',
      lastPropertyId: const IdUid(4, 6598583493665341444),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2397318025731229632),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1789570523087893825),
            name: 'descricaoFuncionario',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8318764913009521633),
            name: 'idEquipe',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6598583493665341444),
            name: 'descricaoEquipe',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 4446043665694819746),
      name: 'Remarcacao',
      lastPropertyId: const IdUid(29, 3676513366621086982),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5578983989352611000),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1996199573287966372),
            name: 'tipoVeiculo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 9005987164651530290),
            name: 'proprietario',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 9060446803445880864),
            name: 'marcaModelo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3328411799266388173),
            name: 'placa',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2973938415520561868),
            name: 'nChassi',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 5309971990783016888),
            name: 'nMotor',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 6122964034682065631),
            name: 'nVidro',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 168112495991047250),
            name: 'oficioNum',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 3857991656013908309),
            name: 'numProtocolo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 7052834524096197807),
            name: 'local',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 3665104024331601146),
            name: 'equipe',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 7062128772769181055),
            name: 'seguradora',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 6234247945007998201),
            name: 'foto1',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 5718199863361888895),
            name: 'foto2',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 947710856429985936),
            name: 'foto3',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 8100561940667623731),
            name: 'foto4',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 5580072901530698128),
            name: 'descricaoFoto1',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 1794397071665462882),
            name: 'descricaoFoto2',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 7730227711598792859),
            name: 'descricaoFoto3',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(21, 2287270570853878967),
            name: 'descricaoFoto4',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(22, 7480258777440898820),
            name: 'dtGravacao',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(23, 617600913158156279),
            name: 'idUsuario',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(24, 2910466634926090800),
            name: 'usuarioCriou',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(25, 6847029920787448637),
            name: 'usuarioModificou',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(26, 4640434697411586522),
            name: 'usuarioVerificou',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(27, 7107531865929958762),
            name: 'dtVerificacao',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(28, 6427158214755749521),
            name: 'tipoGravacao',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(29, 3676513366621086982),
            name: 'aprovado',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 1701486782095804788),
      name: 'Seguradoras',
      lastPropertyId: const IdUid(2, 6680072543209585120),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3460582942757368687),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6680072543209585120),
            name: 'descricaoSeguradora',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 5887861995207060694),
      name: 'FiltroStatus',
      lastPropertyId: const IdUid(4, 808139669403446312),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 9205148119798636264),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8279562771828095551),
            name: 'AceitaNovo',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5526263391447482216),
            name: 'AceitaModificado',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 808139669403446312),
            name: 'AceitaFinalizado',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 5887861995207060694),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Equipes: EntityDefinition<Equipes>(
        model: _entities[0],
        toOneRelations: (Equipes object) => [],
        toManyRelations: (Equipes object) => {},
        getId: (Equipes object) => object.id,
        setId: (Equipes object, int id) {
          object.id = id;
        },
        objectToFB: (Equipes object, fb.Builder fbb) {
          final descricaoEquipeOffset = fbb.writeString(object.descricaoEquipe);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, descricaoEquipeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Equipes(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''));

          return object;
        }),
    Funcionario: EntityDefinition<Funcionario>(
        model: _entities[1],
        toOneRelations: (Funcionario object) => [],
        toManyRelations: (Funcionario object) => {},
        getId: (Funcionario object) => object.id,
        setId: (Funcionario object, int id) {
          object.id = id;
        },
        objectToFB: (Funcionario object, fb.Builder fbb) {
          final descricaoFuncionarioOffset =
              fbb.writeString(object.descricaoFuncionario);
          final descricaoEquipeOffset = fbb.writeString(object.descricaoEquipe);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, descricaoFuncionarioOffset);
          fbb.addInt64(2, object.idEquipe);
          fbb.addOffset(3, descricaoEquipeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Funcionario(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''));

          return object;
        }),
    Remarcacao: EntityDefinition<Remarcacao>(
        model: _entities[2],
        toOneRelations: (Remarcacao object) => [],
        toManyRelations: (Remarcacao object) => {},
        getId: (Remarcacao object) => object.id,
        setId: (Remarcacao object, int id) {
          object.id = id;
        },
        objectToFB: (Remarcacao object, fb.Builder fbb) {
          final tipoVeiculoOffset = fbb.writeString(object.tipoVeiculo);
          final proprietarioOffset = fbb.writeString(object.proprietario);
          final marcaModeloOffset = fbb.writeString(object.marcaModelo);
          final placaOffset = fbb.writeString(object.placa);
          final nChassiOffset = fbb.writeString(object.nChassi);
          final nMotorOffset = fbb.writeString(object.nMotor);
          final nVidroOffset = fbb.writeString(object.nVidro);
          final oficioNumOffset = fbb.writeString(object.oficioNum);
          final numProtocoloOffset = fbb.writeString(object.numProtocolo);
          final localOffset = fbb.writeString(object.local);
          final equipeOffset = fbb.writeString(object.equipe);
          final seguradoraOffset = fbb.writeString(object.seguradora);
          final foto1Offset = fbb.writeString(object.foto1);
          final foto2Offset = fbb.writeString(object.foto2);
          final foto3Offset = fbb.writeString(object.foto3);
          final foto4Offset = fbb.writeString(object.foto4);
          final descricaoFoto1Offset = fbb.writeString(object.descricaoFoto1);
          final descricaoFoto2Offset = fbb.writeString(object.descricaoFoto2);
          final descricaoFoto3Offset = fbb.writeString(object.descricaoFoto3);
          final descricaoFoto4Offset = fbb.writeString(object.descricaoFoto4);
          final idUsuarioOffset = fbb.writeString(object.idUsuario);
          final usuarioCriouOffset = fbb.writeString(object.usuarioCriou);
          final usuarioModificouOffset = object.usuarioModificou == null
              ? null
              : fbb.writeString(object.usuarioModificou!);
          final usuarioVerificouOffset = object.usuarioVerificou == null
              ? null
              : fbb.writeString(object.usuarioVerificou!);
          final tipoGravacaoOffset = fbb.writeString(object.tipoGravacao);
          fbb.startTable(30);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, tipoVeiculoOffset);
          fbb.addOffset(2, proprietarioOffset);
          fbb.addOffset(3, marcaModeloOffset);
          fbb.addOffset(4, placaOffset);
          fbb.addOffset(5, nChassiOffset);
          fbb.addOffset(6, nMotorOffset);
          fbb.addOffset(7, nVidroOffset);
          fbb.addOffset(8, oficioNumOffset);
          fbb.addOffset(9, numProtocoloOffset);
          fbb.addOffset(10, localOffset);
          fbb.addOffset(11, equipeOffset);
          fbb.addOffset(12, seguradoraOffset);
          fbb.addOffset(13, foto1Offset);
          fbb.addOffset(14, foto2Offset);
          fbb.addOffset(15, foto3Offset);
          fbb.addOffset(16, foto4Offset);
          fbb.addOffset(17, descricaoFoto1Offset);
          fbb.addOffset(18, descricaoFoto2Offset);
          fbb.addOffset(19, descricaoFoto3Offset);
          fbb.addOffset(20, descricaoFoto4Offset);
          fbb.addInt64(21, object.dtGravacao.millisecondsSinceEpoch);
          fbb.addOffset(22, idUsuarioOffset);
          fbb.addOffset(23, usuarioCriouOffset);
          fbb.addOffset(24, usuarioModificouOffset);
          fbb.addOffset(25, usuarioVerificouOffset);
          fbb.addInt64(26, object.dtVerificacao?.millisecondsSinceEpoch);
          fbb.addOffset(27, tipoGravacaoOffset);
          fbb.addBool(28, object.aprovado);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dtVerificacaoValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 56);
          final object = Remarcacao(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              tipoVeiculo: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              proprietario: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              marcaModelo: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              placa: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, ''),
              nChassi: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              nMotor: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 16, ''),
              nVidro: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 18, ''),
              oficioNum:
                  const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 20, ''),
              numProtocolo: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 22, ''),
              local: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 24, ''),
              seguradora: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 28, ''),
              equipe: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 26, ''),
              foto1: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 30, ''),
              foto2: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 32, ''),
              foto3: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 34, ''),
              foto4: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 36, ''),
              descricaoFoto1: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 38, ''),
              descricaoFoto2: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 40, ''),
              descricaoFoto3: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 42, ''),
              descricaoFoto4: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 44, ''),
              idUsuario: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 48, ''),
              tipoGravacao: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 58, ''),
              aprovado: const fb.BoolReader().vTableGet(buffer, rootOffset, 60, false))
            ..dtGravacao = DateTime.fromMillisecondsSinceEpoch(
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 46, 0))
            ..usuarioCriou = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 50, '')
            ..usuarioModificou = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 52)
            ..usuarioVerificou = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 54)
            ..dtVerificacao = dtVerificacaoValue == null ? null : DateTime.fromMillisecondsSinceEpoch(dtVerificacaoValue);

          return object;
        }),
    Seguradoras: EntityDefinition<Seguradoras>(
        model: _entities[3],
        toOneRelations: (Seguradoras object) => [],
        toManyRelations: (Seguradoras object) => {},
        getId: (Seguradoras object) => object.id,
        setId: (Seguradoras object, int id) {
          object.id = id;
        },
        objectToFB: (Seguradoras object, fb.Builder fbb) {
          final descricaoSeguradoraOffset =
              fbb.writeString(object.descricaoSeguradora);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, descricaoSeguradoraOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Seguradoras(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''));

          return object;
        }),
    FiltroStatus: EntityDefinition<FiltroStatus>(
        model: _entities[4],
        toOneRelations: (FiltroStatus object) => [],
        toManyRelations: (FiltroStatus object) => {},
        getId: (FiltroStatus object) => object.id,
        setId: (FiltroStatus object, int id) {
          object.id = id;
        },
        objectToFB: (FiltroStatus object, fb.Builder fbb) {
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addBool(1, object.AceitaNovo);
          fbb.addBool(2, object.AceitaModificado);
          fbb.addBool(3, object.AceitaFinalizado);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = FiltroStatus(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              const fb.BoolReader().vTableGet(buffer, rootOffset, 6, false),
              const fb.BoolReader().vTableGet(buffer, rootOffset, 8, false),
              const fb.BoolReader().vTableGet(buffer, rootOffset, 10, false));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Equipes] entity fields to define ObjectBox queries.
class Equipes_ {
  /// see [Equipes.id]
  static final id = QueryIntegerProperty<Equipes>(_entities[0].properties[0]);

  /// see [Equipes.descricaoEquipe]
  static final descricaoEquipe =
      QueryStringProperty<Equipes>(_entities[0].properties[1]);
}

/// [Funcionario] entity fields to define ObjectBox queries.
class Funcionario_ {
  /// see [Funcionario.id]
  static final id =
      QueryIntegerProperty<Funcionario>(_entities[1].properties[0]);

  /// see [Funcionario.descricaoFuncionario]
  static final descricaoFuncionario =
      QueryStringProperty<Funcionario>(_entities[1].properties[1]);

  /// see [Funcionario.idEquipe]
  static final idEquipe =
      QueryIntegerProperty<Funcionario>(_entities[1].properties[2]);

  /// see [Funcionario.descricaoEquipe]
  static final descricaoEquipe =
      QueryStringProperty<Funcionario>(_entities[1].properties[3]);
}

/// [Remarcacao] entity fields to define ObjectBox queries.
class Remarcacao_ {
  /// see [Remarcacao.id]
  static final id =
      QueryIntegerProperty<Remarcacao>(_entities[2].properties[0]);

  /// see [Remarcacao.tipoVeiculo]
  static final tipoVeiculo =
      QueryStringProperty<Remarcacao>(_entities[2].properties[1]);

  /// see [Remarcacao.proprietario]
  static final proprietario =
      QueryStringProperty<Remarcacao>(_entities[2].properties[2]);

  /// see [Remarcacao.marcaModelo]
  static final marcaModelo =
      QueryStringProperty<Remarcacao>(_entities[2].properties[3]);

  /// see [Remarcacao.placa]
  static final placa =
      QueryStringProperty<Remarcacao>(_entities[2].properties[4]);

  /// see [Remarcacao.nChassi]
  static final nChassi =
      QueryStringProperty<Remarcacao>(_entities[2].properties[5]);

  /// see [Remarcacao.nMotor]
  static final nMotor =
      QueryStringProperty<Remarcacao>(_entities[2].properties[6]);

  /// see [Remarcacao.nVidro]
  static final nVidro =
      QueryStringProperty<Remarcacao>(_entities[2].properties[7]);

  /// see [Remarcacao.oficioNum]
  static final oficioNum =
      QueryStringProperty<Remarcacao>(_entities[2].properties[8]);

  /// see [Remarcacao.numProtocolo]
  static final numProtocolo =
      QueryStringProperty<Remarcacao>(_entities[2].properties[9]);

  /// see [Remarcacao.local]
  static final local =
      QueryStringProperty<Remarcacao>(_entities[2].properties[10]);

  /// see [Remarcacao.equipe]
  static final equipe =
      QueryStringProperty<Remarcacao>(_entities[2].properties[11]);

  /// see [Remarcacao.seguradora]
  static final seguradora =
      QueryStringProperty<Remarcacao>(_entities[2].properties[12]);

  /// see [Remarcacao.foto1]
  static final foto1 =
      QueryStringProperty<Remarcacao>(_entities[2].properties[13]);

  /// see [Remarcacao.foto2]
  static final foto2 =
      QueryStringProperty<Remarcacao>(_entities[2].properties[14]);

  /// see [Remarcacao.foto3]
  static final foto3 =
      QueryStringProperty<Remarcacao>(_entities[2].properties[15]);

  /// see [Remarcacao.foto4]
  static final foto4 =
      QueryStringProperty<Remarcacao>(_entities[2].properties[16]);

  /// see [Remarcacao.descricaoFoto1]
  static final descricaoFoto1 =
      QueryStringProperty<Remarcacao>(_entities[2].properties[17]);

  /// see [Remarcacao.descricaoFoto2]
  static final descricaoFoto2 =
      QueryStringProperty<Remarcacao>(_entities[2].properties[18]);

  /// see [Remarcacao.descricaoFoto3]
  static final descricaoFoto3 =
      QueryStringProperty<Remarcacao>(_entities[2].properties[19]);

  /// see [Remarcacao.descricaoFoto4]
  static final descricaoFoto4 =
      QueryStringProperty<Remarcacao>(_entities[2].properties[20]);

  /// see [Remarcacao.dtGravacao]
  static final dtGravacao =
      QueryIntegerProperty<Remarcacao>(_entities[2].properties[21]);

  /// see [Remarcacao.idUsuario]
  static final idUsuario =
      QueryStringProperty<Remarcacao>(_entities[2].properties[22]);

  /// see [Remarcacao.usuarioCriou]
  static final usuarioCriou =
      QueryStringProperty<Remarcacao>(_entities[2].properties[23]);

  /// see [Remarcacao.usuarioModificou]
  static final usuarioModificou =
      QueryStringProperty<Remarcacao>(_entities[2].properties[24]);

  /// see [Remarcacao.usuarioVerificou]
  static final usuarioVerificou =
      QueryStringProperty<Remarcacao>(_entities[2].properties[25]);

  /// see [Remarcacao.dtVerificacao]
  static final dtVerificacao =
      QueryIntegerProperty<Remarcacao>(_entities[2].properties[26]);

  /// see [Remarcacao.tipoGravacao]
  static final tipoGravacao =
      QueryStringProperty<Remarcacao>(_entities[2].properties[27]);

  /// see [Remarcacao.aprovado]
  static final aprovado =
      QueryBooleanProperty<Remarcacao>(_entities[2].properties[28]);
}

/// [Seguradoras] entity fields to define ObjectBox queries.
class Seguradoras_ {
  /// see [Seguradoras.id]
  static final id =
      QueryIntegerProperty<Seguradoras>(_entities[3].properties[0]);

  /// see [Seguradoras.descricaoSeguradora]
  static final descricaoSeguradora =
      QueryStringProperty<Seguradoras>(_entities[3].properties[1]);
}

/// [FiltroStatus] entity fields to define ObjectBox queries.
class FiltroStatus_ {
  /// see [FiltroStatus.id]
  static final id =
      QueryIntegerProperty<FiltroStatus>(_entities[4].properties[0]);

  /// see [FiltroStatus.AceitaNovo]
  static final AceitaNovo =
      QueryBooleanProperty<FiltroStatus>(_entities[4].properties[1]);

  /// see [FiltroStatus.AceitaModificado]
  static final AceitaModificado =
      QueryBooleanProperty<FiltroStatus>(_entities[4].properties[2]);

  /// see [FiltroStatus.AceitaFinalizado]
  static final AceitaFinalizado =
      QueryBooleanProperty<FiltroStatus>(_entities[4].properties[3]);
}