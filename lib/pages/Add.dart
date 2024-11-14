import 'package:aplikasi_sederhana_to_do_list/Components/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provider/provider.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _selectedType = 'Pengeluaran';

  get tanggal => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Data'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: _judulController,
                    decoration: const InputDecoration(labelText: 'Judul'),
                    validator: (value) {
                      if (value!.isEmpty) return;
                      return null;
                    }),
                ElevatedButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2100, 12, 31),
                      onConfirm: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                      currentTime: DateTime.now(),
                    );
                  },
                  child: const Text('Pilih tanggal'),
                ),
                TextFormField(
                  controller: _hargaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'harga'),
                  validator: (value) {
                    if (value!.isEmpty) ;
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  value: _selectedType,
                  items: ['Pengeluaran', 'Pemasukan']
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<KeuanganProvider>(context, listen: false)
                          .addTransaction(
                        Keuangan(
                          judul: _judulController.text,
                          tanggal: _selectedDate,
                          harga: int.parse(_hargaController.text),
                          type: _selectedType,
                        ),
                      );
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/Home');
                    }
                  },
                  child: Text('Submit'), // Don't forget to add a child widget
                ),
              ],
            ),
          ),
        ));
  }
}
