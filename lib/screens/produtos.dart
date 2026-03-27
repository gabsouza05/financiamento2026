import 'package:flutter/material.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  double valor = 0;
  double juros = 0;
  int parcelas = 0;
  double taxas = 0;

  double valorParcela = 0;
  double valorTotal = 0;

  void calcular() {
    if (parcelas == 0) return;

    double taxa = juros / 100;
    double jurosTotal = valor * taxa * parcelas;

    valorTotal = valor + jurosTotal + taxas;
    valorParcela = valorTotal / parcelas;

    setState(() {});
  }

  void mostrarResultado() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF6A040F),
        title: const Text(
          "Resultado",
          style: TextStyle(color: Color(0xFFFDC500)),
        ),
        content: Text(
          "Total: R\$ ${valorTotal.toStringAsFixed(2)}\n"
          "Parcela: R\$ ${valorParcela.toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "OK",
              style: TextStyle(color: Color(0xFFD90429)),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration campo(String texto) {
    return InputDecoration(
      labelText: texto,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFD90429)),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFFDC500), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A040F),
      appBar: AppBar(
        title: const Text("Simulador"),
        backgroundColor: const Color(0xFFD90429),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: campo("Valor do financiamento"),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (v) => valor = double.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: campo("Taxa de juros (%)"),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (v) => juros = double.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: campo("Número de parcelas"),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (v) => parcelas = int.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: campo("Taxas adicionais"),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (v) => taxas = double.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                calcular();
                mostrarResultado();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD90429),
                foregroundColor: Colors.white,
              ),
              child: const Text("Calcular"),
            ),
          ],
        ),
      ),
    );
  }
}
