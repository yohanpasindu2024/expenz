import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<void> saveUserData({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required bool rememberMe,
    required BuildContext context,
  }) async {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: yPurpleColor.withValues(
            alpha: 0.5,
          ),
          content: const Text(
            yPasswordMatch,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: y150,
            ),
          ),
        ),
      );
      return;
    } else {
      try {
        // Save user data to database
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', userName);
        await prefs.setString('email', email);
        await prefs.setString('password', password);
        await prefs.setBool('rememberMe', rememberMe);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: yPurpleColor.withValues(
                alpha: 0.5,
              ),
              content: const Text(
                yAccountCreationSuccess,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: y150,
                ),
              ),
            ),
          );
        }
      } catch (err) {
        if (kDebugMode) {
          print(
            err.toString(),
          );
        }
      }
    }
  }

  static Future<bool> checkRememberMe() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool("rememberMe") ?? false;
    } catch (err) {
      if (kDebugMode) {
        print(
          err.toString(),
        );
      }
      return false;
    }
  }
}
