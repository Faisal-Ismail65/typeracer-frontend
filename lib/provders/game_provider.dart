import 'package:flutter/material.dart';
import 'package:typeracer/models/game_model.dart';

class GameProvider extends ChangeNotifier {
  GameModel _game = GameModel();

  Map<String, dynamic> get gameState => _game.toJson();

  GameModel get game => _game;

  updateGameState({required GameModel game}) {
    _game = game;
    notifyListeners();
  }
}
