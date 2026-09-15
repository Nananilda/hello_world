import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/audio/main_audio.dart';

class ProdutoPage extends StatelessWidget {
  final Frutinha produto;

  const ProdutoPage({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.nome),
        backgroundColor: const Color(0xFF4A7C59),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        // ACRESCENTADO: Ícone do carrinho na AppBar
        actions: [
          ListenableBuilder(
            listenable: carrinho,
            builder: (context, _) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () => context.push('/carrinho'),
                  ),
                  if (carrinho.totalItens > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${carrinho.totalItens}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(produto.emoji, style: const TextStyle(fontSize: 100)),
            ),
            const SizedBox(height: 24),
            Text(
              produto.nome,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              produto.nomeCientifico,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'R\$ ${produto.preco.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                color: Color(0xFF4A7C59),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(produto.descricao, style: const TextStyle(fontSize: 15)),
            const Spacer(),
            
            // ACRESCENTADO: DOIS BOTÕES
            Column(
              children: [
                // Botão 1: Adicionar ao Carrinho
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      carrinho.adicionar(produto);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${produto.nome} adicionado ao carrinho!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Adicionar ao Carrinho'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A7C59),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Botão 2: Ir para o Carrinho (ACRESCENTADO)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/carrinho'),
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Ver Carrinho'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4A7C59),
                      side: const BorderSide(color: Color(0xFF4A7C59)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}