import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../mainsa2.dart';

class ProdutoDetalhePage extends StatefulWidget {
  final int index;

  const ProdutoDetalhePage({super.key, required this.index});

  @override
  State<ProdutoDetalhePage> createState() => _ProdutoDetalhePageState();
}

class _ProdutoDetalhePageState extends State<ProdutoDetalhePage> {
  int quantidade = 1;

  void aumentar() => setState(() => quantidade++);

  void diminuir() {
    if (quantidade > 1) setState(() => quantidade--);
  }

  void confirmarAdicao(Produto produto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Adicionar ao carrinho"),
          content: Text(
            "Adicionar $quantidade x ${produto.nome} "
            "(R\$ ${(produto.preco * quantidade).toStringAsFixed(2)})?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                carrinho.adicionar(produto, quantidade: quantidade);
                Navigator.pop(context);
                context.go("/carrinho");
              },
              child: const Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index < 0 || widget.index >= produtos.length) {
      return const Scaffold(
        body: Center(child: Text("Produto não encontrado.")),
      );
    }

    final produto = produtos[widget.index];

    return Scaffold(
      appBar: AppBar(title: Text(produto.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                produto.imagem,
                height: 160,
                width: 160,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              produto.nome,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "R\$ ${produto.preco.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Text(
              produto.descricao,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: diminuir,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text("$quantidade", style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: aumentar,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => confirmarAdicao(produto),
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Adicionar ao carrinho"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
