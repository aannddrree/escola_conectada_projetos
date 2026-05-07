import 'package:flutter/material.dart';
import '../models/comunicado.dart';
import '../models/responsavel.dart';
import '../models/resposta.dart';
import '../services/api_service.dart';

class RespostaScreen extends StatefulWidget {
  final Comunicado comunicado;
  const RespostaScreen({super.key, required this.comunicado});

  @override
  State<RespostaScreen> createState() => _S();
}

class _S extends State<RespostaScreen> {
  final _formKey = GlobalKey<FormState>();
  final resposta = TextEditingController();
  final api = ApiService();
  List<Responsavel> responsaveis = [];
  Responsavel? responsavel;
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
        '/respostas',
        Resposta(
          mensagemResposta: resposta.text,
          comunicado: widget.comunicado,
          responsavel: responsavel,
        ).toJson(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Resposta enviada!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar resposta: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responder Comunicado')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.comunicado.titulo,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(widget.comunicado.mensagem,
                              style: const TextStyle(height: 1.5)),
                          const SizedBox(height: 12),
                          Text('Aluno: ${widget.comunicado.aluno?.nome ?? '-'}',
                              style: TextStyle(color: Colors.grey[700])),
                          Text(
                              'Professor: ${widget.comunicado.professor?.nome ?? '-'}',
                              style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DropdownButtonFormField<Responsavel>(
                          initialValue: responsavel,
                          decoration:
                              const InputDecoration(labelText: 'Responsável'),
                          items: responsaveis
                              .map((r) => DropdownMenuItem(
                                  value: r, child: Text(r.nome)))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => responsavel = value),
                          validator: (value) =>
                              value == null ? 'Selecione um responsável' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: resposta,
                          maxLines: 5,
                          decoration:
                              const InputDecoration(labelText: 'Resposta'),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Escreva sua resposta'
                              : null,
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: saving ? null : salvar,
                          icon: saving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.send),
                          label:
                              Text(saving ? 'Enviando...' : 'Enviar Resposta'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
