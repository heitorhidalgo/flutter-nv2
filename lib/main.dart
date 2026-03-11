import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/cards.dart';

void main() {
  runApp(
    const MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cards> _cartas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCartasApi();
  }

  Future<void> _getCartasApi() async {
    final url = Uri.parse(
      'https://db.ygoprodeck.com/api/v7/cardinfo.php?staple=yes',
    );
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final mapData = jsonDecode(response.body);
        final List<dynamic> listaJson = mapData['data'];

        setState(() {
          _cartas = listaJson.map((json) => Cards.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      debugPrint('Erro: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cartas - Yu-Gi-Oh!')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cartas.length,
              itemBuilder: (context, index) {
                final carta = _cartas[index];
                return ListTile(
                  title: Text(carta.name),
                  subtitle: Text(carta.type),
                );
              },
            ),
    );
  }
}
