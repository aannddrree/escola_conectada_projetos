import 'responsavel.dart';

class Aluno {
  int? id;
  String nome;
  int idade;
  String serie;
  Responsavel? responsavel;
  Aluno(
      {this.id,
      required this.nome,
      required this.idade,
      required this.serie,
      this.responsavel});
  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'idade': idade,
        'serie': serie,
        'responsavel': responsavel?.toJson()
      };
  factory Aluno.fromJson(Map<String, dynamic> json) => Aluno(
      id: json['id'],
      nome: json['nome'] ?? '',
      idade: json['idade'] ?? 0,
      serie: json['serie'] ?? '',
      responsavel: json['responsavel'] != null
          ? Responsavel.fromJson(json['responsavel'])
          : null);
}
