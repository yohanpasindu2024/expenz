import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/reusables/reusable_text_button.dart';
import 'package:flutter/material.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  bool _rememberMe = false;
  bool _passwrodShow = true;
  bool _confirmPasswordShow = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: y200,
              vertical: y150,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: y350,
                ),
                Text(
                  yFormTitle,
                  style: TextStyle(
                    fontSize: y300,
                    color: yBlackColor.withValues(
                      alpha: 0.8,
                    ),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: y300,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name";
                          } else {
                            if (value.length > 18) {
                              return "Oops! name is too long";
                            }
                          }
                        },
                        decoration: inputBorderDecoration(
                          hintText: " $yName",
                        ),
                      ),
                      const SizedBox(
                        height: y200,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          } else {
                            if (value.contains("@") && value.contains(".")) {
                              return null;
                            } else {
                              return "Please enter a valid email";
                            }
                          }
                        },
                        decoration: inputBorderDecoration(
                          hintText: " $yEmail",
                        ),
                      ),
                      const SizedBox(
                        height: y200,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _passwrodShow,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Passord cannot be empty";
                          } else {
                            if (value.length > 6 && value.length < 18) {
                              return null;
                            } else {
                              return "Password must be between 6 to 18 characters";
                            }
                          }
                        },
                        decoration: inputBorderDecoration(
                          hintText: " $yPassword",
                          icon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwrodShow = !_passwrodShow;
                              });
                            },
                            child: Icon(Icons.remove_red_eye_rounded),
                          ),
                          iconColor: _passwrodShow,
                        ),
                      ),
                      const SizedBox(
                        height: y200,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _confirmPasswordShow,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Confirm Password cannot be empty";
                          } else {
                            if (value == _passwordController.text) {
                              return null;
                            } else {
                              return "Password does not match";
                            }
                          }
                        },
                        decoration: inputBorderDecoration(
                          hintText: " $yConfirmPassword",
                          icon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _confirmPasswordShow = !_confirmPasswordShow;
                              });
                            },
                            child: Icon(Icons.remove_red_eye_rounded),
                          ),
                          iconColor: _confirmPasswordShow,
                        ),
                      ),
                      const SizedBox(
                        height: y200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            yRememberLogIn,
                            style: TextStyle(
                              fontSize: y100 + 5,
                              color: yBlackColor.withValues(
                                alpha: 0.7,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Checkbox(
                            activeColor: yPurpleColor,
                            value: _rememberMe,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                yBorderRadius350,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: y500,
                      ),
                      Material(
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: ReusableTextButton(),
                        ),
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

  InputDecoration inputBorderDecoration({
    required String hintText,
    bool? iconColor,
    GestureDetector? icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          yBorderRadius350,
        ),
      ),
      contentPadding: const EdgeInsets.all(
        y200,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: yPurpleColor,
        ),
        borderRadius: BorderRadius.circular(
          yBorderRadius350,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: yBlackColor.withValues(
            alpha: 0.2,
          ),
        ),
        borderRadius: BorderRadius.circular(
          yBorderRadius350,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: yOrangeColor,
        ),
        borderRadius: BorderRadius.circular(
          yBorderRadius350,
        ),
      ),
      errorStyle: TextStyle(
        color: yOrangeColor,
        fontSize: y100,
        fontWeight: FontWeight.w500,
      ),
      suffixIcon: icon,
      suffixIconColor: iconColor != null
          ? !iconColor
              ? yPurpleColor
              : yBlackColor.withValues(
                  alpha: 0.5,
                )
          : yBlackColor.withValues(
              alpha: 0.5,
            ),
    );
  }
}
