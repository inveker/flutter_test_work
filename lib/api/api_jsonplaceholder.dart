import 'dart:convert';

import 'package:flutter_test_work/models/album_model.dart';
import 'package:flutter_test_work/models/comment_model.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/models/post_model.dart';
import 'package:flutter_test_work/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiJsonPlaceholder {
  static const domain = 'jsonplaceholder.typicode.com';

  static Future<List<UserModel>> getUsers() async {
    final data = await _Cache.wrapper('users', () async {
      final url = Uri.https(domain, 'users');
      final response = await http.get(url);
      return response.body;
    });
    final json = jsonDecode(data);
    return [
      for (var i in json) UserModel.fromJson(i),
    ];
  }

  static Future<UserModel> getUser(int userId) async {
    final data = await _Cache.wrapper('user:$userId', () async {
      final url = Uri.https(domain, 'users/$userId');

      final response = await http.get(url);
      return response.body;
    });
    final json = jsonDecode(data);
    return UserModel.fromJson(json);
  }

  static Future<List<PostModel>> getPosts(int userId, {int? count}) async {
    final data = await _Cache.wrapper('posts:$userId:$count', () async {
      final url = Uri.https(
        domain,
        'users/$userId/posts',
        {
          '_start': '0',
          if (count != null) '_end': '$count',
        },
      );
      final response = await http.get(url);
      return response.body;
    });
    final json = jsonDecode(data);
    return [
      for (var i in json) PostModel.fromJson(i),
    ];
  }

  static Future<PostModel> getPost(int postId) async {
    final data = await _Cache.wrapper('post:$postId', () async {
      final url = Uri.https(domain, 'posts/$postId');
      final response = await http.get(url);
      return response.body;
    });
    final json = jsonDecode(data);
    return PostModel.fromJson(json);
  }

  static Future<List<AlbumModel>> getAlbums(int userId, {int? count}) async {
    final data = await _Cache.wrapper('albums:$userId:$count', () async {
      final url = Uri.https(
        domain,
        'users/$userId/albums',
        {
          '_start': '0',
          if (count != null) '_end': '$count',
        },
      );
      final response = await http.get(url);
      return response.body;
    });
    final json = jsonDecode(data);
    return [
      for (var i in json) AlbumModel.fromJson(i),
    ];
  }

  static Future<AlbumModel> getAlbum(int albumId) async {
    final data = await _Cache.wrapper('album:$albumId', () async {
      final url = Uri.https(domain, 'albums/$albumId');
      final response = await http.get(url);
      return response.body;
    });
    final json = jsonDecode(data);
    return AlbumModel.fromJson(json);
  }

  static Future<List<CommentModel>> getComments(int postId) async {
    final data = await _Cache.wrapper('comments:$postId', () async {
      final url = Uri.https(domain, 'posts/$postId/comments');
      final response = await http.get(url);
      return response.body;
    });
    final json = jsonDecode(data);
    return [
      for (var i in json) CommentModel.fromJson(i),
    ];
  }

  static Future<CommentModel> createComment({
    required int postId,
    required String name,
    required String email,
    required String body,
  }) async {
    final url = Uri.https(domain, 'comments');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'postId': postId,
        'name': name,
        'email': email,
        'body': body,
      }),
    );
    final data = jsonDecode(response.body);

    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'comments:$postId';
    var savedData = prefs.getString(cacheKey) ?? '{}';
    List json = jsonDecode(savedData);
    json.add(data);
    await prefs.setString(cacheKey, jsonEncode(json));

    return CommentModel.fromJson(data);
  }

  static Future<List<PhotoModel>> getAlbumPhotos(int albumId, {int? count}) async {
    final data = await _Cache.wrapper('photos:$albumId:$count', () async {
      final url = Uri.https(
        domain,
        'album/$albumId/photos',
        {
          '_start': '0',
          if (count != null) '_end': '$count',
        },
      );
      final response = await http.get(url);
      return response.body;
    });
    final json = jsonDecode(data);
    return [
      for (var i in json) PhotoModel.fromJson(i),
    ];
  }
}

class _Cache {
  static Future<String> wrapper(String cacheKey, Future<String> Function() createCallback) async {
    final prefs = await SharedPreferences.getInstance();
    var savedData = prefs.getString(cacheKey);
    if (savedData == null) {
      var data = await createCallback();
      await prefs.setString(cacheKey, data);
      savedData = data;
    }
    return savedData;
  }
}
