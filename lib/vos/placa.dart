import 'package:remarcacao_chassi/vos/value_object.dart';

class PlacaAux implements ValueObject{
  final String _value;
  PlacaAux(this._value);

  @override
  String? validator([Object? obj]){

    if(_value.isEmpty){
      return "É obrigatório o preenchimento do campo placa";
    }

    if(_value.length > 7){
      return "Preenchimento inválido, tamanho máximo 7 caracteres";
    }else{
      if(!_value.substring(0,2).contains(RegExp('0-9')) || !_value.substring(3,6).contains(RegExp('A-Z'))){
        return "Placa inválida, favor verificar";
      }

    }
    return null;
  }

}