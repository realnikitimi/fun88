// import 'dart:math';

// import 'package:flutter/widgets.dart' show debugPrint;

class Category {
  final String id;
  final String category;
  final String iconActive;
  final String iconOff;
  final String iconLight;
  final Map<String, int> providers;
  final int count;
  final dynamic article;

  Category({
    required this.id,
    required this.category,
    required this.iconActive,
    required this.iconOff,
    required this.iconLight,
    required this.providers,
    required this.count,
    required this.article,
  });

  factory Category.fromJSON(Map<String, dynamic> json) {
    String article = json['article'].runtimeType == String
        ? json['article']
        : json['article'].toString();
    Category fallback() => Category(
      id: 'id',
      category: 'category',
      iconActive: 'iconActive',
      iconOff: 'iconOff',
      iconLight: 'iconLight',
      providers: {},
      count: -1,
      article: 'article',
    );

    if (json['id'].runtimeType != String) {
      // debugPrint('id: ${json['id']}');
      return fallback();
    }
    if (json['category'].runtimeType != String) {
      // debugPrint('category: ${json['category']}');
      return fallback();
    }
    if (json['icon_active'].runtimeType != String) {
      // debugPrint('icon_active: ${json['icon_active']}');
      return fallback();
    }
    if (json['icon_off'].runtimeType != String) {
      // debugPrint('icon_off: ${json['icon_off']}');
      return fallback();
    }
    if (json['icon_light'].runtimeType != String) {
      // debugPrint('icon_light: ${json['icon_light']}');
      return fallback();
    }
    // if (Map.from(json['providers']).entries.toList().isNotEmpty) {
    // debugPrint('providers: ${json['providers']}');
    //   return fallback();
    // }
    if (json['count'].runtimeType != int) {
      // debugPrint('count: ${json['count']}');
      return fallback();
    }

    return Category(
      id: json['id'],
      category: json['category'],
      iconActive: json['icon_active'],
      iconOff: json['icon_off'],
      iconLight: json['icon_light'],
      providers: Map<String, int>.from(json['providers']),
      count: json['count'],
      article: article,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "category": category,
      "icon_active": iconActive,
      "icon_off": iconOff,
      "icon_light": iconLight,
      "providers": providers,
      "count": count,
      "article": article,
    };
  }
}
