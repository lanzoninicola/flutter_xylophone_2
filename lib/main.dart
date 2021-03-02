import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Notes(),
        ),
      ),
    );
  }
}

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  AudioPlayer _player;

  void playSound(int soundNumber) async {
    print(soundNumber);
    _player = AudioPlayer();
    _init(_player, soundNumber);
    _player.setClip();
    _player.play();
  }

  _init(AudioPlayer player, int soundNumber) async {
    try {
      await player.setAsset('assets/note$soundNumber.wav');
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print("An error occured $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Note(
              widgetKey: 1,
              playSound: playSound,
              color: Colors.green),
          Note(widgetKey: 2, playSound: playSound, color: Colors.red),
          Note(
              widgetKey: 3,
              playSound: playSound,
              color: Colors.yellow),
          Note(
              widgetKey: 4, playSound: playSound, color: Colors.teal),
          Note(
              widgetKey:5, playSound: playSound, color: Colors.blue),
          Note(
              widgetKey: 6,
              playSound: playSound,
              color: Colors.purple),
          Note(
              widgetKey: 7, playSound: playSound, color: Colors.grey),
        ],
      ),
    );
  }
}

class Note extends StatelessWidget {
  final widgetKey;
  final playSound;
  final color;

  const Note({this.widgetKey, this.color, this.playSound});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        child: GestureDetector(
          onTap: () => {playSound(widgetKey)},
        ),
      ),
    );
  }
}
