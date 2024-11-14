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
  final List<Keuangan> _transactions = [];

  List<Keuangan> get transactions => _transactions;

  bool? get isLoading => null;

  void addTransaction(Keuangan transaction) {
    _transactions.add(transaction);

    notifyListeners();
  }
}
