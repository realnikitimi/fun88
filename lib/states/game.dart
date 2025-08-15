class Game {
  final int sequence;
  final dynamic article;
  final String id;
  final String name;
  final String gameCode;
  final List<String> category;
  final List<int> categoryId;
  final String imgURL;
  final String platform;
  final String platformIconDark;
  final String platformIconLight;
  final GameInfo gameInfo;

  Game({
    required this.sequence,
    required this.article,
    required this.id,
    required this.name,
    required this.gameCode,
    required this.category,
    required this.categoryId,
    required this.imgURL,
    required this.platform,
    required this.platformIconDark,
    required this.platformIconLight,
    required this.gameInfo,
  });

  factory Game.fromJSON(Map<String, dynamic> json) {
    var sequence = json['sequence'];
    var article = json['article'].runtimeType == String
        ? json['article']
        : 'article';
    var id = json['id'];
    var name = json['name'];
    var gameCode = json['game_code'];
    var category = json['category'].runtimeType == List
        ? List<String>.from(json['category'])
        : <String>[];
    var categoryId = json['categoryId'].runtimeType == List
        ? List<int>.from(json['categoryId'])
        : <int>[];
    var imgURL = json['imgURL'];
    var platform = json['platform'];
    var platformIconDark = json['platformIconDark'];
    var platformIconLight = json['platformIconLight'];
    var gameInfo = GameInfo.fromJSON(json['gameInfo']);

    return Game(
      sequence: sequence,
      article: article,
      id: id,
      name: name,
      gameCode: gameCode,
      category: category,
      categoryId: categoryId,
      imgURL: imgURL,
      platform: platform,
      platformIconDark: platformIconDark,
      platformIconLight: platformIconLight,
      gameInfo: gameInfo,
    );
  }
}

class GameInfo {
  final String id;
  final String gameCode;
  final String gameCodeAlias;
  final String gameId;
  final int jackpotAmount;

  GameInfo({
    required this.id,
    required this.gameCode,
    required this.gameCodeAlias,
    required this.gameId,
    required this.jackpotAmount,
  });

  factory GameInfo.fromJSON(Map<String, dynamic> json) {
    var id = json['id'];
    var gameCode = json['gameCode'];
    var gameCodeAlias = json['gameCodeAlias'];
    var gameId = json['gameId'];
    var jackpotAmount = json['jackpot_amount'];
    return GameInfo(
      id: id,
      gameCode: gameCode,
      gameCodeAlias: gameCodeAlias,
      gameId: gameId,
      jackpotAmount: jackpotAmount,
    );
  }
}
