import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_sederhana_to_do_list/Components/record.dart'; // Import Keuangan and KeuanganProvider

class Homepage extends StatelessWidget {
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
              child: StreamProvider<List<Keuangan>>(
                  // Use StreamProvider for data updates
                  create: (context) =>
                      Provider.of<KeuanganProvider>(context, listen: false)
                          .getTransactions(),
                  initialData: const [],
                  builder: (context, snapshot) {
                    final transactions = snapshot?.data?.toList() ??
                        []; // Handle potential null data

                    if (transactions.isEmpty) {
                      return const Center(
                          child: Text('Belum ada data transaksi'));
                    } else {
                      return ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          final color = transaction.type == 'Pengeluaran'
                              ? Colors.red
                              : Colors.green;

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Align title to left
                                      children: [
                                        Text(transaction.judul),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          DateFormat('y MMMM d')
                                              .format(transaction.tanggal),
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey),
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
                          );
                        },
                      );
                    }
                  }),
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
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/EditForm'),
                icon: const Icon(Icons.info),
              ),
              label: 'Info',
            ),
          ],
        ),
      ),
    );
  }
}

extension on Widget? {
  get data => null;
}
