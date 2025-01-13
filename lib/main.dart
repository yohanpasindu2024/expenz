import 'package:expenz/services/user_service.dart';
import 'package:expenz/transaction_provider.dart';
import 'package:expenz/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TransactionProvider(),
      child: EXpenzApp(),
    ),
  );
}

class EXpenzApp extends StatelessWidget {
  const EXpenzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.checkRememberMe(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          bool rememberMe = snapshot.data ?? false;
          return Wrapper(isHomePageShow: rememberMe);
        }
      },
    );
  }
}
