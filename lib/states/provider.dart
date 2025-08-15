// import 'package:flutter/material.dart' show debugPrint;

class Provider {
  final String name;
  final String iconDark;
  final String iconLight;
  final int count;
  final dynamic article;

  Provider({
    required this.name,
    required this.iconDark,
    required this.iconLight,
    required this.count,
    required this.article,
  });

  factory Provider.fromJSON(String name, Map<String, dynamic> json) {
    var iconDark = json['iconDark'].runtimeType == String
        ? json['iconDark']
        : '';
    var iconLight = json['iconLight'].runtimeType == String
        ? json['iconLight']
        : '';
    var count = json['count'].runtimeType == int ? json['count'] : -1;
    var article = json['article'].runtimeType == String ? json['article'] : '';

    // debugPrint(json['article'].runtimeType.toString());

    return Provider(
      name: name,
      iconDark: iconDark,
      iconLight: iconLight,
      count: count,
      article: article,
    );
  }
}
