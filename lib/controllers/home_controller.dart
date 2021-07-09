import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:getx_features/models/post.dart';

class HomeController extends GetxController {
  final appBarTitle = 'Awesome Posts';

  var postsStream = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('createdAt', descending: true)
      .snapshots();

  void restartStream() {
    final newStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots();
    postsStream = newStream;
  }

  @override
  void onReady() {
    super.onReady();
    restartStream();
  }

  // List<Post> _posts;
  // List<Post> get posts => _posts;

  // Future<void> loadPosts() async {
  //   final postsSnapshot = await FirebaseFirestore.instance
  //       .collection('posts')
  //       .orderBy('createdAt', descending: true)
  //       .get();
  //   _posts = postsSnapshot.docs
  //       .map((item) => Post(
  //             title: item['title'],
  //             postBody: item['body'],
  //             date: item['date'],
  //             userId: item['userId'],
  //             userName: item['userName'],
  //           ))
  //       .toList();
  //   for (int i = 0; i < posts.length; i++) {
  //     print(posts[i].title);
  //   }
  // }
}
