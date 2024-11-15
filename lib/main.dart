import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_sederhana_to_do_list/Components/record.dart';
import 'package:aplikasi_sederhana_to_do_list/pages/homepage.dart';
import 'package:aplikasi_sederhana_to_do_list/pages/add.dart';
import 'package:aplikasi_sederhana_to_do_list/pages/editform.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => KeuanganProvider(), // Ensure correct provider type
      child: MaterialApp(
        home: const Homepage(),
        routes: {
          '/Home': (context) => const Homepage(),
          '/Add': (context) => const Add(),
          '/EditForm': (context) => EditForm(
                transaction:
                    ModalRoute.of(context)?.settings.arguments as Keuangan,
              ),
        },
      ),
    ),
  );
}
