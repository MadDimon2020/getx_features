import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:getx_features/controllers/auth_controller.dart';

class AuthForm extends GetWidget<AuthController> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    Get.focusScope.unfocus();

    if (isValid) {
      _formKey.currentState.save();
      controller.submitAuthForm(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        userName: userNameController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>();
    return GetBuilder<AuthController>(
      builder: (controller) => Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    transform: Matrix4.rotationZ(-5 * pi / 180)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.pink,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Text(
                      'Welcome to the Awesome Posts!',
                      style: TextStyle(
                        color:
                            Theme.of(context).accentTextTheme.headline6.color,
                        fontSize: 26,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Align(
                  child: Text(
                    controller.isLoginMode
                        ? 'Please log in to your account'
                        : 'Please sign up to create an account',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(color: Colors.black54),
                        child: TextFormField(
                          key: ValueKey('email'),
                          controller: emailController,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            ),
                            hintText: 'Email address',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          onSaved: (value) {
                            emailController.text = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (!controller.isLoginMode)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(color: Colors.black54),
                          child: TextFormField(
                            key: ValueKey('username'),
                            controller: userNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                icon: Icon(Icons.person, color: Colors.grey),
                                hintText: 'Username',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            onSaved: (value) {
                              userNameController.text = value;
                            },
                          ),
                        ),
                      if (!controller.isLoginMode)
                        SizedBox(
                          height: 20,
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(color: Colors.black54),
                        child: TextFormField(
                          key: ValueKey('password'),
                          controller: passwordController,
                          validator: (value) {
                            if (value.isEmpty || value.length < 7) {
                              return 'Password must be at least 7 characters long.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock_outline,
                              color: Colors.grey,
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          obscureText: true,
                          onSaved: (value) {
                            passwordController.text = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      if (controller.isLoading) CircularProgressIndicator(),
                      if (!controller.isLoading)
                        MaterialButton(
                          minWidth: double.maxFinite,
                          color: Colors.pink,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controller.isLoginMode ? 'Login' : 'Signup',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          onPressed: _trySubmit,
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      if (!controller.isLoading)
                        TextButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controller.isLoginMode
                                  ? 'Don\'t have an account? Sign up'
                                  : 'I already have an account',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          onPressed: controller.switchAuthMode,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
