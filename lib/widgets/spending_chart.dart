import 'package:flutter/material.dart';
import '../models/shopping_item.dart';

class ShoppingChart extends StatelessWidget {
  final List<ShoppingItem> items;

  const ShoppingChart({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Belum ada data untuk ditampilkan',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    final grouped = _prepareData();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Perkiraan pengeluaran per item',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...grouped.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Expanded(child: Text(e['name'] as String)),
                      Text('Rp ${(e['total'] as double).toInt()}',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  List<Map<String, Object>> _prepareData() {
    final Map<String, double> totals = {};
    for (final item in items) {
      final total = (item.price ?? 0) * item.quantity;
      totals.update(item.name, (v) => v + total, ifAbsent: () => total);
    }
    return totals.entries
        .map((e) => {'name': e.key, 'total': e.value})
        .toList();
  }
}
