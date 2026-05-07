class Professor {
  int? id;
  String nome;
  String email;
  String disciplina;
  Professor(
      {this.id,
      required this.nome,
      required this.email,
      required this.disciplina});
  Map<String, dynamic> toJson() =>
      {'id': id, 'nome': nome, 'email': email, 'disciplina': disciplina};
  factory Professor.fromJson(Map<String, dynamic> json) => Professor(
      id: json['id'],
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      disciplina: json['disciplina'] ?? '');
}
