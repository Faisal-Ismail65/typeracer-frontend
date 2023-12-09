import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/constants/styles.dart';
import 'package:typeracer/models/game_model.dart';
import 'package:typeracer/provders/game_provider.dart';
import 'package:typeracer/utils/socket_methods.dart';
import 'package:typeracer/widgets/custom_buttom.dart';

class GameTextField extends StatefulWidget {
  const GameTextField({super.key});

  @override
  State<GameTextField> createState() => _GameTextFieldState();
}

class _GameTextFieldState extends State<GameTextField> {
  final SocketMethods _socketMethods = SocketMethods();
  final TextEditingController gameController = TextEditingController();

  bool isStarted = false;

  late Player player;
  findPlayer(GameModel game) {
    final playerSocketID = _socketMethods.socketId;
    game.players?.forEach((element) {
      if (element.socketID == playerSocketID) {
        player = element;
      }
    });
  }

  handleStart(GameModel game) {
    print(player.id);
    print(player.socketID);
    _socketMethods.startTimer(player.id!, game.id!);
    setState(() {
      isStarted = true;
    });
  }

  handleChange(String value, String gameID) {
    var lastChar = value[value.length - 1];

    if (lastChar == ' ') {
      _socketMethods.sendUserInput(value.trim(), gameID);
      setState(() {
        gameController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GameModel game = Provider.of<GameProvider>(context).game;
    findPlayer(game);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: !isStarted && (player.isPartyLeader ?? false)
          ? CustomButton(
              text: 'Start',
              onTap: () => handleStart(game),
            )
          : TextField(
              readOnly: game.isJoin ?? false,
              controller: gameController,
              onChanged: (value) => handleChange(value, game.id!),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                fillColor: const Color(0xffF5F5FA),
                hintText: 'Type Here',
                hintStyle: AppStyle.textfieldHintStyle,
              ),
            ),
    );
  }
}
