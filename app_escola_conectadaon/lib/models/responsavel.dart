class Responsavel {
  int? id;
  String nome;
  String email;
  String telefone;
  String senha;
  Responsavel(
      {this.id,
      required this.nome,
      required this.email,
      required this.telefone,
      required this.senha});
  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'email': email,
        'telefone': telefone,
        'senha': senha
      };
  factory Responsavel.fromJson(Map<String, dynamic> json) => Responsavel(
      id: json['id'],
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      telefone: json['telefone'] ?? '',
      senha: json['senha'] ?? '');
}
