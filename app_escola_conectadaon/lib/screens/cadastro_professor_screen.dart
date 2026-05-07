import 'package:flutter/material.dart';
import '../models/professor.dart';
import '../services/api_service.dart';

class CadastroProfessorScreen extends StatefulWidget {
  const CadastroProfessorScreen({super.key});

  @override
  State<CadastroProfessorScreen> createState() => _S();
}

class _S extends State<CadastroProfessorScreen> {
  final _formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final email = TextEditingController();
  final disciplina = TextEditingController();
  final api = ApiService();
  bool saving = false;

  Future<void> salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => saving = true);
    try {
      await api.post(
        '/professores',
        Professor(
          nome: nome.text,
          email: email.text,
          disciplina: disciplina.text,
        ).toJson(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Professor cadastrado!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar professor: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Professor')),
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
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o e-mail';
                  if (!value.contains('@')) return 'Informe um e-mail válido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: disciplina,
                decoration: const InputDecoration(labelText: 'Disciplina'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a disciplina'
                    : null,
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
                label: Text(saving ? 'Salvando...' : 'Salvar Professor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
