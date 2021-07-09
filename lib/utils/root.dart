import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_features/controllers/auth_controller.dart';
import 'package:getx_features/views/auth_view.dart';
import 'package:getx_features/views/home_view.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.fbUser,
        builder: (context, userSnapshot) {
          return userSnapshot.hasData ? HomeView() : AuthView();
        });
  }
}
