import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:JAJA/main.dart';

class Reproducetext extends StatefulWidget {
  final String text;

  const Reproducetext({
    super.key,
    required this.text
  });

  @override
  State<Reproducetext> createState() => _ReproducetextState();
}

class _ReproducetextState extends State<Reproducetext> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  File? audioFile;
  File? _currentlyPlayingAudio;

  Future<File?> _textToAudio(String text) async {
    return await openAIService.textToSpeach(text);
  }

  Future<void> _toggleAudio() async {
    audioFile ??= await _textToAudio(widget.text);

    if (_player.isPlaying && _currentlyPlayingAudio == audioFile) {
      await _player.stopPlayer();
      setState(() {
        _currentlyPlayingAudio = null;
      });
    } else {
      if (_player.isPlaying) {
        await _player.stopPlayer();
      }

      await _player.startPlayer(
        fromURI: audioFile?.path,
        codec: Codec.mp3,
        whenFinished: () => setState(() {
          _currentlyPlayingAudio = null;
        }),
      );

      setState(() {
        _currentlyPlayingAudio = audioFile;
      });
    }
  }

  _initializePlayer() async {
    await _player.openPlayer();
  }

    @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: _toggleAudio, 
      icon: const Icon(Icons.graphic_eq)
    );
  }
}