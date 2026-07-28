import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/carrinho_page.dart';
import 'pages/usuario_page.dart';

void main() {
  runApp(const MeuApp());
}

List<Map<String, dynamic>> produtos = [
  {"nome": "Arroz kometudo", "preco": 32.00, "imagem": "assets/images/arroz.png"},
  {"nome": "Feijão kicaldo", "preco": 11.00, "imagem": "assets/images/feijao.png"},
  {"nome": "Leite Piracanjuba", "preco": 5.79, "imagem": "assets/images/leite.png"},
  {"nome": "Macarrão Renata Colorido", "preco": 5.49, "imagem": "assets/images/macarrao.png"},
  {"nome": "Café", "preco": 14.00, "imagem": "assets/images/cafe.png"},
];

List<Map<String, dynamic>> carrinho = [];

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ComprasPage()),
    GoRoute(
      path: '/carrinho',
      builder: (context, state) => const CarrinhoPage(),
    ),
    GoRoute(path: '/usuario', builder: (context, state) => const UsuarioPage()),
  ],
);

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Mercadinho",
      routerConfig: router,
    );
  }
}

class ComprasPage extends StatefulWidget {
  const ComprasPage({super.key});

  @override
  State<ComprasPage> createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  void adicionarProduto(Map<String, dynamic> produto) {
    setState(() {
      carrinho.add(produto);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${produto["nome"]} adicionado ao carrinho!"),
        // backgroundColor: Colors.lightGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text("Mercadinho"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(
                    produto["imagem"],
                    width: 50, 
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          produto["nome"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "R\$ ${produto["preco"].toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      adicionarProduto(produto);
                    },
                    child: const Text("Adicionar"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            context.go("/carrinho");
          }

          if (index == 2) {
            context.go("/usuario");
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Compras"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Carrinho",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Usuário"),
        ],
      ),
    );
  }
}
