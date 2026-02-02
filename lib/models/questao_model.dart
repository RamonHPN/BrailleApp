class QuestaoModel {
  final String id;
  final String? enunciado;
  final List<String>? opcoes;
  List<int>? corretas;        // múltiplas corretas (antigo esquema)
  final String? correta;            // única correta (a partir do padrão 4)
  final Map<String, String>? caracteres;
  final String? imagemUrl;
  final String? palavra;
  final String? dica;
  final List<int>? lacunas;
  final List<int>? ordemCorreta;
  final List<int>? posicoesLacunas;
  final bool mostrarPopupMaiuscula;


  QuestaoModel({
    required this.id,
    this.enunciado,
    this.opcoes,
    this.corretas,
    this.correta,
    this.caracteres,
    this.imagemUrl,
    this.palavra,
    this.dica,
    this.lacunas,
    this.ordemCorreta,
    this.posicoesLacunas,
    this.mostrarPopupMaiuscula = false,
  });

  factory QuestaoModel.fromMap(Map<String, dynamic> data, String id) {
    return QuestaoModel(
      id: id,
      enunciado: data['enunciado'] as String?,
      opcoes: data['opcoes'] != null
          ? List<String>.from(data['opcoes'] as List<dynamic>)
          : null,
      corretas: data['corretas'] != null
          ? List<int>.from(data['corretas'] as List<dynamic>)
          : null,
      correta: data['correta'] as String?, // novo campo
      caracteres: data['caracteres'] != null
          ? (data['caracteres'] as Map<dynamic, dynamic>)
              .map((k, v) => MapEntry(k.toString(), v.toString()))
          : null,
      imagemUrl: data['imagemUrl'] as String?,
      palavra: data['palavra'] as String?,
      dica: data['dica'] as String?,
      lacunas: data['lacunas'] != null
          ? List<int>.from(data['lacunas'] as List<dynamic>)
          : null,
      ordemCorreta: data['ordem_correta'] != null
          ? List<int>.from(data['ordem_correta'] as List<dynamic>)
          : null,
      posicoesLacunas: data['posicoesLacunas'] != null
          ? List<int>.from(data['posicoesLacunas'] as List<dynamic>)
          : null,
      mostrarPopupMaiuscula: data['mostrarPopupMaiuscula'] ?? false,
    );
  }
}
