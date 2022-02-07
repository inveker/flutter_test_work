import 'dart:convert';

import 'package:flutter_test_work/models/album_model.dart';
import 'package:flutter_test_work/models/comment_model.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/models/post_model.dart';
import 'package:flutter_test_work/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiJsonPlaceholder {
  static const domain = 'jsonplaceholder.typicode.com';

  static Future<List<UserModel>> getUsers() async {
    final url = Uri.https(domain, 'users');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return [
      for (var i in data) UserModel.fromJson(i),
    ];
  }

  static Future<UserModel> getUser(int userId) async {
    final url = Uri.https(domain, 'users/$userId');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return UserModel.fromJson(data);
  }

  static Future<List<PostModel>> getPosts(int userId, {int? count}) async {
    final url = Uri.https(
      domain,
      'users/$userId/posts',
      {
        '_start': '0',
        if (count != null) '_end': '$count',
      },
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return [
      for (var i in data) PostModel.fromJson(i),
    ];
  }

  static Future<PostModel> getPost(int postId) async {
    final url = Uri.https(domain, 'posts/$postId');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return PostModel.fromJson(data);
  }

  static Future<List<AlbumModel>> getAlbums(int userId, {int? count}) async {
    final url = Uri.https(
      domain,
      'users/$userId/albums',
      {
        '_start': '0',
        if (count != null) '_end': '$count',
      },
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return [
      for (var i in data) AlbumModel.fromJson(i),
    ];
  }

  static Future<AlbumModel> getAlbum(int albumId) async {
    final url = Uri.https(domain, 'albums/$albumId');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return AlbumModel.fromJson(data);
  }

  static Future<List<CommentModel>> getComments(int postId) async {
    final url = Uri.https(domain, 'posts/$postId/comments');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return [
      for (var i in data) CommentModel.fromJson(i),
    ];
  }

  static Future<CommentModel> createComment(CommentModel commentModel) async {
    final url = Uri.https(domain, 'comments');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return CommentModel.fromJson(data);
  }

  static Future<PhotoModel> getAlbumPreview(int albumId) async {
    final url = Uri.https(
      domain,
      'album/$albumId/photos',
      {
        '_start': '0',
        '_end': '1',
      },
    );
    final response = await http.get(url);
    List data = jsonDecode(response.body);
    return PhotoModel.fromJson(data.first);
  }
}
