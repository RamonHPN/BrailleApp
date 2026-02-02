// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:braille_app/components/ball.dart';
import 'package:braille_app/services/cells_list.dart';
import 'package:braille_app/services/historico_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import 'package:flutter/services.dart';

class Translation extends StatefulWidget {
  const Translation({super.key});

  @override
  State<Translation> createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {
  String letra = '';
  final TextEditingController _controller = TextEditingController();
  final int maxCharacters = 500;

  @override
  void initState() {
    super.initState();
    letra = " ";
  }

  void _submitText() {
    FocusScope.of(context).unfocus();
    final ball = Provider.of<Ball>(context, listen: false);
    final cells = Provider.of<CellsList>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final historicoList = Provider.of<HistoricoList>(context, listen: false);

    String valor = _controller.text.trim();
    if (valor.isEmpty) return;

    cells.wordsClicker(auth.token ?? '', auth.userId ?? '');
    ball.reset(letra);

    setState(() {
      letra = identifyUpperCase(valor);
      letra = ball.braille_translator(letra);
      // letra = "";
    });

    final hoje = DateTime.now();
    final dataFormatada = '${hoje.day.toString().padLeft(2, '0')}/'
                        '${hoje.month.toString().padLeft(2, '0')}/'
                        '${hoje.year}';

    historicoList.salvaHistorico(
        auth.token ?? '', auth.userId ?? '', dataFormatada, valor, letra);
  }

  String identifyUpperCase(String frase) {
    String fraseAlterada = '';
    List duasMatrizes = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
      'Á',
      'É',
      'Í',
      'Ó',
      'Ú',
      'À',
      'Â',
      'Ê',
      'Ô',
      'Ã',
      'Õ',
      'Ç'
    ];
    List numerosMatrizes = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    bool caplock = false;
    bool palavraMai = false;

    if (frase.length > 1 &&
    frase == frase.toUpperCase() &&                // sem letras minúsculas
    !RegExp(r'^\d+$').hasMatch(frase) &&            // não só dígitos
    RegExp(r'[A-ZÁÉÍÓÚÀÂÊÔÃÕÇ]').hasMatch(frase)    // pelo menos uma letra maiúscula
) {
  frase = frase.toLowerCase();
  caplock = true;
}

    List<String> palavras = frase.split(' ');

    for (int j = 0; j < palavras.length; j++) {
      String palavra = palavras[j];

      if (palavra == palavra.toUpperCase() &&
          palavra.length > 1 &&
          palavra.split('').every((char) => duasMatrizes.contains(char))) {
        palavra = palavra.toLowerCase();
        palavra = "AA$palavra";
        palavraMai = true;
      }

      for (int i = 0; i < palavra.length; i++) {
        if (caplock == true) {
          fraseAlterada = ":AA " + fraseAlterada;
          caplock = false;
        }

        if (duasMatrizes.contains(palavra[i]) && palavraMai == false) {
          fraseAlterada += 'A${palavra[i].toLowerCase()}';
        } else if (numerosMatrizes.contains(palavra[i]) &&
            (i == 0 || !numerosMatrizes.contains(palavra[i - 1]))) {
          fraseAlterada += 'B${palavra[i]}';
        } else if (palavra[i] == "'") {
          fraseAlterada += '."';
        } else if (palavra[i] == "<" || palavra[i] == ">") {
          fraseAlterada += '\$"';
        } else if (palavra[i] == "_") {
          fraseAlterada += "--";
        } else {
          fraseAlterada += palavra[i];
        }
      }
      if (j < palavras.length - 1) fraseAlterada += ' ';
    }
    return fraseAlterada;
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: letra));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Texto copiado para a área de transferência!')),
    );
  }

  void _historico(BuildContext context) {
    Navigator.of(context).pushNamed('/historico-screen');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Português (PT/BR)",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${_controller.text.length}/$maxCharacters",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: TextField(
                  controller: _controller,
                  maxLength: maxCharacters,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Escreva seu texto',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    counterText: "",
                  ),
                  onChanged: (valor) {
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF208B52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Limpar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: _submitText,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF208B52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Submeter',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Braille",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: IconButton(
                        onPressed: _copyToClipboard,
                        icon: Icon(Icons.copy),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                width: screenWidth,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: SelectableText(
                    letra,
                    style: TextStyle(
                      fontSize: 25,
                      // fontFamily: 'Braille',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
               Center(
                 child: ElevatedButton(
                      onPressed: () => _historico(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF208B52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Histórico',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
