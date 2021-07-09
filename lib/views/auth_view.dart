import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_features/controllers/auth_controller.dart';
import 'package:getx_features/widgets/auth_form.dart';

class AuthView extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/auth-view-image.jpg',
              fit: BoxFit.cover,
              color: Colors.black38,
              colorBlendMode: BlendMode.darken,
            ),
          ),
          AuthForm(),
        ],
      ),
    );
  }
}
