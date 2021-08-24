import 'package:demo/Views/Breaking_bad_View.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BBScreen(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          Expanded(
            child: FlutterLogo(
              size: 200,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Hello There,',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 10,
                  ),
                  MyButton("LOG IN", Colors.grey.shade200),
                  MyButton("SIGN UP", Colors.orangeAccent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton(this.title, this.buttonColor);

  final String title;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BBScreen()));
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: buttonColor,
            boxShadow: [
              BoxShadow(
                  color: buttonColor.withOpacity(0.5),
                  blurRadius: 4,
                  offset: Offset(0, 7))
            ]),
      ),
    );
  }
}
