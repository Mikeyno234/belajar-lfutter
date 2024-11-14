import 'package:aplikasi_sederhana_to_do_list/Components/record.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final keuanganProvider = Provider.of<KeuanganProvider>(context);

    // Handle loading state (optional)
    if (keuanganProvider.isLoading ?? false) {
      return Center(child: CircularProgressIndicator());
    } else if (keuanganProvider.transactions.isEmpty) {
      return Center(child: Text('Tidak ada data transaksi'));
    }

    // Display list of transactions
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Keuangan'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: keuanganProvider.transactions.length,
        itemBuilder: (context, index) {
          final transaction = keuanganProvider.transactions[index];
          // Display each transaction details (e.g., title, date, price, type)
          return ListTile(
            title: Text(transaction.judul),
            subtitle: Row(
              children: [
                Text(transaction.tanggal.toString()),
                Spacer(),
                Text(transaction.type == 'Pengeluaran'
                    ? '- Rp. ${transaction.harga}'
                    : 'Rp. ${transaction.harga}'),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/Add');
          },
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
                onPressed: () {},
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
                onPressed: () {
                  Navigator.pushNamed(context, '/EditForm');
                },
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
