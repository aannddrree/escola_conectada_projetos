import 'aluno.dart';
import 'professor.dart';

class Comunicado {
  int? id;
  String titulo;
  String mensagem;
  String? dataEnvio;
  Professor? professor;
  Aluno? aluno;
  Comunicado(
      {this.id,
      required this.titulo,
      required this.mensagem,
      this.dataEnvio,
      this.professor,
      this.aluno});
  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'mensagem': mensagem,
        'professor': professor?.toJson(),
        'aluno': aluno?.toJson()
      };
  factory Comunicado.fromJson(Map<String, dynamic> json) => Comunicado(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      mensagem: json['mensagem'] ?? '',
      dataEnvio: json['dataEnvio'],
      professor: json['professor'] != null
          ? Professor.fromJson(json['professor'])
          : null,
      aluno: json['aluno'] != null ? Aluno.fromJson(json['aluno']) : null);
}
