import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text("Meu Cartão"), centerTitle: true),

        body: Center(
          child: Container(
            width: 350,
            height: 200,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Banco SESI / SENAI",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(Icons.contactless, size: 30, color: Colors.white),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.sim_card, size: 30, color: Colors.orangeAccent),
                  ],
                ),
                
                Text(
                  "1 2 3 4  5 6 7 8  9 0 1 2  3 4 5 6",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),

                SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Titular", style: TextStyle(color: Colors.white)), 
                        Text("Anna Hilda", style: TextStyle(color: Colors.white)),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Validade", style: TextStyle(color: Colors.white)),
                        Text("06/90", style: TextStyle(color: Colors.white)),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}