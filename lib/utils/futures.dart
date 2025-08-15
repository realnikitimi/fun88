import 'dart:convert' show jsonDecode;

import 'package:flutter/material.dart' show debugPrint;
import 'package:fun88/states/category.dart';
import 'package:fun88/states/game.dart';
import 'package:fun88/states/provider.dart';
import 'package:fun88/utils/urls.dart';
import 'package:http/http.dart' as http;

class Futures {
  Future<List<Category>> getCategories() async {
    final List<Category> categories = [];
    Uri uri = Uri.parse(categoryStringURL);
    try {
      var response = await http.get(uri);
      var statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 399) {
        throw Exception('Unable to fetch categories.');
      }
      var json = jsonDecode(response.body);
      if (json.runtimeType != List) throw Exception('JSON is not a list.');
      for (var entry in json) {
        categories.add(Category.fromJSON(entry));
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return categories;
  }

  Future<List<Game>> getGames() async {
    final List<Game> games = [];
    Uri uri = Uri.parse(gameStringURL);
    try {
      var response = await http.get(uri);
      var statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 399) {
        throw Exception('Unable to fetch games.');
      }
      var json = jsonDecode(response.body);
      if (json.runtimeType != List) throw Exception('JSON is not a list.');
      for (var entry in json) {
        games.add(Game.fromJSON(entry));
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return games;
  }

  Future<List<Provider>> getCategoryProviderList() async {
    final List<Provider> providers = [];
    Uri uri = Uri.parse(listStringURL);
    try {
      var response = await http.get(uri);
      var statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 399) {
        throw Exception('Unable to fetch category and provider.');
      }
      var json = jsonDecode(response.body);
      for (var entry in Map.from(json['providers']).entries) {
        providers.add(Provider.fromJSON(entry.key, entry.value));
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return providers;
  }
}
