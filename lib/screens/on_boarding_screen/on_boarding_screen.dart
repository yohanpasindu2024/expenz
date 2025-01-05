import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/data/ui_data/on_boarding_screen_data.dart';
import 'package:expenz/reusables/onboarding_container.dart';
import 'package:expenz/reusables/reusable_text_button.dart';
import 'package:expenz/screens/home_page/user_form_page.dart';
import 'package:expenz/screens/on_boarding_screen/front_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool showFormPage = false;
  @override
  Widget build(BuildContext context) {
    final onBoardingScreenList = OnBoardingScreenData.onBoardingScreenDataList;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (int value) {
                    setState(() {
                      showFormPage = value == 3;
                    });
                  },
                  children: [
                    FrontPage(),
                    ...List.generate(
                      onBoardingScreenList.length,
                      (index) {
                        return OnboardingContainer(
                          imagePath: onBoardingScreenList[index].imageUrl,
                          title: onBoardingScreenList[index].title,
                          subtitle: onBoardingScreenList[index].label,
                        );
                      },
                    )
                  ],
                ),
                Container(
                  alignment: const Alignment(
                    0,
                    0.7,
                  ),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const WormEffect(
                      dotWidth: 13,
                      dotHeight: 13,
                      activeDotColor: yPurpleColor,
                      dotColor: yGreyColor,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: y350,
                    ),
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          !showFormPage
                              ? _controller.animateToPage(
                                  _controller.page!.toInt() + 1,
                                  duration: Duration(
                                    milliseconds: 400,
                                  ),
                                  curve: Curves.easeInOut,
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserFormPage(),
                                  ),
                                );
                        },
                        child: ReusableTextButton(
                          text: showFormPage ? yGetStarted : yNext,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
