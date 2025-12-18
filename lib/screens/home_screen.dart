import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shopping_item.dart';
import '../providers/shopping_provider.dart';
import 'add_item_screen.dart';
import 'stats_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';
import '../widgets/shopping_item_card.dart';
import '../widgets/empty_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = Provider.of<ShoppingProvider>(context, listen: false);
    await provider.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpendList - Daftar Belanja'),
        actions: [
  IconButton(
    icon: const Icon(Icons.bar_chart),
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StatsScreen()),
    ),
  ),
  IconButton(
    icon: const Icon(Icons.info_outline),
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AboutScreen()),
    ),
  ),
  IconButton(
    icon: const Icon(Icons.settings),
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    ),
  ),
],

      ),
      body: Consumer<ShoppingProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${provider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadData,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              _buildStatsHeader(context, provider),
              _buildFilterToggle(context, provider),
              Expanded(
                child: provider.filteredItems.isEmpty
                    ? EmptyState(
                        icon: Icons.shopping_cart_outlined,
                        title: provider.showBoughtOnly
                            ? 'Tidak ada item yang sudah dibeli'
                            : 'Daftar belanja kosong',
                        subtitle: provider.showBoughtOnly
                            ? 'Belum ada item yang ditandai selesai'
                            : 'Tambahkan item pertama Anda',
                      )
                    : RefreshIndicator(
                        onRefresh: _loadData,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: provider.filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = provider.filteredItems[index];
                            return ShoppingItemCard(
                              item: item,
                              onToggle: () => _toggleItem(provider, item.id),
                              onDelete: () => _deleteItem(provider, item),
                              onEdit: () => _editItem(context, provider, item),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItem(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatsHeader(BuildContext context, ShoppingProvider provider) {
    final totalPrice = provider.totalPrice;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total: ${provider.totalItems} item',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      label: Text('${provider.notBoughtCount} Belum'),
                      backgroundColor: Colors.orange.withOpacity(0.2),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('${provider.boughtCount} Selesai'),
                      backgroundColor: Colors.green.withOpacity(0.2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (totalPrice > 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Total Harga', style: TextStyle(fontSize: 12)),
                Text(
                  'Rp ${totalPrice.toInt()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildFilterToggle(BuildContext context, ShoppingProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Switch(
            value: provider.showBoughtOnly,
            onChanged: (_) => provider.toggleShowBoughtOnly(),
          ),
          const Text('Tampilkan hanya yang selesai'),
          const Spacer(),
          if (provider.showBoughtOnly)
            TextButton(
              onPressed: () => provider.toggleShowBoughtOnly(),
              child: const Text('Tampilkan Semua'),
            ),
        ],
      ),
    );
  }

  Future<void> _addItem(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddItemScreen()),
    );

    if (result == true) {
      _showSnackBar('✅ Item berhasil ditambahkan');
    }
  }

  Future<void> _editItem(BuildContext context, ShoppingProvider provider,
      ShoppingItem item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddItemScreen(item: item),
      ),
    );

    if (result == true) {
      _showSnackBar('✏️ Item berhasil diperbarui');
    }
  }

  Future<void> _toggleItem(ShoppingProvider provider, String id) async {
    try {
      await provider.toggleBought(id);
    } catch (e) {
      _showSnackBar('❌ Gagal mengubah status: $e');
    }
  }

  Future<void> _deleteItem(ShoppingProvider provider, ShoppingItem item) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Item'),
        content: Text('Yakin hapus "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await provider.deleteItem(item.id);
                Navigator.pop(context);
                _showSnackBar('🗑️ Item dihapus');
              } catch (e) {
                Navigator.pop(context);
                _showSnackBar('❌ Gagal menghapus: $e');
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
