class GameModel {
  String? id;
  List<Player>? players;
  bool? isJoin;
  bool? isOver;
  List<String>? words;

  GameModel({
    this.id,
    this.players,
    this.isJoin,
    this.isOver,
    this.words,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'players': players,
        'isJoin': isJoin,
        'isOver': isOver,
        'words': words,
      };

  GameModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['players'] != null) {
      players = <Player>[];
      json['players'].forEach((v) {
        players!.add(Player.fromJson(v));
      });
    }
    isJoin = json['isJoin'];
    isOver = json['isOver'];
    if (json['words'] != null) {
      words = json['words'].cast<String>();
    }
  }
}

class Player {
  String? id;
  String? nickname;
  int? currentWordIndex;
  int? wpm;
  String? socketID;
  bool? isPartyLeader;

  Player({
    this.id,
    this.nickname,
    this.currentWordIndex,
    this.wpm,
    this.socketID,
    this.isPartyLeader,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nickname': nickname,
        'currentWordIndex': currentWordIndex,
        'wpm': wpm,
        'socketID': socketID,
        'isPartyLeader': isPartyLeader,
      };

  Player.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nickname = json['nickname'];
    currentWordIndex = json['currentWordIndex'];
    wpm = json['WPM'];
    socketID = json['socketID'];
    isPartyLeader = json['isPartyLeader'];
  }
}
