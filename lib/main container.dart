import 'package:flutter/material.dart';

void main() {
runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exemplo Container'),
          ),
        
        body: Container(
          width: 600,
          height: 3600,
          color: Colors.purple[100],
          child: Center(
            child: Text("Olá flutter", style: TextStyle(color: Colors.purple[900], fontSize: 60)
            ),
          ),
        ),
      ),
    );
  }
}