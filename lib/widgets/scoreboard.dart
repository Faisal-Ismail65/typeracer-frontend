import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/models/game_model.dart';
import 'package:typeracer/provders/game_provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context).game;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: game.players?.length ?? 0,
      itemBuilder: (context, index) {
        final Player player = game.players![index];
        return ListTile(
          title: Text(player.nickname ?? ''),
          trailing: Text('${player.wpm}'),
        );
      },
    );
  }
}
