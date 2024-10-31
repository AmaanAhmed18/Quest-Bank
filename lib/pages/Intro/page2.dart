import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quest_bank/widget/widget_support.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 200),
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Lottie.network(
                  "https://lottie.host/a2026ade-398a-43eb-bfed-40bdd0ca16e5/avZg9IL1Wo.json"),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                    "Gain insights with detailed analysis to boost your preparation.",
                    style: AppWidget.introTextFieldStyle()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
