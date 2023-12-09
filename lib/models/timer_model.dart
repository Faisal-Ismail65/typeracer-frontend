class TimerModel {
  final Map<String, dynamic> timer;

  TimerModel({required this.timer});

  Map<String, dynamic> toJson() => {'timer': timer};
}
