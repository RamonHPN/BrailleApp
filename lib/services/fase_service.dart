import 'dart:convert';
import 'dart:math';
import 'package:braille_app/data/minigames_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:braille_app/components/fase.dart';
import 'package:braille_app/models/minigame_model.dart';
import 'package:braille_app/models/questao_model.dart';
import 'package:braille_app/utils/constants.dart';

class FaseService {
  final String token;
  final String userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FaseService({required this.token, required this.userId});

  Future<int> getFaseAtual() async {
    final url = '${Constants.BASE_URL}/users/$userId/fase.json?auth=$token';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data as int?) ?? 1;
    } else {
      throw Exception('Erro ao carregar fase atual');
    }
  }

  Future<void> atualizarFase(int novaFase) async {
    try {
      final faseAtual = await getFaseAtual();
      if (novaFase > faseAtual) {
        final url = '${Constants.BASE_URL}/users/$userId/fase.json?auth=$token';
        await http.put(Uri.parse(url), body: jsonEncode(novaFase));
      }
    } catch (e) {
      debugPrint('Falha ao tentar atualizar fase: $e');
    }
  }

  Future<List<MiniGameTemplate>> carregarMiniGamesDaFase(String faseId) async {
    final miniGames = <MiniGameTemplate>[];
    final configs = sequenciaMinigames[faseId] ?? [];
    final random = Random();

    for (var config in configs) {
      final padrao = config['padrao'] as String;
      final padraoNum = int.tryParse(padrao.split('_').last) ?? 0;

      final padraoDocRef = _firestore
          .collection('categorias')
          .doc(config['categoria'] as String)
          .collection('padroes')
          .doc(padrao);

      if (config['tipo'] == MiniGameType.APRESENTAR &&
          config['direct'] == true) {
        final docSnap = await padraoDocRef.get();
        if (docSnap.exists) {
          final data = docSnap.data()!;
          final caracteres = (data['caracteres'] as Map?)
                  ?.map((k, v) => MapEntry(k.toString(), v.toString())) ??
              {};
          final mostrarPopupMaiuscula =
              padraoNum == 7 && caracteres.values.any((c) => c.contains("⠠"));
          final questao = QuestaoModel(
            id: docSnap.id,
            enunciado: data['enunciado'],
            opcoes: (data['opcoes'] as List?)?.cast<String>(),
            corretas: (data['corretas'] as List?)?.cast<int>(),
            correta: data['correta'],
            caracteres: caracteres,
            imagemUrl: data['imagemUrl'],
            palavra: data['palavra'],
            dica: data['dica'],
            lacunas: (data['lacunas'] as List?)
                ?.map((e) => int.tryParse(e.toString()) ?? 0)
                .toList(),
            ordemCorreta: (data['ordem_correta'] as List?)
                ?.map((e) => int.tryParse(e.toString()) ?? 0)
                .toList(),
            posicoesLacunas: (data['posicoesLacunas'] as List?)
                ?.map((e) => int.tryParse(e.toString()) ?? 0)
                .toList(),
            mostrarPopupMaiuscula: mostrarPopupMaiuscula,
          );
          miniGames.add(MiniGameTemplate(
            id: docSnap.id,
            type: MiniGameType.APRESENTAR,
            difficulty: 1,
            questao: questao,
          ));
        }
        continue;
      }

      if (config['tipo'] == MiniGameType.MULTIPLE_LETRAS_LINHA) {
        final grupo = config['grupo'] as String?;
        final subset = config['subset'] as List?;
        late CollectionReference ref;

        if (grupo != null) {
          ref =
              padraoDocRef.collection('grupos').doc(grupo).collection('questoes');
        } else {
          ref = padraoDocRef.collection('questoes');
        }

        final snapshot = await ref.get();
        final allDocs = snapshot.docs;

        Iterable<QueryDocumentSnapshot> docsSelecionados;

        if (padraoNum >= 4 && grupo == 'a') {
          docsSelecionados = allDocs;
        } else if (padraoNum >= 4 && (grupo == 'b' || grupo == 'c')) {
          allDocs.shuffle(random);
          docsSelecionados = allDocs.take(3);
        } else if (padraoNum < 4) {
          allDocs.shuffle(random);
          docsSelecionados = allDocs.take(min(3, allDocs.length));
        } else {
          docsSelecionados = allDocs;
        }

        for (var doc in docsSelecionados) {
          final data = doc.data() as Map<String, dynamic>;
          final original = QuestaoModel.fromMap(data, doc.id);

          if (subset != null) {
            final newOpcoes = subset.map((i) => original.opcoes![i]).toList();
            final newCorretas = <int>[];

            if (original.corretas != null) {
              for (int i = 0; i < subset.length; i++) {
                if (original.corretas!.contains(subset[i])) newCorretas.add(i);
              }
            } else if (original.correta != null) {
              final indexInSubset =
                  subset.indexWhere((i) => original.opcoes![i] == original.correta);
              if (indexInSubset >= 0) newCorretas.add(indexInSubset);
            }

            List<String> opcoesFinais = newOpcoes;
            List<int> corretasFinais = newCorretas;

            // Condição para embaralhar apenas a partir do Padrão 4
            if (padraoNum >= 4) {
              final valoresCorretos = newCorretas.map((index) => newOpcoes[index]).toList();
              final opcoesEmbaralhadas = List<String>.from(newOpcoes)..shuffle();
              final novasCorretas = valoresCorretos.map((valor) => opcoesEmbaralhadas.indexOf(valor)).toList();

              opcoesFinais = opcoesEmbaralhadas;
              corretasFinais = novasCorretas;
            }

            miniGames.add(MiniGameTemplate(
              id: '${doc.id}_${subset.join('_')}',
              type: MiniGameType.MULTIPLE_LETRAS_LINHA,
              difficulty: 1,
              questao: QuestaoModel(
                id: original.id,
                enunciado: original.enunciado,
                opcoes: opcoesFinais,
                corretas: corretasFinais,
                correta: original.correta,
                caracteres: original.caracteres,
                imagemUrl: original.imagemUrl,
                palavra: original.palavra,
                dica: original.dica,
                lacunas: original.lacunas,
                ordemCorreta: original.ordemCorreta,
                posicoesLacunas: original.posicoesLacunas,
              ),
            ));
          } else {
            // Lógica para o caso geral (sem subset)
            final listaCorretasOriginal = original.corretas ?? [];
            if (original.correta != null && original.opcoes != null) {
              final indexCorreta = original.opcoes!
                  .indexWhere((o) => o.trim() == original.correta!.trim());
              if (indexCorreta >= 0 &&
                  !listaCorretasOriginal.contains(indexCorreta)) {
                listaCorretasOriginal.add(indexCorreta);
              }
            }

            List<String> opcoesFinais = original.opcoes ?? [];
            List<int> corretasFinais = listaCorretasOriginal;

            // Condição para embaralhar apenas a partir do Padrão 4
            if (padraoNum >= 4 && original.opcoes != null) {
              final valoresCorretos = listaCorretasOriginal.map((index) => original.opcoes![index]).toList();
              final opcoesEmbaralhadas = List<String>.from(original.opcoes!)..shuffle();
              final novasCorretas = valoresCorretos.map((valor) => opcoesEmbaralhadas.indexOf(valor)).toList();

              opcoesFinais = opcoesEmbaralhadas;
              corretasFinais = novasCorretas;
            }

            final novaQuestao = QuestaoModel(
              id: original.id,
              enunciado: original.enunciado,
              opcoes: opcoesFinais,
              corretas: corretasFinais,
              correta: original.correta,
              caracteres: original.caracteres,
              imagemUrl: original.imagemUrl,
              palavra: original.palavra,
              dica: original.dica,
              lacunas: original.lacunas,
              ordemCorreta: original.ordemCorreta,
              posicoesLacunas: original.posicoesLacunas,
            );

            miniGames.add(MiniGameTemplate(
              id: doc.id,
              type: MiniGameType.MULTIPLE_LETRAS_LINHA,
              difficulty: 1,
              questao: novaQuestao,
            ));
          }
        }
        continue;
      }

      late CollectionReference ref;
      if (config.containsKey('grupo')) {
        ref = padraoDocRef
            .collection('grupos')
            .doc(config['grupo'] as String)
            .collection('questoes');
      } else {
        ref = padraoDocRef.collection('questoes');
      }

      if (config.containsKey('id')) {
        final docId = config['id'] as String;
        final docSnap = await ref.doc(docId).get();
        if (docSnap.exists) {
          final data = docSnap.data()! as Map<String, dynamic>;
          miniGames.add(MiniGameTemplate(
            id: docSnap.id,
            type: config['tipo'] as MiniGameType,
            difficulty: 1,
            questao: QuestaoModel.fromMap(data, docSnap.id),
          ));
        }
      } else {
        final snapshot = await ref.get();
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          miniGames.add(MiniGameTemplate(
            id: doc.id,
            type: config['tipo'] as MiniGameType,
            difficulty: 1,
            questao: QuestaoModel.fromMap(data, doc.id),
          ));
        }
      }
    }

    return miniGames;
  }

  Future<List<Fase>> carregarTodasAsFases() async {
    throw UnimplementedError('Fases são locais');
  }
}