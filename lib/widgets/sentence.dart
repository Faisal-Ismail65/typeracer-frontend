import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/models/game_model.dart';
import 'package:typeracer/provders/game_provider.dart';
import 'package:typeracer/utils/socket_methods.dart';
import 'package:typeracer/widgets/scoreboard.dart';

class GameSentence extends StatefulWidget {
  const GameSentence({super.key});

  @override
  State<GameSentence> createState() => _GameSentenceState();
}

class _GameSentenceState extends State<GameSentence> {
  late Player player;
  final SocketMethods _socketMethods = SocketMethods();

  findPlayer(GameModel game) {
    final playerSocketID = _socketMethods.socketId;
    game.players?.forEach((element) {
      if (element.socketID == playerSocketID) {
        player = element;
      }
    });
  }

  Widget getTypedWords(List<String> words, Player player) {
    var tempWords = words.sublist(0, player.currentWordIndex);
    String typedWords = tempWords.join(' ');
    return Text(typedWords,
        style: const TextStyle(
            color: Color.fromRGBO(52, 235, 119, 1), fontSize: 30));
  }

  Widget currentWord(List<String> words, Player player) {
    return Text(words[player.currentWordIndex ?? 0],
        style: const TextStyle(
            decoration: TextDecoration.underline, fontSize: 30));
  }

  Widget getRemainingWords(List<String> words, Player player) {
    var tempWords =
        words.sublist((player.currentWordIndex ?? 0) + 1, words.length);
    String typedWords = tempWords.join(' ');
    return Text(typedWords, style: const TextStyle(fontSize: 30));
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context).game;
    findPlayer(game);
    return game.words!.length > player.currentWordIndex!
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              textDirection: TextDirection.ltr,
              children: [
                getTypedWords(game.words ?? [], player),
                const SizedBox(width: 3),
                currentWord(game.words ?? [], player),
                const SizedBox(width: 3),
                getRemainingWords(game.words ?? [], player),
              ],
            ),
          )
        : const ScoreBoard();
  }
}
