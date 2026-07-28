import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/unicorn.lgo.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Text(
              "SENAI",
              style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 10, 37, 145),
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
        ),
      ),
    );
  }
}
