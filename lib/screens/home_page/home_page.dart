import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/paths.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/screens/home_page/items/amount_expenzes_card.dart';
import 'package:expenz/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  bool isLoading = true;
  late Image _profileImage;

  @override
  void initState() {
    super.initState();
    UserService.getUserName().then((value) {
      if (value != null) {
        setState(() {
          userName = value;
          isLoading = false;
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadImage();
    });
  }

  void _loadImage() {
    setState(() {
      _profileImage = Image.asset(
        yProfileImage,
        fit: BoxFit.cover,
      );
    });
    precacheImage(_profileImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      List<String> names = userName.split(' ');
      return HomePageView(
        userName: names[0],
        profileImage: _profileImage,
      );
    }
  }
}

class HomePageView extends StatefulWidget {
  final String userName;
  final Image profileImage;
  const HomePageView({
    super.key,
    required this.userName,
    required this.profileImage,
  });

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: yPurpleColor.withValues(
          alpha: 0.15,
        ),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.327,
              width: double.infinity,
              decoration: BoxDecoration(
                color: yPurpleColor.withValues(
                  alpha: 0.15,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    y650,
                  ),
                  bottomRight: Radius.circular(
                    y650,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: y150,
                  vertical: y200,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: y450,
                          width: y450,
                          decoration: BoxDecoration(
                            color: yGreyColor,
                            borderRadius: BorderRadius.circular(
                              y500,
                            ),
                            border: Border.all(
                              color: yPurpleColor,
                              width: 1.1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: ClipOval(
                            child: widget.profileImage,
                          ),
                        ),
                        Text(
                          "$yWelcomeTag ${widget.userName},",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontSize: y200 + 3,
                              ),
                        ),
                        SizedBox(
                          height: y150,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: yPurpleColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: y250,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IncomeExpenzesCard(
                          title: yIncome,
                          amount: "${yDollorSign}5000",
                          imgagePath: yIncomeIconImage,
                          color: yGreenColor,
                        ),
                        IncomeExpenzesCard(
                          title: yExpense,
                          amount: "${yDollorSign}1200",
                          imgagePath: yExpenseIconImage,
                          color: yOrangeColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
