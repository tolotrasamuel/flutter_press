import 'dart:convert';

import 'package:flutter_press/model/new_post_payload.dart';
import 'package:flutter_press/model/post.dart';
import 'package:flutter_press/model/post_count.dart';
import 'package:flutter_press/model/post_status.dart';
import 'package:flutter_press/model/post_status_payload.dart';
import 'package:flutter_press/model/posts_read_payload.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://localhost:7069/api';
  static const String _addPost = '/addNewPost';
  static const String _editPost = '/editPost';
  static const String _editPostStatus = '/editPostStatus';
  static const String _readPosts = '/readPosts';
  static const String _readPost = '/readPost';
  static const String _deletePost = '/deletePost';
  static const String _readPostsCount = '/readPostsCount';

  Future<Post> readPost(String id) async {
    const url = '$_baseUrl$_readPost';
    final queryParameters = {
      'id': id,
    };

    final uri = Uri.parse(url).replace(queryParameters: queryParameters);
    print(uri);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print('Post read');
      final body = response.body;
      print(body);
      final dynamic post = jsonDecode(response.body)["data"];
      return Post.fromJson(post);
    } else {
      throw Exception('Failed to read post $id');
    }
  }

  Future<PostCount> fetchPostsCount() async {
    const url = '$_baseUrl$_readPostsCount';

    final uri = Uri.parse(url);
    print(uri);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print('Post count read');
      final body = response.body;
      print(body);
      final dynamic post = jsonDecode(response.body)["data"];
      return PostCount.fromJson(post);
    } else {
      throw Exception('Failed to read post count');
    }
  }

  Future<List<Post>> readAllPosts({
    required PostStatus? postStatus,
  }) async {
    const url = '$_baseUrl$_readPosts';
    final queryParameters = PostsReadPayload(
      status: postStatus,
    ).toJson();
    print("queryParameters: $queryParameters");
    final uri = Uri.parse(url).replace(queryParameters: queryParameters);
    print(uri);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print('Post read');
      final body = response.body;
      print(body);
      final List<dynamic> posts = List.from(jsonDecode(response.body)["data"]);
      return posts.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to read posts');
    }
  }

  Future<Post> savePost(NewPostPayload post) async {
    const url = '$_baseUrl$_addPost';
    final uri = Uri.parse(url);
    final data = post.toJson();
    print(data);
    print(uri);
    final response = await http.post(uri, body: json.encode(data), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print('Post saved');
      final dynamic post = jsonDecode(response.body)["data"];
      return Post.fromJson(post);
    } else {
      print('Error saving post');
      throw Exception('Failed to save post');
    }
  }

  Future<Post> editPost(Post post) async {
    const url = '$_baseUrl$_editPost';
    final uri = Uri.parse(url);
    final data = post.toJson();
    print(data);
    print(uri);
    final response = await http.post(uri, body: json.encode(data), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print('Post saved');
      final dynamic post = jsonDecode(response.body)["data"];
      return Post.fromJson(post);
    } else {
      print('Error saving post');
      throw Exception('Failed to save post');
    }
  }

  Future<Post> updatePostStatus(PostStatusPayload postStatusPayload) async {
    const url = '$_baseUrl$_editPostStatus';
    final uri = Uri.parse(url);
    final data = postStatusPayload.toJson();
    print(data);
    print(uri);
    final response = await http.post(uri, body: json.encode(data), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print('Post saved');
      final dynamic post = jsonDecode(response.body)["data"];
      print(post);
      return Post.fromJson(post);
    } else {
      print('Error saving post');
      throw Exception('Failed to save post');
    }
  }

  Future<void> deletePost(String id) async {
    const url = '$_baseUrl$_deletePost';
    final data = {
      'id': id,
    };

    final uri = Uri.parse(url);
    print(data);
    print(uri);
    final response = await http.post(uri, body: json.encode(data), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print('Post deleted');
      final body = response.body;
      print(body);
      final dynamic post = jsonDecode(response.body)["data"];
      print(post);
    } else {
      throw Exception('Failed to delete post $id');
    }
  }

  // Future<List<Post>> getPosts() async {
  //   final response = await http.get(_baseUrl + _posts);
  //   if (response.statusCode == 200) {
  //     final List<dynamic> posts = json.decode(response.body);
  //     return posts.map((post) => Post.fromJson(post)).toList();
  //   } else {
  //     throw Exception('Failed to load posts');
  //   }
  // }
  //
  // Future<List<Comment>> getComments(int postId) async {
  //   final response = await http.get(_baseUrl + _posts + '/$postId' + _comments);
  //   if (response.statusCode == 200) {
  //     final List<dynamic> comments = json.decode(response.body);
  //     return comments.map((comment) => Comment.fromJson(comment)).toList();
  //   } else {
  //     throw Exception('Failed to load comments');
  //   }
  // }
}
