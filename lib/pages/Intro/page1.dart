import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quest_bank/widget/widget_support.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 210),
        child: Padding(
          padding: const EdgeInsets.only(right: 29),
          child: Column(
            children: [
              Lottie.network(
                  "https://lottie.host/a5a67cb1-0480-4298-9420-9e67cbafae79/3v8OM9XBj4.json"),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                    "Dive into a treasure trove of past questions and improve your exam strategy.",
                    style: AppWidget.introTextFieldStyle()),
              )
            ],
          ),
        ),
      ),
    );
  }
}


