import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:braille_app/services/historico_list.dart';
import 'package:braille_app/services/auth.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // pega token e userId sem escutar mudanças aqui
    final auth = Provider.of<Auth>(context, listen: false);
    final historicoList = Provider.of<HistoricoList>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Tradução'),
      ),
      body: FutureBuilder<void>(
        // dispara uma única vez
        future: historicoList.carregaHistorico(auth.token!, auth.userId!),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar o histórico.'));
          }
          // ao completar, renderiza a lista que escuta mudanças
          return Consumer<HistoricoList>(
            builder: (ctx, list, _) {
              if (list.items.isEmpty) {
                return const Center(child: Text('Nenhum histórico encontrado.'));
              }
              return ListView.builder(
                itemCount: list.items.length,
                itemBuilder: (ctx, index) {
                  final item = list.items[list.items.length - 1 - index];
                  return ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.delete, color: Color.fromARGB(131, 0, 0, 0)),
                      onPressed: () async {
                        try {
                          await list.deleteHistorico(
                            auth.token!, auth.userId!, item.id
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Histórico excluído.'))
                          );
                        } catch (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Erro ao excluir.'))
                          );
                        }
                      },
                    ),
                    title: Text(item.textoPortugues),
                    subtitle: Text('Braille: ${item.textoBraille}'),
                    trailing: Text(item.data),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
