import 'package:flutter/material.dart';
import 'package:quest_bank/pages/Intro/page1.dart';
import 'package:quest_bank/pages/Intro/page2.dart';
import 'package:quest_bank/pages/Intro/page3.dart';
import 'package:quest_bank/pages/signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [Page1(), Page2(), Page3()],
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.05, right: screenWidth * 0.05),
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                      onLastPage ? "" : "Skip",
                      style: TextStyle(
                        color: Color(0xffC0C0C0),
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                child: Column(
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: WormEffect(
                        dotHeight: screenHeight * 0.01,
                        dotWidth: screenHeight * 0.01,
                        spacing: screenHeight * 0.015,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    GestureDetector(
                      onTap: () {
                        if (onLastPage) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        } else {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.07,
                        decoration: BoxDecoration(
                          color: Color(0Xff0c9cc8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          onLastPage ? "Done" : "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
