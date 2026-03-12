import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/api_error.dart';
import 'models/cards.dart';

void main() {
  runApp(
    const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false),
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
  ApiError? _apiError;

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
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      final mapData = jsonDecode(response.body);


      if (response.statusCode == 200) {
        final List<dynamic> listaJson = mapData['data'];
        setState(() {
          _cartas = listaJson.map((json) => Cards.fromJson(json)).toList();
          _apiError = null;
          _isLoading = false;
        });
      } else {
        setState(() {
          _apiError = ApiError.fromJson(mapData, response.statusCode);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _apiError = ApiError(message: 'Falha de conexao: $e', statusCode: 0);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cartas - Yu-Gi-Oh!')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_apiError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            Text(
              _apiError.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _apiError = null;
                });
                _getCartasApi();
              },
              child: const Text(
                  'Tentar novamente'
              ),
            )
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: _cartas.length,
      itemBuilder: (context, index) {
        final carta = _cartas[index];
        return ListTile(
          title: Text(carta.name),
          subtitle: Text(carta.type),
        );
      },
    );
  }
}