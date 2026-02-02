import 'package:flutter/material.dart';
import 'package:braille_app/models/questao_model.dart';

class CompletarPalavraSimpleGame extends StatefulWidget {
  final QuestaoModel questao;
  final void Function(bool acerto) onSubmit;

  const CompletarPalavraSimpleGame({
    Key? key,
    required this.questao,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _CompletarPalavraSimpleGameState createState() =>
      _CompletarPalavraSimpleGameState();
}

class _CompletarPalavraSimpleGameState
    extends State<CompletarPalavraSimpleGame> {
  late List<String?> _respostas;
  int _indiceSelecao = 0;

  @override
  void initState() {
    super.initState();
    _inicializarRespostas();
  }

  @override
  void didUpdateWidget(covariant CompletarPalavraSimpleGame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questao.id != widget.questao.id) {
      setState(_inicializarRespostas);
    }
  }

  void _inicializarRespostas() {
    _respostas = List.filled(widget.questao.ordemCorreta?.length ?? 0, null);
    _indiceSelecao = 0;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Enunciado no topo
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Text(
            widget.questao.enunciado ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),

        // Imagem com altura máxima de 1/3 da tela, mantendo proporção e mostrando indicador
        if (widget.questao.imagemUrl != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: screenHeight / 3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.questao.imagemUrl!,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

        const SizedBox(height: 16),

        // Palavra com lacunas
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: List.generate(widget.questao.dica?.length ?? 0, (index) {
              final lacunas = widget.questao.posicoesLacunas ?? [];
              final isLacuna = lacunas.contains(index);
              final respostaIdx = isLacuna ? lacunas.indexOf(index) : null;
              final caractere = isLacuna ? _respostas[respostaIdx!] : widget.questao.dica![index];

              return Container(
                width: 40,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isLacuna ? const Color(0xFF208B52) : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  caractere ?? '_',
                  style: const TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              );
            }),
          ),
        ),

        // Opções Braille centralizadas
        Expanded(
          child: Center(
            child: Wrap(
              spacing: 12,
              children: (widget.questao.opcoes ?? []).map((opcao) {
                final jaUsada = _respostas.contains(opcao);
                return GestureDetector(
                  onTap: jaUsada ? null : () => _selecionarCaractere(opcao),
                  child: Opacity(
                    opacity: jaUsada ? 0.5 : 1.0,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: jaUsada ? Colors.grey[200] : Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Transform.translate(
                        offset: Offset(0, 4),
                        child: Text(
                          opcao,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Botão e remover
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.backspace),
                tooltip: 'Apagar último',
                onPressed: _indiceSelecao > 0 ? _apagarUltimo : null,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: _verificarResposta,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF208B52),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Verificar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _selecionarCaractere(String caractere) {
    if (_indiceSelecao < _respostas.length) {
      setState(() {
        _respostas[_indiceSelecao] = caractere;
        _indiceSelecao++;
      });
    }
  }

  void _apagarUltimo() {
    if (_indiceSelecao > 0) {
      setState(() {
        _indiceSelecao--;
        _respostas[_indiceSelecao] = null;
      });
    }
  }

  void _verificarResposta() {
    if (_indiceSelecao < _respostas.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione todos os caracteres primeiro!')),
      );
      return;
    }
    final ordem = widget.questao.ordemCorreta ?? [];
    final opcs = widget.questao.opcoes ?? [];
    final acerto = List.generate(
            ordem.length, (i) => _respostas[i] == opcs[ordem[i]])
        .every((e) => e);

    if (!acerto) {
      // Se errou, limpa todas as seleções e devolve os caracteres à lista
      _clearFromIndex(0);
    }

    widget.onSubmit(acerto);
  }

  void _clearFromIndex(int startIndex) {
    setState(() {
      for (int i = startIndex; i < _respostas.length; i++) {
        _respostas[i] = null;
      }
      _indiceSelecao = startIndex;
    });
  }
}
