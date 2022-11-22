import 'package:objectbox/objectbox.dart';

@Entity()
class FiltroStatus {
  int id;
  bool AceitaNovo;
  bool AceitaModificado;
  bool AceitaFinalizado;

  FiltroStatus(
      this.id, this.AceitaNovo, this.AceitaModificado, this.AceitaFinalizado);
}
