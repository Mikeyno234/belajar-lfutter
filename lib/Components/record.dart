import 'package:flutter/material.dart';

class Keuangan {
  final String judul;
  final DateTime tanggal;
  final int harga;
  final String type;

  Keuangan({
    required this.judul,
    required this.tanggal,
    required this.harga,
    required this.type,
  });

  void addTransaction(Keuangan keuangan) {}
}

class KeuanganProvider with ChangeNotifier {
  final _transactions = <Keuangan>[];

  List<Keuangan> get transactions => _transactions;

  bool? get isLoading => null;

  void addTransaction(Keuangan transaction) {
    _transactions.add(transaction);
    notifyListeners(); // Notify listeners about the data change
  }

  Stream<List<Keuangan>> getTransactions() {
    return Stream.value(
        _transactions); // Simulasi data statis, ganti dengan data dari database atau API
  }
}
