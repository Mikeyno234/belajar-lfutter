import 'package:flutter/material.dart';

class Keuangan {
  final String id;
  final String judul;
  final DateTime tanggal;
  final int harga;
  final String type;

  Keuangan({
    required this.judul,
    required this.tanggal,
    required this.harga,
    required this.type,
    required this.id,
  });

  void addTransaction(Keuangan keuangan) {}
}

class KeuanganProvider with ChangeNotifier {
  final _transactions = <Keuangan>[];

  List<Keuangan> get transactions => _transactions;

  bool? get isLoading => null;

  void addTransaction(Keuangan transaction) {
    _transactions.add(transaction);
    notifyListeners(); // Notify listeners tentang perubahan data
  }

  Stream<List<Keuangan>> getTransactions() {
    return Stream.value(
        _transactions); // Simulasi data statis, ganti dengan data dari database atau API
  }

  Future<bool> updateTransaction(Keuangan updatedTransaction) async {
    final index = _transactions
        .indexWhere((transaction) => transaction.id == updatedTransaction.id);

    if (index != -1) {
      _transactions[index] = updatedTransaction;

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteTransaction(String id) async {
    final index =
        _transactions.indexWhere((transaction) => transaction.id == id);

    if (index != -1) {
      _transactions.removeAt(index);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
