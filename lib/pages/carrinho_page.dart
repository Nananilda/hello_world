import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  double calcularTotal() {
    double total = 0;

    for (var produto in carrinho) {
      total += produto["preco"];
    }

    return total;
  }

  void removerProduto(int index) {
    setState(() {
      carrinho.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Produto removido do carrinho."),
      ),
    );
  }

  void limparCarrinho() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Limpar Carrinho"),
          content: const Text(
            "Deseja remover todos os produtos?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  carrinho.clear();
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Carrinho esvaziado."),
                  ),
                );
              },
              child: const Text("Limpar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text("Meu Carrinho"),
        actions: [
          IconButton(
            onPressed: limparCarrinho,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: carrinho.isEmpty
          ? const Center(
              child: Text(
                "Seu carrinho está vazio.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: carrinho.length,
                    itemBuilder: (context, index) {
                      final produto = carrinho[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: const Icon(
                            Icons.shopping_basket,
                            color: Colors.deepPurple,
                          ),
                          title: Text(produto["nome"]),
                          subtitle: Text(
                            "R\$ ${produto["preco"].toStringAsFixed(2)}",
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () {
                              removerProduto(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Total: R\$ ${calcularTotal().toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Compra finalizada!"),
                              ),
                            );
                          },
                          child: const Text("Finalizar Compra"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            context.go("/");
          }

          if (index == 2) {
            context.go("/usuario");
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Compras",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Carrinho",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Usuário",
          ),
        ],
      ),
    );
  }
}
