import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/constants/routes.dart';
import 'package:typeracer/models/game_model.dart';
import 'package:typeracer/provders/client_provider.dart';
import 'package:typeracer/provders/game_provider.dart';
import 'package:typeracer/utils/socket_client.dart';

class SocketMethods {
  final SocketClient _socketClient = SocketClient();

  bool _isPlaying = false;
  String? get socketId => _socketClient.socketID;

  // Create Game

  createGame(String nickname) {
    _socketClient.emitEvent('create-game', {
      'nickname': nickname,
    });
  }

  // Join Game

  joinGame(String gameID, String nickname) {
    _socketClient.emitEvent('join-game', {
      'nickname': nickname,
      'gameID': gameID,
    });
  }

  // Start Timer

  startTimer(String playerID, String gameID) {
    _socketClient.emitEvent('timer', {
      'playerID': playerID,
      'gameID': gameID,
    });
  }

  sendUserInput(String value, String gameID) {
    print('Sending User Input');
    _socketClient.emitEvent('user-input', {
      'value': value,
      'gameID': gameID,
    });
  }

  // Listeners
  updateGameListener(BuildContext context) {
    _socketClient.listenEvent('update-game', (data) {
      try {
        final game = GameModel.fromJson(data);
        print(game);
        final provider = Provider.of<GameProvider>(context, listen: false);
        provider.updateGameState(game: game);

        if (!_isPlaying) {
          Navigator.of(context).pushNamed(Routes.gameScreen);
          _isPlaying = true;
        }
      } catch (e) {
        print(e);
      }
    });
  }

  notCorrectGameListener(BuildContext context) {
    _socketClient.listenEvent('not-correct-game', (data) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
    });
  }

  updateTimer(BuildContext context) {
    final ClientStateProvider provider =
        Provider.of<ClientStateProvider>(context, listen: false);
    _socketClient.listenEvent('timer', (data) {
      provider.setClientState(data);
    });
  }

  updateGame(BuildContext context) {
    _socketClient.listenEvent('update-game', (data) {
      try {
        final game = GameModel.fromJson(data);
        final provider = Provider.of<GameProvider>(context, listen: false);
        provider.updateGameState(game: game);
      } catch (e) {
        print(e);
      }
    });
  }

  gameFinishedListener(BuildContext context) {
    _socketClient.listenEvent(
        'done', (data) => _socketClient.socket.off('timer'));
  }
}
