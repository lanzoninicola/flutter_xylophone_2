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
  AudioPlayer _player2;
  String note;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player2 = AudioPlayer();
    _init();
  }

  _init() async {
    print('init fired');
    try {
      await _player.setAsset('assets/note1.wav');
      await _player2.setAsset('assets/note2.wav');
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print("An error occured $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _player2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Note(label: 'play1', player: _player, color: Colors.green),
          Note(label: 'play2', player: _player2, color: Colors.red)
        ],
      ),
    );
  }
}

class Note extends StatelessWidget {
  final String label;
  final AudioPlayer player;
  final color;

  const Note({this.label, this.color, this.player});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color)),
        onPressed: () {
          player.setClip();
          player.play();
        },
        child: Text(
          "$label",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
