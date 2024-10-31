import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quest_bank/pages/bottomnav.dart';
import 'package:quest_bank/pages/login.dart';
import 'package:quest_bank/widget/widget_support.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> signup(String username, String email, String password) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        Uri.parse('http://10.0.1.122:5000/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Registered successfully');

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Text('Signup Successful! Please Login'),
                  SizedBox(width: 5),
                  Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent,
                    size: 20,
                  ),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.all(20),
              duration: Duration(seconds: 3),
            ),
          );

          Future.delayed(Duration(seconds: 2), () {
            if (response.statusCode == 200 || response.statusCode == 201) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogIn()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Text('Please Try Again Later'),
                      SizedBox(width: 5),
                      Icon(
                        Icons.check_circle,
                        color: Colors.greenAccent,
                        size: 20,
                      ),
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.all(20),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          });
        });
      } else {
        final errorResponse = jsonDecode(response.body);
        String errorMessage =
            errorResponse['error'] ?? 'Unknown error occurred';
        print('Failed to Signup: $errorMessage');

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Text('Failed to signup: $errorMessage'),
                SizedBox(width: 5),
                Icon(
                  Icons.check_circle,
                  color: Colors.greenAccent,
                  size: 20,
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(20),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('An error occurred: $e');

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text('An unexpected error occurred: $e'),
              SizedBox(width: 5),
              Icon(
                Icons.check_circle,
                color: Colors.greenAccent,
                size: 20,
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(20),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFA9A9A9),
                        Color(0xFFD3D3D3),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3.5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Text(""),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "images/arodek-logo.png",
                          width: MediaQuery.of(context).size.width / 0.5,
                          height: MediaQuery.of(context).size.height / 8,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.68,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: 
                          SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(height: 30),
                                  Text(
                                    "Signup",
                                    style: AppWidget.HeaderTextFieldStyle(),
                                  ),
                                  SizedBox(height: 40),
                                  TextFormField(
                                    controller: usernameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Username';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Username",
                                      hintStyle: AppWidget.LightTextFieldStyle(),
                                      prefixIcon: Icon(Icons.person,
                                          color: Color(0Xff0c9cc8)),
                                      errorStyle: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  TextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: AppWidget.LightTextFieldStyle(),
                                      prefixIcon: Icon(Icons.email_outlined,
                                          color: Color(0Xff0c9cc8)),
                                      errorStyle: TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  TextFormField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Password';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: AppWidget.LightTextFieldStyle(),
                                      prefixIcon: Icon(Icons.password_outlined,
                                          color: Color(0Xff0c9cc8)),
                                      errorStyle: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Color(0Xff0c9cc8),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              signup(
                                                usernameController.text,
                                                emailController.text,
                                                passwordController.text,
                                              );
                                            }
                                          },
                                          child: Text(
                                            "SIGN UP",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LogIn()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: AppWidget.semibold1TextFieldStyle(context),
                            ),
                            Text(
                              " Login",
                              style: AppWidget.lit1TextFieldStyle(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                color: Color(0Xff0c9cc8),
              ),
            ),
        ],
      ),
    );
  }
}





