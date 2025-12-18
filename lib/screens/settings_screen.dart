import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shopping_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _exportController = TextEditingController();
  bool _isExporting = false;

  @override
  void dispose() {
    _exportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final shoppingProvider = Provider.of<ShoppingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tampilan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.brightness_4),
                    title: const Text('Mode Tema'),
                    trailing: DropdownButton<ThemeMode>(
                      value: themeProvider.themeMode,
                      items: const [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('Sistem'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text('Terang'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text('Gelap'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          themeProvider.setThemeMode(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading:
                        const Icon(Icons.delete_outline, color: Colors.red),
                    title: const Text('Hapus Semua Data'),
                    subtitle: const Text('Menghapus semua daftar belanja'),
                    onTap: () =>
                        _showClearDataDialog(context, shoppingProvider),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.backup, color: Colors.blue),
                    title: const Text('Ekspor Data'),
                    subtitle: const Text('Simpan data ke clipboard'),
                    onTap: () => _exportData(context, shoppingProvider),
                  ),
                  if (_isExporting)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: LinearProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tentang',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Versi'),
                    subtitle: const Text('1.0.0'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.assignment),
                    title: const Text('SpendList'),
                    subtitle: const Text('Aplikasi Daftar Belanja'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.code),
                    title: const Text('UAS Pemrograman Mobile'),
                    subtitle: const Text('Kelas 5C'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showClearDataDialog(
      BuildContext context, ShoppingProvider provider) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Semua Data'),
        content: const Text('Yakin ingin menghapus semua daftar belanja?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await provider.clearAllItems();
                _showSnackBar(context, '✅ Semua data telah dihapus');
              } catch (e) {
                _showSnackBar(context, '❌ Gagal menghapus: $e');
              }
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportData(
      BuildContext context, ShoppingProvider provider) async {
    setState(() => _isExporting = true);

    try {
      final jsonData = await provider.exportData();
      _exportController.text = jsonData;

      _showSnackBar(context, '✅ Data berhasil disalin ke clipboard');
    } catch (e) {
      _showSnackBar(context, '❌ Gagal mengekspor: $e');
    } finally {
      setState(() => _isExporting = false);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
