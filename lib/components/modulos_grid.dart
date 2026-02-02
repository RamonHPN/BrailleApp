import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/modulos_list.dart';
import '../models/modulos.dart';
import 'modulo_item.dart';

class ModulosGrid extends StatelessWidget {
  const ModulosGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ModulosList>(context);
    final List<Modulo> loadedFases = provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedFases.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedFases[i],
        child: const ModuloItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
