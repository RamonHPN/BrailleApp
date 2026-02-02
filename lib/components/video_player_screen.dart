// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   const VideoPlayerScreen({super.key});

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState(){
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: "vx2u5uUu3DE",
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false
//       )
//       );
//   }

//   @override
//   void dispose(){
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.amber,
//         onReady: (){
//           _controller.addListener(() {});
//         },
//       ),
//     );
//   }
// }