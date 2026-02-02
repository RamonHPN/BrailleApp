import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/topico.dart';
import 'package:flutter/material.dart';
import 'package:braille_app/models/modulos.dart';
import 'package:provider/provider.dart';

class ModuloItem extends StatelessWidget {
  const ModuloItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Modulo>(
      builder: (context, fase, child) {
        final topico = Provider.of<Topico>(context);
        final passer = Provider.of<Passer>(context);
        return GridTile(
          header: Container(
            margin: EdgeInsets.only(top: 10, right: 15),
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: passer.faseCompleta >= fase.id
                    ? Color(0xFF208B52)
                    : Color(0xFFB0C4B1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                passer.faseCompleta >= fase.id ? Icons.play_arrow : Icons.lock,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          footer: GridTileBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fase.title, style: TextStyle(color: Colors.black)),
                Text(
                  fase.frase,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          child: GestureDetector(
            onTap: passer.faseCompleta >= fase.id
                ? () => Navigator.of(context)
                        .pushNamed('/fases-screen', arguments: {
                      'fase': fase,
                      'topico': topico,
                      'passer': passer,
                    })
                : null,
            child: Card(
              elevation: 8,
              color: Colors.white,
              child: Image.asset(fase.imageUrl),
            ),
          ),
        );
      },
    );
  }
}
