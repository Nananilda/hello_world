// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'pages/carrinho_page.dart';
// import 'pages/usuario_page.dart';
// import 'pages/produto_detalhe_page.dart';

// void main() {
//   runApp(const MeuApp());
// }

// class Produto {
//   final int id;
//   final String nome;
//   final double preco;
//   final String imagem;
//   final String descricao;

//   const Produto({
//     required this.id,
//     required this.nome,
//     required this.preco,
//     required this.imagem,
//     required this.descricao,
//   });
// }

// const List<Produto> produtos = [
//   Produto(
//     id: 0,
//     nome: "Arroz Kometudo",
//     preco: 32.00,
//     imagem: "assets/images/arroz.png",
//     descricao: "Arroz branco tipo 1, pacote de 5kg.",
//   ),
//   Produto(
//     id: 1,
//     nome: "Feijão Kicaldo",
//     preco: 11.00,
//     imagem: "assets/images/feijao.png",
//     descricao: "Feijão carioca, pacote de 1kg.",
//   ),
//   Produto(
//     id: 2,
//     nome: "Leite Piracanjuba",
//     preco: 5.79,
//     imagem: "assets/images/leite.png",
//     descricao: "Leite integral, caixa de 1 litro.",
//   ),
//   Produto(
//     id: 3,
//     nome: "Macarrão Renata Colorido",
//     preco: 5.49,
//     imagem: "assets/images/macarrao.png",
//     descricao: "Macarrão Pena Colorido, pacote de 500g.",
//   ),
//   Produto(
//     id: 4,
//     nome: "Café Três Corações",
//     preco: 14.00,
//     imagem: "assets/images/cafe.png",
//     descricao: "Café de torra alta para disfarçar a sujeira, pacote de 500g.",
//   ),
//   Produto(
//     id: 5,
//     nome: "Bolinho Ana Maria",
//     preco: 2.99,
//     imagem: "assets/images/bolinho.jpg",
//     descricao: "Bolinho de gotas de chocolate, pacote de 70g.",
//   ),
//   Produto(
//     id: 6,
//     nome: "Maçã Fuji",
//     preco: 5.74,
//     imagem: "assets/images/maca.png",
//     descricao: "Maçã fuji, embalagem 500g.",
//   ),
//   Produto(
//     id: 7,
//     nome: "Mamão Formosa",
//     preco: 9.41,
//     imagem: "assets/images/mamao.png",
//     descricao: "Mamão Formosa inteiro, unidade de 1,3kg.",
//   ),
//   Produto(
//     id: 8,
//     nome: "Abacate",
//     preco: 6.42,
//     imagem: "assets/images/abacate.png",
//     descricao: "Abacate inteiro, unidade de 200g.",
//   ),
//   Produto(
//     id: 9,
//     nome: "Arroz Kiarroz",
//     preco: 3.49,
//     imagem: "assets/images/arrozk.png",
//     descricao: "Arroz branco tipo 1, pacote de 1kg.",
//   ),
// ];

// class ItemCarrinho {
//   final Produto produto;
//   int quantidade;
//   ItemCarrinho(this.produto, this.quantidade);
// }

// class CarrinhoController {
//   List<ItemCarrinho> itens = [];
//   void adicionar(Produto produto, {int quantidade = 1}) {
//     for (var item in itens) {
//       if (item.produto.id == produto.id) {
//         item.quantidade += quantidade;
//         return;
//       }
//     }
//     itens.add(
//       ItemCarrinho(produto, quantidade),
//     );
//   }

//   void remover(Produto produto) {
//     for (int i = 0; i < itens.length; i++) {
//       if (itens[i].produto.id == produto.id) {
//         if (itens[i].quantidade > 1) {
//           itens[i].quantidade--;
//         } else {
//           itens.removeAt(i);
//         }
//         return;
//       }
//     }
//   }

//   void removerItemCompleto(Produto produto) {
//     itens.removeWhere((item) => item.produto.id == produto.id);
//   }

//   double get subtotal {
//     double soma = 0;
//     for (var item in itens) {
//       soma += item.produto.preco * item.quantidade;
//     }
//     return soma;
//   }

//   int get totalItens {
//     int soma = 0;
//     for (var item in itens) {
//       soma += item.quantidade;
//     }
//     return soma;
//   }

//   void limpar() {
//     itens.clear();
//   }
// }

// final carrinho = CarrinhoController();
// final ValueNotifier<ThemeMode> temaNotifier = ValueNotifier(ThemeMode.light);

// final GoRouter router = GoRouter(
//   routes: [
//     GoRoute(path: '/', builder: (context, state) => const ComprasPage()),
//     GoRoute(
//       path: '/carrinho',
//       builder: (context, state) => const CarrinhoPage(),
//     ),
//     GoRoute(path: '/usuario', builder: (context, state) => const UsuarioPage()),
//     GoRoute(
//       path: '/produto/:index',

//       redirect: (context, state) {
//         final indexStr = state.pathParameters['index'];
//         final index = int.tryParse(indexStr ?? '');
//         if (index == null || index < 0 || index >= produtos.length) {
//           return '/';
//         }
//         return null;
//       },
//       builder: (context, state) {
//         final index = int.parse(state.pathParameters['index']!);
//         return ProdutoDetalhePage(index: index);
//       },
//     ),
//   ],
// );

