import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_features/models/post.dart';

class PostDetailsController extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;
  final loadedPosts = Get.arguments[0] as List<Post>;
  var $postTitle = Get.arguments[1].toString().obs;
  var $postBody = Get.arguments[2].toString().obs;
  var $author = Get.arguments[3].toString().obs;
  var $userId = Get.arguments[4].toString().obs;
  var $postIndex = Get.arguments[5] as RxInt;

  void goToNextPost() {
    if ($postIndex.value < (loadedPosts.length - 1)) {
      $postIndex++;
      $postTitle.value = loadedPosts[$postIndex.value].title;
      $postBody.value = loadedPosts[$postIndex.value].postBody;
      $author.value = loadedPosts[$postIndex.value].userName;
      $userId.value = loadedPosts[$postIndex.value].userId;
      print('postIndex: ${$postIndex}');
    } else {
      Get.snackbar(
        'This is the last post!',
        'No further posts available.',
        padding: EdgeInsets.only(
          left: 20,
          right: 30,
          top: 20,
          bottom: 20,
        ),
        mainButton: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Get.theme.accentColor),
            ),
            onPressed: () {
              navigator.pop();
            },
            child: Text(
              'Got it!',
              style: TextStyle(color: Colors.white),
            )),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.shade300,
        titleText: Text(
          'This is the last post!',
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          'No further posts available.',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  void goToPreviousPost() {
    if ($postIndex > 0) {
      $postIndex--;
      $postTitle.value = loadedPosts[$postIndex.value].title;
      $postBody.value = loadedPosts[$postIndex.value].postBody;
      $author.value = loadedPosts[$postIndex.value].userName;
      $userId.value = loadedPosts[$postIndex.value].userId;
      print('postIndex: ${$postIndex}');
    } else {
      Get.snackbar(
        'This is the very first post!',
        'No previous posts available.',
        padding: EdgeInsets.only(
          left: 20,
          right: 30,
          top: 20,
          bottom: 20,
        ),
        mainButton: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Get.theme.accentColor),
            ),
            onPressed: () {
              navigator.pop();
            },
            child: Text(
              'Got it!',
              style: TextStyle(color: Colors.white),
            )),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.shade300,
        titleText: Text(
          'This is the very first Post!',
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          'No previous posts available.',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
