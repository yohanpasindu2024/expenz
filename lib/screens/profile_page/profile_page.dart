import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/paths.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/screens/profile_page/items/action_card.dart';
import 'package:expenz/screens/profile_page/items/bottom_sheet_widget.dart';
import 'package:expenz/screens/profile_page/items/profile_page_header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final void Function() logOut;
  final Map<String, String> userData;
  const ProfilePage({
    super.key,
    required this.userData,
    required this.logOut,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetWidget(
          yes: () {
            widget.logOut();
          },
          no: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String imagePath = yProfileImage;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: y200,
              vertical: 50,
            ),
            child: Column(
              children: [
                ProfilePageHeader(
                  userData: widget.userData,
                  image: imagePath,
                ),
                SizedBox(
                  height: 70,
                ),
                Column(
                  children: [
                    ActionCard(
                      color: yPurpleColor,
                      icon: Icons.wallet,
                      actionLabel: yMyWallet,
                      action: () {},
                    ),
                    ActionCard(
                      color: yPurpleColor,
                      icon: Icons.settings,
                      actionLabel: ySettings,
                      action: () {},
                    ),
                    ActionCard(
                      color: yPurpleColor,
                      icon: Icons.download,
                      actionLabel: yExportData,
                      action: () {},
                    ),
                    ActionCard(
                      color: yOrangeColor,
                      icon: Icons.logout,
                      actionLabel: yLogOut,
                      action: () {
                        _showBottomSheet(context: context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
