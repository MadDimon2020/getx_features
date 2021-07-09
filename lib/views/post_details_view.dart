import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_features/controllers/home_controller.dart';
import 'package:getx_features/controllers/post_details_controller.dart';

class PostDetailsView extends GetWidget<PostDetailsController> {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GetX<PostDetailsController>(
            builder: (controller) => Row(
              children: [
                if (controller.$userId.value == controller.currentUser.uid)
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      elevation: MaterialStateProperty.all(5.0),
                    ),
                    icon: Icon(Icons.edit),
                    label: Text('Edit'),
                    onPressed: () {},
                    //TODO Implement Editing
                  ),
                SizedBox(
                  width: 5.0,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green[500])),
                  icon: Icon(Icons.share),
                  label: Text('Share'),
                  onPressed: () {},
                  //TODO Implement Sharing
                ),
                SizedBox(
                  width: 5.0,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).accentColor)),
                  icon: Icon(Icons.comment),
                  label: Text('Comment'),
                  onPressed: () {},
                  //TODO Implement Commenting on the post
                ),
                SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
      body: GetX<PostDetailsController>(
        builder: (controller) => Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              child: Text(
                controller.$postTitle.value,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Created by: ${controller.$author.value}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurpleAccent,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  child: Text(
                    controller.$postBody.value,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        padding: const EdgeInsets.symmetric(
          // horizontal: 10.0,
          vertical: 3.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: (Get.width) / 3,
              child: TextButton(
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: controller.$postIndex.value == 0
                            ? Colors.grey.shade600
                            : Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Previous',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: controller.$postIndex.value == 0
                              ? Colors.grey.shade600
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: controller.goToPreviousPost,
              ),
            ),
            Container(
              width: (Get.width) / 3,
              child: TextButton(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      color: Theme.of(context).accentColor,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
                onPressed: () {
                  Get.back();
                  homeController.restartStream();
                },
              ),
            ),
            Container(
              width: (Get.width) / 3,
              child: TextButton(
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: controller.$postIndex.value ==
                                  (controller.loadedPosts.length - 1)
                              ? Colors.grey.shade600
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Icon(Icons.arrow_forward,
                          color: controller.$postIndex.value ==
                                  (controller.loadedPosts.length - 1)
                              ? Colors.grey.shade600
                              : Theme.of(context).primaryColor),
                    ],
                  ),
                ),
                onPressed: controller.goToNextPost,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
