import 'package:flutter/material.dart';
import '../models/responsavel.dart';
import '../services/api_service.dart';

class CadastroResponsavelScreen extends StatefulWidget {
  const CadastroResponsavelScreen({super.key});

  @override
  State<CadastroResponsavelScreen> createState() => _S();
}

class _S extends State<CadastroResponsavelScreen> {
  final _formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final email = TextEditingController();
  final telefone = TextEditingController();
  final senha = TextEditingController();
  final api = ApiService();
  bool saving = false;
  bool senhaVisivel = false;

  Future<void> salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => saving = true);
    try {
      await api.post(
        '/responsaveis',
        Responsavel(
          nome: nome.text,
          email: email.text,
          telefone: telefone.text,
          senha: senha.text,
        ).toJson(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Responsável cadastrado!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar responsável: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Responsável')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nome,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o e-mail';
                  if (!value.contains('@')) return 'Digite um e-mail válido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: telefone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe o telefone'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: senha,
                obscureText: !senhaVisivel,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                        senhaVisivel ? Icons.visibility : Icons.visibility_off),
                    onPressed: () =>
                        setState(() => senhaVisivel = !senhaVisivel),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a senha' : null,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: saving ? null : salvar,
                icon: saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.save),
                label: Text(saving ? 'Salvando...' : 'Salvar Responsável'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
