import 'package:objectbox/objectbox.dart';

@Entity()
class Remarcacao {
  int id; //Chave únicde
  late String tipoVeiculo; // Moto / Reboque / Outros
  late String proprietario; //PROPRIETÁRIO XXXX
  late String marcaModelo; //MARCA/MODELO XXXX
  late String placa; //PLACA XXXX
  late String nChassi; //Nº CHASSI XXXX
  late String nMotor; //Nº MOTOR XX
  late String nVidro; //Nº VIDRO
  late String oficioNum; //OFÍCIO DE Nº XXXX
  late String numProtocolo; //Nº PROTOCOLO XXXX
  late String local; // Novo Local
  late String equipe; // Novo Equipe
  late String seguradora; // Seguradora
  // late String foto1; //Foto numero 1 XXXX
  late String foto1; //Foto numero 1 XXXX
  late String foto2; //Foto numero 2 XXXX
  late String foto3; //Foto numero 3 XXXX
  late String foto4; //Foto numero 4 XXXX
  // Descrição de Fotos
  late String descricaoFoto1; //Foto numero 1 XXXX
  late String descricaoFoto2; //Foto numero 2 XXXX
  late String descricaoFoto3; //Foto numero 3 XXXX
  late String descricaoFoto4; //Foto numero 4 XXXX
  late DateTime dtGravacao; //Data gravação
  late  String idUsuario; // Usuario Processando
  late String usuarioCriou; //Usuario criou
  String? usuarioModificou; //Usuario criou
  String? usuarioVerificou; //Usuario verificou
  DateTime? dtVerificacao; //Data Verificação
  // late TipoGravacaoEnum tipoGravacao; // N = Novo , M= Modificação, A = Aprovação
  late String tipoGravacao;
  late bool aprovado;

  Remarcacao({
    required this.id,
    required this.tipoVeiculo,
    required this.proprietario,
    required this.marcaModelo,
    required this.placa,
    required this.nChassi,
    required this.nMotor,
    required this.nVidro,
    required this.oficioNum,
    required this.numProtocolo,
    required this.local,
    required this.seguradora,
    required this.equipe,
    required this.foto1,
    required this.foto2,
    required this.foto3,
    required this.foto4,
    required this.descricaoFoto1,
    required this.descricaoFoto2,
    required this.descricaoFoto3,
    required this.descricaoFoto4,
    required this.idUsuario,
    required this.tipoGravacao,
    required this.aprovado,
  });
}
