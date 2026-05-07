import 'package:flutter/material.dart';
import '../models/comunicado.dart';
import '../services/api_service.dart';
import 'resposta_screen.dart';

class ComunicadosScreen extends StatefulWidget {
  const ComunicadosScreen({super.key});

  @override
  State<ComunicadosScreen> createState() => _S();
}

class _S extends State<ComunicadosScreen> {
  final api = ApiService();
  List<Comunicado> comunicados = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    setState(() => loading = true);
    try {
      final lista = await api.getList('/comunicados');
      comunicados = lista.map((e) => Comunicado.fromJson(e)).toList();
    } catch (_) {
      comunicados = [];
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comunicados')),
      body: RefreshIndicator(
        onRefresh: carregar,
        child: loading
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 220),
                  Center(child: CircularProgressIndicator())
                ],
              )
            : comunicados.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 220),
                      Center(
                        child: Text(
                          'Nenhum comunicado encontrado. Puxe para atualizar.',
                          style: TextStyle(color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: comunicados.length,
                    itemBuilder: (context, i) {
                      final c = comunicados[i];
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(38),
                            child: const Icon(Icons.campaign),
                          ),
                          title: Text(c.titulo,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(
                            '${c.mensagem}\n\nAluno: ${c.aluno?.nome ?? '-'}\nProfessor: ${c.professor?.nome ?? '-'}',
                            style:
                                TextStyle(color: Colors.grey[700], height: 1.4),
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.reply_outlined),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RespostaScreen(comunicado: c)),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
