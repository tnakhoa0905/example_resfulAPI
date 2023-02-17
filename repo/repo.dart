import 'dart:async';
import 'dart:convert';

import 'package:example_resful_api/models/album.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Repository {
  StreamController<List<Album>> _listAlBumController =
      StreamController<List<Album>>();

  Stream<List<Album>> get streamListAlbum => _listAlBumController.stream;

  Future<List<Album>> fetchAllAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> parsed = jsonDecode(response.body);
      return parsed.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Album> createAlbum(String title) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      print('thêm được rồi');
      futureAlbum.add(Album.fromJson(jsonDecode(response.body)));
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<Album> updateAlbum(String title, int id, BuildContext context) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      print('Sửa thành công');
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  Future<void> deleteAlbum(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print('xóa thành công');
    } else {
      throw Exception('Failed to delete album.');
    }
  }
}
