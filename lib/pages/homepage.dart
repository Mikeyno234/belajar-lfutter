import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_sederhana_to_do_list/Components/record.dart'; // Make sure the path is correct for your project

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Catatan Keuangan')),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(width: 16.0),
            Expanded(
              child: Consumer<KeuanganProvider>(
                builder: (context, keuanganProvider, _) {
                  final transactions = keuanganProvider.transactions;

                  if (transactions.isEmpty) {
                    return const Center(
                      child: Text('Belum ada data transaksi'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        final color = transaction.type == 'Pengeluaran'
                            ? Colors.red
                            : Colors.green;

                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/EditForm',
                              arguments: transaction,
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(transaction.judul),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          DateFormat('y MMMM d')
                                              .format(transaction.tanggal),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Rp ${transaction.harga.toString()}',
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/Add'),
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/Home'),
                icon: const Icon(Icons.home),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {}, // Implement action for Settings
                icon: const Icon(Icons.settings),
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
