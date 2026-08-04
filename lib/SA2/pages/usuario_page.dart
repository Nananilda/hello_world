import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../mainsa2.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool temaEscuro = false;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  Future<void> _carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    nomeController.text = prefs.getString('nome_usuario') ?? "Anna Hilda";
    emailController.text =
        prefs.getString('email_usuario') ?? "anna.frezarini@aluno.senai.br";

    setState(() {
      temaEscuro = prefs.getBool('tema_escuro') ?? false;
      carregando = false;
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void alternarTema(bool valor) async {
    setState(() => temaEscuro = valor);
    temaNotifier.value = valor ? ThemeMode.dark : ThemeMode.light;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tema_escuro', valor);
  }

  Future<void> salvar() async {
    if (nomeController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Campos obrigatórios"),
          content: const Text("Preencha nome e e-mail antes de salvar."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    if (!emailController.text.contains("@")) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("E-mail inválido"),
          content: const Text("Digite um e-mail válido."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome_usuario', nomeController.text.trim());
    await prefs.setString('email_usuario', emailController.text.trim());

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Dados salvos com sucesso!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Perfil"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (valor) {
              if (valor == "compras") context.go("/");
              if (valor == "carrinho") context.go("/carrinho");
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "compras", child: Text("Ir para Compras")),
              PopupMenuItem(value: "carrinho", child: Text("Ir para Carrinho")),
            ],
          ),
        ],
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.person, color: Colors.white, size: 50),
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
                    child: SwitchListTile(
                      secondary: const Icon(Icons.dark_mode),
                      title: const Text("Tema escuro"),
                      value: temaEscuro,
                      onChanged: alternarTema,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      subtitle: const Text("(19) 4002-8922"),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) context.go("/");
          if (index == 1) context.go("/carrinho");
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
