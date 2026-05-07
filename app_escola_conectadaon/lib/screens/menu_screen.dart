import 'package:flutter/material.dart';
import 'cadastro_responsavel_screen.dart';
import 'cadastro_professor_screen.dart';
import 'cadastro_aluno_screen.dart';
import 'envio_comunicado_screen.dart';
import 'comunicados_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void abrir(BuildContext context, Widget tela) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => tela));
  }

  Widget _opcao(BuildContext context,
      {required String titulo,
      required String descricao,
      required IconData icone,
      required Widget tela}) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(38),
          child: Icon(icone, color: Theme.of(context).colorScheme.primary),
        ),
        title:
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(descricao),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () => abrir(context, tela),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escola Conectada')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Menu Principal',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'Acesse rapidamente todas as funcionalidades para conectar alunos, responsáveis e professores.',
            style: TextStyle(color: Colors.grey[700], height: 1.5),
          ),
          const SizedBox(height: 24),
          _opcao(
            context,
            titulo: 'Cadastrar Responsável',
            descricao: 'Registre um novo responsável pela criança.',
            icone: Icons.person_add,
            tela: const CadastroResponsavelScreen(),
          ),
          _opcao(
            context,
            titulo: 'Cadastrar Aluno',
            descricao: 'Adicione um aluno e vincule-o ao responsável.',
            icone: Icons.school,
            tela: const CadastroAlunoScreen(),
          ),
          _opcao(
            context,
            titulo: 'Cadastrar Professor',
            descricao: 'Inclua um professor com sua disciplina.',
            icone: Icons.badge,
            tela: const CadastroProfessorScreen(),
          ),
          _opcao(
            context,
            titulo: 'Enviar Comunicado',
            descricao: 'Compartilhe informações com alunos ou professores.',
            icone: Icons.send,
            tela: const EnvioComunicadoScreen(),
          ),
          _opcao(
            context,
            titulo: 'Ver Comunicados',
            descricao: 'Leia e responda comunicados existentes.',
            icone: Icons.message,
            tela: const ComunicadosScreen(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
