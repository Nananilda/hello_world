import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../mainsa2.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  bool finalizando = false;

  double calcularTotal() {
    return carrinho.subtotal;
  }

  void aumentarQuantidade(Produto produto) {
    setState(() {
      carrinho.adicionar(produto);
    });
  }

  void diminuirQuantidade(Produto produto) {
    setState(() {
      carrinho.remover(produto);
    });
  }

  void removerProduto(Produto produto) {
    setState(() {
      carrinho.removerItemCompleto(produto);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produto removido do carrinho.")),
    );
  }

  void limparCarrinho() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Limpar Carrinho"),
          content: const Text("Deseja remover todos os produtos?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() => carrinho.limpar());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Carrinho esvaziado.")),
                );
              },
              child: const Text("Limpar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> finalizarCompra() async {
    if (carrinho.itens.isEmpty) return;

    setState(() => finalizando = true);

    await Future.delayed(const Duration(milliseconds: 1200));

    final totalCompra = calcularTotal();
    final nomes = carrinho.itens.map((item) => item.produto.nome).toList();

    final prefs = await SharedPreferences.getInstance();
    final totalAnterior = prefs.getDouble('total_gasto') ?? 0.0;
    await prefs.setDouble('total_gasto', totalAnterior + totalCompra);

    final historico = prefs.getStringList('ultimas_compras') ?? [];
    historico.insertAll(0, nomes);
    await prefs.setStringList('ultimas_compras', historico.take(6).toList());

    setState(() {
      carrinho.limpar();
      finalizando = false;
    });

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Compra finalizada!"),
        content: Text(
          "Total da compra: R\$ ${totalCompra.toStringAsFixed(2)}.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Carrinho"),
        actions: [
          IconButton(onPressed: limparCarrinho, icon: const Icon(Icons.delete)),
        ],
      ),
      body: carrinho.itens.isEmpty
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
                    itemCount: carrinho.itens.length,
                    itemBuilder: (context, index) {
                      final item = carrinho.itens[index];
                      final subtotalItem = item.produto.preco * item.quantidade;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item.produto.imagem,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.produto.nome,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "R\$ ${item.produto.preco.toStringAsFixed(2)} × ${item.quantidade} = "
                                      "R\$ ${subtotalItem.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                        ),
                                        onPressed: () =>
                                            diminuirQuantidade(item.produto),
                                      ),
                                      Text(
                                        "${item.quantidade}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                        ),
                                        onPressed: () =>
                                            aumentarQuantidade(item.produto),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        removerProduto(item.produto),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
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
                          onPressed: finalizando ? null : finalizarCompra,
                          child: finalizando
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text("Finalizar Compra"),
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
          if (index == 0) context.go("/");
          if (index == 2) context.go("/usuario");
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
