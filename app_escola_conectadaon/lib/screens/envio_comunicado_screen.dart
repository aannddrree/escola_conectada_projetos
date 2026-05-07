import 'package:flutter/material.dart';
import '../models/aluno.dart';
import '../models/professor.dart';
import '../models/comunicado.dart';
import '../services/api_service.dart';

class EnvioComunicadoScreen extends StatefulWidget {
  const EnvioComunicadoScreen({super.key});

  @override
  State<EnvioComunicadoScreen> createState() => _S();
}

class _S extends State<EnvioComunicadoScreen> {
  final _formKey = GlobalKey<FormState>();
  final titulo = TextEditingController();
  final mensagem = TextEditingController();
  final api = ApiService();
  List<Aluno> alunos = [];
  List<Professor> professores = [];
  Aluno? aluno;
  Professor? professor;
  bool loading = true;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    setState(() => loading = true);
    try {
      final la = await api.getList('/alunos');
      final lp = await api.getList('/professores');
      alunos = la.map((e) => Aluno.fromJson(e)).toList();
      professores = lp.map((e) => Professor.fromJson(e)).toList();
    } catch (_) {
      alunos = [];
      professores = [];
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> salvar() async {
    if (!_formKey.currentState!.validate()) return;
    if (aluno == null && professor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um aluno ou um professor.')),
      );
      return;
    }

    setState(() => saving = true);
    try {
      await api.post(
        '/comunicados',
        Comunicado(
          titulo: titulo.text,
          mensagem: mensagem.text,
          aluno: aluno,
          professor: professor,
        ).toJson(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comunicado enviado!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar comunicado: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar Comunicado')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: titulo,
                      decoration: const InputDecoration(labelText: 'Título'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Informe o título'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: mensagem,
                      maxLines: 5,
                      decoration: const InputDecoration(labelText: 'Mensagem'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Escreva a mensagem'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Professor>(
                      initialValue: professor,
                      items: professores
                          .map((p) =>
                              DropdownMenuItem(value: p, child: Text(p.nome)))
                          .toList(),
                      onChanged: (value) => setState(() => professor = value),
                      decoration: const InputDecoration(labelText: 'Professor'),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Aluno>(
                      initialValue: aluno,
                      items: alunos
                          .map((a) =>
                              DropdownMenuItem(value: a, child: Text(a.nome)))
                          .toList(),
                      onChanged: (value) => setState(() => aluno = value),
                      decoration: const InputDecoration(labelText: 'Aluno'),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: saving ? null : salvar,
                      icon: saving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.send),
                      label: Text(saving ? 'Enviando...' : 'Enviar Comunicado'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
