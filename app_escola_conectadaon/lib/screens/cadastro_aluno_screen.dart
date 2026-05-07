import 'package:flutter/material.dart';
import '../models/aluno.dart';
import '../models/responsavel.dart';
import '../services/api_service.dart';

class CadastroAlunoScreen extends StatefulWidget {
  const CadastroAlunoScreen({super.key});

  @override
  State<CadastroAlunoScreen> createState() => _S();
}

class _S extends State<CadastroAlunoScreen> {
  final _formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final idade = TextEditingController();
  String serie = '1º ano';
  Responsavel? responsavel;
  List<Responsavel> responsaveis = [];
  final api = ApiService();
  bool loading = true;
  bool saving = false;
  static const series = ['1º ano', '2º ano', '3º ano', '4º ano'];

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    setState(() => loading = true);
    try {
      final lista = await api.getList('/responsaveis');
      responsaveis = lista.map((e) => Responsavel.fromJson(e)).toList();
    } catch (_) {
      responsaveis = [];
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> salvar() async {
    if (!_formKey.currentState!.validate()) return;
    if (responsavel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um responsável.')),
      );
      return;
    }

    setState(() => saving = true);
    try {
      await api.post(
        '/alunos',
        Aluno(
          nome: nome.text,
          idade: int.tryParse(idade.text) ?? 0,
          serie: serie,
          responsavel: responsavel,
        ).toJson(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aluno cadastrado!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar aluno: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Aluno')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: nome,
                      decoration:
                          const InputDecoration(labelText: 'Nome do aluno'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Informe o nome do aluno'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: idade,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Idade'),
                      validator: (value) {
                        final idadeValor = int.tryParse(value ?? '');
                        if (idadeValor == null || idadeValor <= 0) {
                          return 'Informe uma idade válida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: serie,
                      decoration: const InputDecoration(labelText: 'Série'),
                      items: series
                          .map((item) =>
                              DropdownMenuItem(value: item, child: Text(item)))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => serie = value ?? serie),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Responsavel>(
                      initialValue: responsavel,
                      decoration:
                          const InputDecoration(labelText: 'Responsável'),
                      items: responsaveis
                          .map((r) =>
                              DropdownMenuItem(value: r, child: Text(r.nome)))
                          .toList(),
                      onChanged: (value) => setState(() => responsavel = value),
                      validator: (value) =>
                          value == null ? 'Selecione um responsável' : null,
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
                      label: Text(saving ? 'Salvando...' : 'Salvar Aluno'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
