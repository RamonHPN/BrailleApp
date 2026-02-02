import 'package:braille_app/models/questao_model.dart';
import 'package:flutter/material.dart';
import 'package:braille_app/components/ball.dart'; // importe a classe Ball

class LetraLinhaGame extends StatefulWidget {
  final QuestaoModel questao;
  final void Function(bool acerto) onSubmit;

  const LetraLinhaGame({
    Key? key,
    required this.questao,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _LetraLinhaGameState createState() => _LetraLinhaGameState();
}

class _LetraLinhaGameState extends State<LetraLinhaGame> {
  final Set<int> _selecionadas = {};
  bool _showTip = false;
  late Ball _ballHelper; // instância de Ball para traduzir

  @override
  void initState() {
    super.initState();
    _ballHelper = Ball(); // inicializa o helper
  }

  @override
  void didUpdateWidget(covariant LetraLinhaGame oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _selecionadas.clear();
      _showTip = false;
    });
  }

  void _toggleTip() {
    setState(() {
      _showTip = !_showTip;
    });
  }

  // LÓGICA RESTAURADA: Voltando ao seu método original
  List<String> _extrairLetrasDoEnunciado(String enunciado) {
    final regExp = RegExp(r'"([^\"]+)"');
    final matches = regExp.allMatches(enunciado);
    final letras = <String>[];
    for (final m in matches) {
      final grupo = m.group(1)!;
      for (var caractere in grupo.split('')) {
        letras.add(caractere.toLowerCase());
      }
    }
    return letras;
  }

  // LÓGICA RESTAURADA: Voltando ao seu método original para não exibir as aspas
  List<TextSpan> _formatarEnunciado(String texto) {
    final spans = <TextSpan>[];
    final regExp = RegExp(r'"([^\"]+)"');
    int lastIndex = 0;

    for (final match in regExp.allMatches(texto)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: texto.substring(lastIndex, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1), // Apenas o conteúdo, sem as aspas
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
      lastIndex = match.end;
    }

    if (lastIndex < texto.length) {
      spans.add(TextSpan(text: texto.substring(lastIndex)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final enunciadoText = widget.questao.enunciado ?? '';
    final letrasDoEnunciado = _extrairLetrasDoEnunciado(enunciadoText);
    final opcoesList = widget.questao.opcoes ?? [];
    final corretasIndices = widget.questao.corretas ?? [];

    final isNumericQuestion = letrasDoEnunciado.isNotEmpty &&
        letrasDoEnunciado.every((char) => RegExp(r'^\d$').hasMatch(char));

    final isCaixaAltaQuestion =
        enunciadoText.toLowerCase().contains('caixa alta');
    
    // A verificação para o caso de aspas
    final isAspasQuestion = enunciadoText.contains('representa " "');

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: _formatarEnunciado(enunciadoText),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 12.0,
                    children: List.generate(
                      opcoesList.length,
                      (index) {
                        final caractereBraille = opcoesList[index];
                        final selecionada = _selecionadas.contains(index);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selecionada) {
                                _selecionadas.remove(index);
                              } else {
                                _selecionadas.add(index);
                              }
                            });
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    selecionada ? Colors.green : Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: selecionada
                                  ? Colors.green.withOpacity(0.2)
                                  : null,
                            ),
                            child: Transform.translate(
                              offset: const Offset(0, 4),
                              child: Text(
                                caractereBraille,
                                style: const TextStyle(fontSize: 32),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  final acerto =
                      Set.from(_selecionadas).containsAll(corretasIndices) &&
                          Set.from(corretasIndices)
                              .containsAll(_selecionadas);
                  widget.onSubmit(acerto);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Center(
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 80,
          right: 8,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.help_outline),
              tooltip: 'Mostrar dica',
              onPressed: _toggleTip,
            ),
          ),
        ),
        if (_showTip)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleTip,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                alignment: Alignment.center,
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    // LÓGICA CORRIGIDA: Trata os casos especiais PRIMEIRO
                    // e depois usa a sua lógica original para o resto.
                    child: isAspasQuestion
                      ? _buildAspasTip() // 1. Exceção para aspas
                      : isCaixaAltaQuestion
                        ? _buildCaixaAltaTip() // 2. Exceção para caixa alta
                        : _buildGenericTip(letrasDoEnunciado, isNumericQuestion), // 3. Lógica padrão
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGenericTip(List<String> letras, bool isNumeric) {
    // Sua lógica original para dicas, que funciona para a maioria dos casos
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: letras.map((letra) {
        final brailleChar = _ballHelper.braille_translator(letra);
        final textoBrailleFinal = isNumeric ? '⠼ $brailleChar' : brailleChar;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(textoBrailleFinal, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Text(letra, style: const TextStyle(fontSize: 32)),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildCaixaAltaTip() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Sinal de Maiúscula", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("⠨", style: TextStyle(fontSize: 32)),
            SizedBox(width: 12),
            Text("Letra Maiúscula", style: TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "Este símbolo é usado antes de uma letra para indicar que ela é maiúscula.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAspasTip() {
    // A dica manual e fixa para a pergunta sobre aspas
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Sinal de Aspas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("⠦", style: TextStyle(fontSize: 32)),
            SizedBox(width: 12),
            Text("Aspas Duplas", style: TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "Este símbolo é usado para indicar aspas (\").",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}