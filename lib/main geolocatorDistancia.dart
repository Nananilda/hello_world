import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "minha localização",
      home: const LocalizacaoPage(),            
    );
  }
}

class LocalizacaoPage extends StatefulWidget {
  const LocalizacaoPage({super.key});

  @override
  State<LocalizacaoPage> createState() => _LocalizacaoPageState();
}

class _LocalizacaoPageState extends State<LocalizacaoPage> { 
  double latitude = 0;
  double longitude = 0;
  double latitudeCasa = -21.453859;
  double longitudeCasa = -47.021384;
  double distanciaReal = 0;

  Future<void> buscarLocalizacao() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permissao = await Geolocator.checkPermission();
    
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }

    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      return;
    }
    
    Position posicao = await Geolocator.getCurrentPosition();

    setState(() {
      latitude = posicao.latitude;
      longitude = posicao.longitude;
      distanciaReal = Geolocator.distanceBetween(latitudeCasa, longitudeCasa, posicao.latitude, posicao.longitude);
    });
    
    print('distancia: $distanciaReal');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("distãncia até minha casa")),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const Icon(Icons.house, size: 80, color: Colors.red),

              const SizedBox(height: 20),

              const Text("distancia entre minha casa e a escola", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

              const SizedBox(height: 30),

              const Text("clique no botão para calcular a distância", style: TextStyle(fontSize: 24)),

              const SizedBox(height: 30),

              Text('Distância real: ${distanciaReal.toStringAsFixed(2)} metros'),

              ElevatedButton(
                onPressed: buscarLocalizacao, 
                child: const Text("atualizar localização")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
