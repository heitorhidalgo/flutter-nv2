import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _getCartasApi();
  }

  Future<void> _getCartasApi() async {
    final url = Uri.parse('https://db.ygoprodeck.com/api/v7/cardinfo.php?staple=yes');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Sucesso! Resposta recebida.');
        debugPrint('${response.body.substring(0, 500)}...');
      } else {
        debugPrint('Erro na requisição: Código ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro de conexão: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Primeiro Request - Yu-Gi-Oh!')),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}