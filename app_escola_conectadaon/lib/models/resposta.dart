import 'comunicado.dart';
import 'responsavel.dart';

class Resposta {
  int? id;
  String mensagemResposta;
  Comunicado? comunicado;
  Responsavel? responsavel;
  Resposta(
      {this.id,
      required this.mensagemResposta,
      this.comunicado,
      this.responsavel});
  Map<String, dynamic> toJson() => {
        'id': id,
        'mensagemResposta': mensagemResposta,
        'comunicado': comunicado?.toJson(),
        'responsavel': responsavel?.toJson()
      };
}
