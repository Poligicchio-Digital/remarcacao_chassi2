import 'package:objectbox/objectbox.dart';


@Entity()
class Funcionario{
  int id;
  String descricaoFuncionario;
  int idEquipe;
  String descricaoEquipe;

   Funcionario(this.id, this.descricaoFuncionario,this.idEquipe, this.descricaoEquipe);

}