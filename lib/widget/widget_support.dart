import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle boldTextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d),
                fontSize: 21, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
   static TextStyle navTextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d),
                fontSize: 13, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
   static TextStyle nav2TextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d),
                fontSize: 15, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
  static TextStyle nav3TextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d),
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
  static TextStyle bookTextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d),
                fontSize: 28, 
                fontWeight: FontWeight.w900, 
                fontFamily: 'Poppins');
  }
   static TextStyle book1TextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d),
                fontSize: 26, 
                fontWeight: FontWeight.w900, 
                fontFamily: 'Poppins');
  }
   static TextStyle HeaderTextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d),
                fontSize: 35, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
  static TextStyle LightTextFieldStyle() {
    return const TextStyle(
                color: Colors.black38, 
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
  static TextStyle fitlitTextFieldStyle() {
    return const TextStyle(
                color: Colors.black38, 
                fontSize: 15, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
   static TextStyle yearTextFieldStyle() {
    return const TextStyle(
                color: Colors.black38, 
                fontSize: 16, 
                fontWeight: FontWeight.w800, 
                fontFamily: 'Poppins');
  }
  static TextStyle semiboldTextFieldStyle() {
    return const TextStyle(
                color: Colors.grey, 
                fontSize: 22, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
static TextStyle semibold1TextFieldStyle(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  return TextStyle(
    color: Colors.grey,
    fontSize: screenWidth * 0.05, 
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );
}

  static TextStyle introTextFieldStyle() {
    return const TextStyle(
                color: Color(0xffC0C0C0),
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
  static TextStyle intrTextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d),
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
  static TextStyle litTextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d), 
                fontSize: 22, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }
  static TextStyle lit1TextFieldStyle(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  return TextStyle(
    color: Color(0Xff3f3d3d), 
    fontSize: screenWidth * 0.05, 
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );
}

  static TextStyle subTextFieldStyle() {
    return const TextStyle(
                color: Color(0Xff3f3d3d), 
                fontSize: 22, 
                fontWeight: FontWeight.w900, 
                fontFamily: 'Poppins');
  }

}