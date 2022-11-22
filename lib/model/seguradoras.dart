import 'package:objectbox/objectbox.dart';

@Entity()
class Seguradoras{

  int id;
  String descricaoSeguradora;

  Seguradoras(this.id, this.descricaoSeguradora);

}