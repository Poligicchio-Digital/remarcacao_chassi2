import 'package:objectbox/objectbox.dart';

@Entity()
class Equipes{
  int id;
  String descricaoEquipe;

  Equipes(this.id, this.descricaoEquipe);

}