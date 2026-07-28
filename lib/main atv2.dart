import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ContadorTela());
  }
}

class ContadorTela extends StatefulWidget {
  const ContadorTela({super.key});

  @override
  _ContadorTelaState createState() => _ContadorTelaState();
}

class _ContadorTelaState extends State<ContadorTela> {
  int contador = 0;

  void incrementar() {
    setState(() {
      contador++;
    });
  }

  void diminuir() {
    setState(() {
      if (contador > 0){
      contador = contador - 1;}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aplicativo de curtidas"), centerTitle: true),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, size: 60, color: Colors.red),
            SizedBox(height: 20),

            Text(
              "$contador curtidas",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: incrementar, child: Text("👍 Curtir")),
                SizedBox(width: 20),
                ElevatedButton(onPressed: diminuir, child: Text("👎 Descurtir")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
