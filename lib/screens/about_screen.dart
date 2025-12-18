import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'SpendList',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Aplikasi Catatan Belanja Harian',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 32),
            Text(
              'Dibuat untuk memenuhi UAS Pemrograman Mobile',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 12),
            Text('Nama : Diva Angelina'),
            Text('NIM  : 701230051'),
            Text('Kelas: 5C Sistem Informasi'),
            SizedBox(height: 20),
            Text(
              'Fitur Aplikasi:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Manajemen daftar belanja'),
            Text('• CRUD data belanja'),
            Text('• Sinkronisasi API & Local Storage'),
            Text('• Dark & Light Mode'),
            Text('• Statistik belanja'),
          ],
        ),
      ),
    );
  }
}
