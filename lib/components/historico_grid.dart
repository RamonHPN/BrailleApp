import 'package:braille_app/models/historico.dart';
import 'package:braille_app/components/historico_item.dart';
import 'package:braille_app/services/historico_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricoGrid extends StatelessWidget {
  const HistoricoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final historicoList = Provider.of<HistoricoList>(context);
    final List<Historico> loadedTraducoes = historicoList.items;
    return Expanded(
        child: ListView.builder(
            itemCount: loadedTraducoes.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider(
                  create: (_) => loadedTraducoes[i],
                  child: HistoricoItem(),
                )));
  }
}
