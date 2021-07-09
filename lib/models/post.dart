import 'package:flutter/material.dart';

class Post {
  String title;
  String postBody;
  String date;
  String userName;
  String userId;

  Post({
    @required this.title,
    @required this.postBody,
    @required this.date,
    @required this.userName,
    @required this.userId,
  });
}
