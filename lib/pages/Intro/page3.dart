import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quest_bank/widget/widget_support.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 200),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Lottie.network(
                  "https://lottie.host/7e079dfc-8cce-485e-9cfd-3813f4d60ef2/QeFvK1s4RA.json"),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                    "Stay ahead of the curve with our expertly predicted questions.",
                    style: AppWidget.introTextFieldStyle()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
