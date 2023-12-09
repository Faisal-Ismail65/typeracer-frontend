import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/constants/styles.dart';
import 'package:typeracer/provders/client_provider.dart';
import 'package:typeracer/provders/game_provider.dart';
import 'package:typeracer/utils/socket_methods.dart';
import 'package:typeracer/widgets/game_text_field.dart';
import 'package:typeracer/widgets/sentence.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateTimer(context);
    _socketMethods.updateGame(context);
    _socketMethods.gameFinishedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context).game;
    final clientStateProvider = Provider.of<ClientStateProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Center(
              child: Column(
            children: [
              Visibility(
                visible: true,
                child: Chip(
                  label: Text(
                    clientStateProvider.clientState['timer']['msg'].toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Text(
                clientStateProvider.clientState['timer']['countDown']
                    .toString(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const GameSentence(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: game.players?.length ?? 0,
                itemBuilder: (context, index) {
                  final player = game.players![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(
                        label: Text(
                          player.nickname ?? '',
                          style: AppStyle.playerSliderStyle,
                        ),
                      ),
                      Slider(
                        value: (player.currentWordIndex! / game.words!.length),
                        onChanged: (value) {},
                      )
                    ],
                  );
                },
              ),
              Visibility(
                visible: game.isJoin ?? false,
                child: TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: game.id))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Game ID Copied your Clipboard')));
                      });
                    },
                    child: const Text(
                      'Click TO Copy Game ID',
                      style: AppStyle.textfieldHintStyle,
                    )),
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: const SafeArea(child: GameTextField()),
    );
  }
}
