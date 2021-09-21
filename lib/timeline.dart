// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class timeline extends StatefulWidget {
//   const timeline({Key? key}) : super(key: key);

//   @override
//   _timelineState createState() => _timelineState();
// }

// class _timelineState extends State<timeline> {
//   List<String>? _records = [];

//   Future<List<String>?> _getRecords() async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     _records = _prefs.getStringList("records");
//     return _records;
//   }

//   void onPlayAudio(String audioFilePath) async {
//     AudioPlayer audioPlayer = AudioPlayer();
//     await audioPlayer.play(audioFilePath, isLocal: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(itemBuilder: (BuildContext context, int index) {
//       return Row(
//         children: [
//           Text(_records![index].toString()),
//           IconButton(
//               onPressed: () {
//                 onPlayAudio(_records![index]);
//               },
//               icon: Icon(Icons.play_arrow))
//         ],
//       );
//     });
//   }
// }
