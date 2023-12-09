import 'package:flutter/material.dart';
import 'package:typeracer/models/timer_model.dart';

class ClientStateProvider extends ChangeNotifier {
  TimerModel _timer = TimerModel(timer: {'countDown': '', 'msg': ''});

  Map<String, dynamic> get clientState => _timer.toJson();

  setClientState(timer) {
    _timer = TimerModel(timer: timer);
    notifyListeners();
  }
}
