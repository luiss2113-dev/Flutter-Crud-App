import 'dart:convert';
import 'dart:io';

import 'package:crud/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PostProvider extends ChangeNotifier {
  final _baseUrl = "https://jsonplaceholder.typicode.com/";

  List<PostResponse> postList = [];

  PostProvider() {
    getonDisplayPosts();
  }

  getonDisplayPosts() async {
    final response = await _getApiHelperGet("posts");
    final listPost = json.decode(response) as List;

    for (var i = 0; i < listPost.length; i++) {
      postList.add(PostResponse(
          userId: listPost[i]["userId"],
          body: listPost[i]["body"],
          id: listPost[i]["id"],
          title: listPost[i]["title"]));
    }

    notifyListeners();
  }

  Future<bool> savePost(Map<String, dynamic> jsonserialize) async {
    final response =
        await _getApiHelperPost(PostResponse.fromMap(jsonserialize), "posts");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final newPost = PostResponse.fromJsonitem(json.decode(response.body));
      postList.add(newPost);

      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> updatePost(
      Map<String, dynamic> jsonSerialize, int postId) async {
    final post = PostResponse.fromMap(jsonSerialize);
    final response = await _getApiHerperUpdate(post, "posts/$postId");

    if (response.statusCode == 200) {
      final postUpdated = PostResponse.fromJsonitem(json.decode(response.body));
      postList = postList
          .map((postItem) =>
              postItem.id == postUpdated.id ? postItem = postUpdated : postItem)
          .toList();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<Response> _getApiHelperPost(
      PostResponse onData, String endPoint) async {
    final response = await http.post(getUri(endPoint),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: onData.toJson());
    return response;
  }

  Future<String> _getApiHelperGet(String endPoint) async {
    final response = await http.get(getUri(endPoint));
    return response.body;
  }

  Future<Response> _getApiHerperUpdate(
      PostResponse onData, String endPoint) async {
    final response = await http.patch(getUri(endPoint),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: onData.toJson());
    return response;
  }

  Uri getUri(String endPoint) => Uri.parse("$_baseUrl$endPoint");
}
