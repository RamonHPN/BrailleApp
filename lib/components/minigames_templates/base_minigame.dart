// import 'package:flutter/material.dart';
// import '../../models/minigame_model.dart';

// class LetterRecognitionGame extends StatelessWidget {
//   final MiniGameTemplate config;
//   final Function(bool) onAnswerSubmitted;

//   const LetterRecognitionGame({
//     required this.config,
//     required this.onAnswerSubmitted,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Reconhecer Letra')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Qual letra é esta?',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               config.content['brailleSymbol'],
//               style: TextStyle(fontSize: 60),
//             ),
//             SizedBox(height: 40),
//             Wrap(
//               spacing: 10,
//               children: [
//                 _buildLetterButton('A', 'A' == config.content['letter']),
//                 _buildLetterButton('B', 'B' == config.content['letter']),
//                 _buildLetterButton('C', 'C' == config.content['letter']),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLetterButton(String letter, bool isCorrect) {
//     return ElevatedButton(
//       onPressed: () => onAnswerSubmitted(isCorrect),
//       child: Text(letter),
//     );
//   }
// }
