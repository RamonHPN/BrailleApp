import 'package:braille_app/services/auth.dart';
import 'package:braille_app/models/modulos.dart';
import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/topico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Topico1ConteudoScreen extends StatefulWidget {
  const Topico1ConteudoScreen({super.key});

  @override
  State<Topico1ConteudoScreen> createState() => _Topico1ConteudoScreenState();
}

class _Topico1ConteudoScreenState extends State<Topico1ConteudoScreen> {
  // late YoutubePlayerController _controller;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final args =
  //       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  //   final Fase fase = args['fase'];
  //   final Topico topico = args['topico'];

  //   _controller = YoutubePlayerController(
  //     initialVideoId: topico.videos[indice],
  //     flags: const YoutubePlayerFlags(
  //       autoPlay: false,
  //       mute: false,
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  void _testar(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo fase = args['fase'];
    final Topico topico = args['topico'];
    final Passer passer = args['passer'];
    final auth = Provider.of<Auth>(context, listen: false);
    topico.checkpoint = 2;
    passer.salvaLugar(
        fase, topico, auth.token ?? '', auth.userId ?? "", topico.checkpoint);
    // if (passer.topicoCompleto <= topico.id) {
    //   for(int i = 0; i<=indice; i++)
    //   {passer.incrementaFracao(
    //       passer, topico, fase, auth.token ?? '', auth.userId ?? "");}
    // }
    Navigator.of(context).pushNamed('/testar-screen',
        arguments: {'fase': fase, "topico": topico, "passer": passer});
  }

  void _voltar(BuildContext context) {
    Navigator.pop(context);
  }

  // int indice = 0;
  @override
  void initState() {
    super.initState();
    Provider.of<Passer>(context, listen: false);
    // indice = passer.indice; // Carrega o valor inicial do índice
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo fase = args['fase'];
    final Topico topico = args['topico'];
    final Passer passer = args['passer'];
    final auth = Provider.of<Auth>(context, listen: false);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int incrementaLista() {
      setState(() {
        passer.indice++;
        passer.salvaIndice(
            fase, topico, auth.token ?? "", auth.userId ?? '', passer.indice);
        // passer.incrementaFracao(
        //     passer, topico, fase, auth.token ?? '', auth.userId ?? "");
        // _controller.load(topico.videos[indice]);
      });
      return passer.indice;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFDDE9DD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1FEF1),
        title: Text("Tópico ${topico.number}"),
        centerTitle: true,
        actions: [
          Container(
            width: screenWidth * 20 / 360,
            margin: EdgeInsets.only(right: screenWidth * 25 / 360),
            child: Image.asset('assets/images/muiraq_preto.png'),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black)),
            ),
            child: Container(
              color: const Color(0xFFF1FEF1),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [],
              ),
            ),
          ),
          // Container(
          //   width: screenWidth,
          //   child: YoutubePlayer(
          //     controller: _controller,
          //     showVideoProgressIndicator: true,
          //     progressIndicatorColor: Color.fromRGBO(164, 228, 245, 1),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Text(
              topico.titulos[passer.indice],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Text(
              topico.conteudos[passer.indice],
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.justify,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(bottom: screenHeight * 50 / 800, right: 20),
                height: screenHeight * 50 / 800,
                width: screenWidth * 150 / 360,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _voltar(context);
                  },
                  child: const Text(
                    'Voltar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 50 / 800),
                height: screenHeight * 50 / 800,
                width: screenWidth * 150 / 360,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF208B52),
                  ),
                  onPressed: () {
                    if (passer.topicoCompleto <= topico.id) {
                      passer.incrementaFracao(passer, topico, fase,
                          auth.token ?? '', auth.userId ?? "");
                    }
                    if (passer.indice + 1 == topico.titulos.length) {
                      passer.indice = 0;
                      passer.salvaIndice(fase, topico, auth.token ?? "",
                          auth.userId ?? "", passer.indice);
                      _testar(context);
                    } else {
                      incrementaLista();
                    }
                  },
                  child: const Text(
                    'Continuar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
