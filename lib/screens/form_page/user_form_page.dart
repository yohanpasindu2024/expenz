import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/reusables/reusable_text_button.dart';
import 'package:expenz/screens/main_layout/main_layout.dart';
import 'package:expenz/services/user_service.dart';
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
                            return yEnterName;
                          } else {
                            if (value.length > 18) {
                              return yNameIsLong;
                            }
                          }
                          return null;
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
                            return yEnterEmail;
                          } else {
                            if (value.contains("@") && value.contains(".")) {
                              return null;
                            } else {
                              return yValidEmail;
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
                            return yPassordEmpty;
                          } else {
                            if (value.length > 6 && value.length < 18) {
                              return null;
                            } else {
                              return yPassowrdLength;
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
                            return "$yConfirm $yPassordEmpty";
                          } else {
                            if (value == _passwordController.text) {
                              return null;
                            } else {
                              return yPasswordMatch;
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
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final String userName = _userNameController.text;
                              final String email = _emailController.text;
                              final String password = _passwordController.text;
                              final String confirmPassword =
                                  _confirmPasswordController.text;

                              await UserService.saveUserData(
                                userName: userName,
                                email: email,
                                password: password,
                                confirmPassword: confirmPassword,
                                rememberMe: _rememberMe,
                                context: context,
                              );

                              await Future.delayed(
                                Duration(seconds: 2),
                              );

                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainLayout(),
                                  ),
                                );
                              }
                            }
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
