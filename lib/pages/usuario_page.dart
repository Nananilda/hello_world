import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final TextEditingController nomeController =
      TextEditingController(text: "Anna Hilda");
  
  final TextEditingController emailController =
      TextEditingController(text: "anna.frezarini@aluno.senai.br");

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void salvar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Dados salvos com sucesso!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text("Meu Perfil"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.deepPurple,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "E-mail",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: salvar,
                child: const Text("Salvar"),
              ),
            ),
            const SizedBox(height: 25),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Endereço"),
                subtitle: const Text("Rua das Bobos, 0"),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Telefone"),
                subtitle: const Text("(19)4002-8922"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            context.go("/");
          }

          if (index == 1) {
            context.go("/carrinho");
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
