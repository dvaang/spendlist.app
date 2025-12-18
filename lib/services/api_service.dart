import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shopping_item.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<ShoppingItem>> fetchShoppingItems() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final response = await http.get(
        Uri.parse('$_baseUrl/todos?_limit=8'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        
        final List<String> itemNames = [
          'Susu UHT', 'Roti Tawar', 'Telur Ayam', 'Minyak Goreng',
          'Gula Pasir', 'Kopi Bubuk', 'Teh Celup', 'Sabun Mandi',
          'Shampoo', 'Pasta Gigi', 'Beras 5kg', 'Mie Instan'
        ];

        return data.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          
          return ShoppingItem(
            id: 'api_${item['id']}',
            name: itemNames[index % itemNames.length],
            quantity: (item['id'] % 3) + 1,
            note: item['completed'] ? 'Sudah dibeli' : 'Belum dibeli',
            date: DateTime.now().subtract(Duration(days: item['id'])),
            isBought: item['completed'] ?? false,
            price: (item['id'] * 2500).toDouble(),
          );
        }).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}