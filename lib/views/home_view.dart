import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_features/bindings/post_details_binding.dart';
import 'package:getx_features/controllers/auth_controller.dart';
import 'package:getx_features/controllers/home_controller.dart';
import 'package:getx_features/models/post.dart';
import 'package:getx_features/views/new_post_view.dart';
import 'package:getx_features/views/post_details_view.dart';

class HomeView extends GetWidget<HomeController> {
  final controller = Get.put(HomeController());
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(controller.appBarTitle),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                height: Get.width * 0.14,
                child: Image.asset(
                  'assets/post-icon.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        actions: [
          DropdownButton(
            underline: SizedBox(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                authController.signOut();
                controller.restartStream();
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: controller.postsStream,
          builder: (context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final loadedPosts = streamSnapshot.data.docs
                .map((item) => Post(
                      title: item['title'],
                      postBody: item['body'],
                      date: item['date'],
                      userId: item['userId'],
                      userName: item['userName'],
                    ))
                .toList();
            if (loadedPosts.length == 0)
              return Center(
                child: Text(
                  'No posts published so far ... \nBe the first to post something!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              );
            return ListView.builder(
              itemCount: loadedPosts.length,
              itemBuilder: (context, index) {
                final postIndex = index.obs;
                return InkWell(
                  splashColor: Theme.of(context).primaryColor,
                  child: Card(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    elevation: 5.0,
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(
                        loadedPosts[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Posted on: ${loadedPosts[index].date}',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700),
                      ),
                      trailing: Text(
                        'Posted by: ${loadedPosts[index].userName}',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade700),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      () => PostDetailsView(),
                      binding: PostDetailsBinding(),
                      arguments: [
                        loadedPosts,
                        loadedPosts[index].title,
                        loadedPosts[index].postBody,
                        loadedPosts[index].userName,
                        loadedPosts[index].userId,
                        postIndex,
                      ],
                    );
                    print(index);
                  },
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.post_add),
        tooltip: 'Create a new post',
        onPressed: () => Get.to(() => NewPostView()),
      ),
    );
  }
}