// class MeuApp extends StatelessWidget {
//   const MeuApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ThemeMode>(
//       valueListenable: temaNotifier,
//       builder: (context, modo, _) {
//         return MaterialApp.router(
//           debugShowCheckedModeBanner: false,
//           title: "Mercadinho",
//           theme: ThemeData(
//             useMaterial3: true,
//             brightness: Brightness.light,
//             scaffoldBackgroundColor: Colors.grey[100],
//             colorSchemeSeed: Colors.deepPurple,
//             appBarTheme: const AppBarTheme(
//               backgroundColor: Colors.deepPurple,
//               foregroundColor: Colors.white,
//             ),
//           ),
//           darkTheme: ThemeData(
//             useMaterial3: true,
//             brightness: Brightness.dark,
//             colorSchemeSeed: Colors.deepPurple,
//             appBarTheme: const AppBarTheme(
//               backgroundColor: Color(0xFF1F1B24),
//               foregroundColor: Colors.white,
//             ),
//           ),
//           themeMode: modo,
//           routerConfig: router,
//         );
//       },
//     );
//   }
// }

// class ComprasPage extends StatefulWidget {
//   const ComprasPage({super.key});

//   @override
//   State<ComprasPage> createState() => _ComprasPageState();
// }

// class _ComprasPageState extends State<ComprasPage> {
//   bool carregando = true;
//   String busca = "";

//   @override
//   void initState() {
//     super.initState();
//     _iniciar();
//   }

//   Future<void> _iniciar() async {
//     final prefs = await SharedPreferences.getInstance();
//     final temaEscuro = prefs.getBool('tema_escuro') ?? false;
//     temaNotifier.value = temaEscuro ? ThemeMode.dark : ThemeMode.light;

//     final aberturas = (prefs.getInt('contador_aberturas') ?? 0) + 1;
//     await prefs.setInt('contador_aberturas', aberturas);

//     await Future.delayed(const Duration(milliseconds: 900));

//     if (mounted) setState(() => carregando = false);
//   }

//   List<Produto> get produtosFiltrados {
//     return produtos
//         .where((p) => p.nome.toLowerCase().contains(busca.toLowerCase())).toList();
//   }

//   void adicionarDaLista(Produto produto) {
//     carrinho.adicionar(produto);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("${produto.nome} adicionado ao carrinho!"),
//         duration: const Duration(seconds: 1),
//       ),
//     );
//   }

//   void sobreOApp() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Sobre o Mercadinho"),
//         content: const Text(
//           "App de compras feito com carrinho,"
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Fechar"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Mercadinho"),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: (valor) {
//               if (valor == "sobre") sobreOApp();
//               if (valor == "usuario") context.go("/usuario");
//             },
//             itemBuilder: (context) => const [
//               PopupMenuItem(value: "sobre", child: Text("Sobre o app")),
//               PopupMenuItem(value: "usuario", child: Text("Meu perfil")),
//             ],
//           ),
//         ],
//       ),

//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: Theme.of(context).primaryColor),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Icon(Icons.storefront, color: Colors.white, size: 36),
//                   SizedBox(height: 8),
//                   Text(
//                     "Mercadinho",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.store),
//               title: const Text("Compras"),
//               onTap: () => Navigator.pop(context),
//             ),
//             ListTile(
//               leading: const Icon(Icons.shopping_cart),
//               title: const Text("Carrinho"),
//               onTap: () {
//                 Navigator.pop(context);
//                 context.go("/carrinho");
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text("Meu Perfil"),
//               onTap: () {
//                 Navigator.pop(context);
//                 context.go("/usuario");
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.info_outline),
//               title: const Text("Sobre o app"),
//               onTap: () {
//                 Navigator.pop(context);
//                 sobreOApp();
//               },
//             ),
//           ],
//         ),
//       ),
//       body: carregando
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
//                   child: TextField(
//                     decoration: const InputDecoration(
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(),
//                       isDense: true,
//                     ),
//                     onChanged: (valor) => setState(() => busca = valor),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: produtosFiltrados.isEmpty
//                       ? const Center(child: Text("Nenhum produto encontrado."))
//                       : ListView.builder(
//                           padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//                           itemCount: produtosFiltrados.length,
//                           itemBuilder: (context, index) {
//                             final produto = produtosFiltrados[index];
//                             final indiceReal = produtos.indexOf(produto);

//                             return Card(
//                               margin: const EdgeInsets.only(bottom: 12),
//                               child: ListTile(
//                                 onTap: () =>
//                                     context.push("/produto/$indiceReal"),
//                                 contentPadding: const EdgeInsets.all(10),
//                                 leading: Image.asset(
//                                   produto.imagem,
//                                   width: 48,
//                                   height: 48,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 title: Text(
//                                   produto.nome,
//                                   style: const TextStyle(fontWeight: FontWeight.bold),
//                                 ),

//                                 subtitle: Text("R\$ ${produto.preco.toStringAsFixed(2)}"),

//                                 trailing: IconButton(
//                                   icon: const Icon(Icons.add),
//                                   color: Theme.of(context).colorScheme.primary,
//                                   onPressed: () => adicionarDaLista(produto),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0,
//         onTap: (index) {
//           if (index == 1) context.go("/carrinho");
//           if (index == 2) context.go("/usuario");
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.store), label: "Compras"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: "Carrinho",
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Usuário"),
//         ],
//       ),
//     );
//   }
// }
