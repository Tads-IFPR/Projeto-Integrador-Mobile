import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'package:JAJA/styles/default.dart';

class Player extends StatefulWidget {
  final File audioFile;

  const Player({
    super.key,
    required this.audioFile,
  });

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  File? _currentlyPlayingAudio;

  Future<void> _toggleAudio(File audioFile) async {
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
        fromURI: audioFile.path,
        codec: Codec.aacMP4,
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
    return GestureDetector(
      onTap: () => _toggleAudio(widget.audioFile),
      child: Row(
        children: [
          Icon(
            _currentlyPlayingAudio != null ? Icons.stop : Icons.play_arrow,
            color: colorWhite,
          ),
          const SizedBox(width: 8),
          const Text(
            'Audio Message',
            style: TextStyle(fontSize: 16, color: colorWhite),
          ),
        ],
      ),
    );
  }
}