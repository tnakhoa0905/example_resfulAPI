import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Album {
  final int id;
  String title;
  Album({
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory Album.fromJson(Map<String, dynamic> map) {
    return Album(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }
}

List<Album> futureAlbum = [];
