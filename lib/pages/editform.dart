import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_sederhana_to_do_list/Components/record.dart';

class EditForm extends StatefulWidget {
  final Keuangan transaction;

  const EditForm({super.key, required this.transaction});

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulController;
  late DateTime _selectedDate;
  late TextEditingController _hargaController;
  late String _selectedType;

  @override
  void initState() {
    super.initState();

    // Initialize form fields with existing transaction values
    _judulController = TextEditingController(text: widget.transaction.judul);
    _selectedDate = widget.transaction.tanggal;
    _hargaController =
        TextEditingController(text: widget.transaction.harga.toString());
    _selectedType = widget.transaction.type;
  }

  @override
  void dispose() {
    _judulController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  hintText: 'Masukkan judul transaksi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Tanggal: ', style: TextStyle(fontSize: 16.0)),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      '${_selectedDate.toIso8601String().split('T')[0]}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  hintText: 'Masukkan jumlah harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  } else if (int.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: InputDecoration(
                  labelText: 'Tipe Transaksi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Pengeluaran',
                    child: Text('Pengeluaran'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Pemasukan',
                    child: Text('Pemasukan'),
                  ),
                ],
                onChanged: (value) => setState(() => _selectedType = value!),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Update the transaction
                        final updatedTransaction = Keuangan(
                          id: widget.transaction.id,
                          judul: _judulController.text,
                          tanggal: _selectedDate,
                          harga: int.parse(_hargaController.text),
                          type: _selectedType,
                        );

                        // Use Provider to update the transaction in the state
                        Provider.of<KeuanganProvider>(context, listen: false)
                            .updateTransaction(updatedTransaction);

                        // After updating, navigate back to the previous screen
                        Navigator.pop(
                            context); // This will pop the current screen from the stack
                      }
                    },
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text(
                                'Apakah Anda yakin ingin menghapus transaksi ini?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Tidak'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Delete the transaction and close the dialog
                                  Provider.of<KeuanganProvider>(context,
                                          listen: false)
                                      .deleteTransaction(widget.transaction.id);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  Navigator.pop(
                                      context); // Go back to the previous screen
                                },
                                child: const Text('Ya'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red, // Custom color for delete button
                    ),
                    child: const Text('Hapus'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
