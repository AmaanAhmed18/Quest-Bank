import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quest_bank/pages/signup.dart';
import 'package:quest_bank/widget/widget_support.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 70),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset("images/arodek-logo.png",
                  width: MediaQuery.of(context).size.width / 0.5,
                  height: MediaQuery.of(context).size.height / 8,
                  fit: BoxFit.contain),
            ),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.topCenter,
              child: Text("PASSWORD RECOVERY",
                  style: TextStyle(
                      color: Color(0Xff3f3d3d),
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 60),
            Expanded(
              child: Form(
                child: Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70, width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Enter email',
                              hintStyle: AppWidget.LightTextFieldStyle(),
                              prefixIcon: Icon(Icons.person,
                                  color: Color(0Xff0c9cc8), size: 30),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                              contentPadding:
                                  EdgeInsets.only(left: 15, top: 10)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(right: 14, left: 14),
                        width: 140,
                        padding: EdgeInsets.only(bottom: 10, top: 10, left: 10),
                        decoration: BoxDecoration(
                            color: Color(0Xff0c9cc8),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "SEND MAIL",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: AppWidget.semiboldTextFieldStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text(
                              " Create",
                              style: AppWidget.litTextFieldStyle(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
