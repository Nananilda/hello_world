import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; //para pegar a localização atual

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'meu mapa',
      home: const MapaPage(),
    );
  }
}

class MapaPage extends StatefulWidget {
  //para mudar a tela em tempo real
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Position? posicao; // variavel pode ser nula

  final MapController mapaController = MapController();

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

    Position novaPosicao = await Geolocator.getCurrentPosition();

    setState(() {
      posicao = novaPosicao;
    });

    mapaController.move(
      LatLng(novaPosicao.latitude, novaPosicao.longitude),
      16,
    );
  }

  @override
  void initState() {
    super.initState();
    buscarLocalizacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('meu mapa')),

      body: FlutterMap(
        //compoente responsável pelo mapa
        mapController: mapaController,

        options: const MapOptions(
          //definições iniciais do mapa
          initialCenter: LatLng(-21.470000, -47.030000),
          initialZoom: 13,
        ),

        children: [
          TileLayer(
            //carregam as imagens que formam o mapa
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mapa_flutter',
          ),

          if (posicao != null)
            MarkerLayer(
              //vetor de marcadores
              markers: [
                Marker(
                  point: LatLng(posicao!.latitude, posicao!.longitude),
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ],
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton( //botão de achar a localização
        onPressed: buscarLocalizacao,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
