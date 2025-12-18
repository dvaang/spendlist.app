import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/shopping_item.dart';

class StorageService {
  static const String _itemsKey = 'shopping_items';

  Future<List<ShoppingItem>> loadItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? itemsJson = prefs.getString(_itemsKey);
      
      if (itemsJson == null || itemsJson.isEmpty) {
        return [];
      }
      
      final List<dynamic> jsonList = json.decode(itemsJson);
      return jsonList.map((item) => ShoppingItem.fromMap(item)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveItems(List<ShoppingItem> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> maps = items.map((item) => item.toMap()).toList();
      final String itemsJson = json.encode(maps);
      await prefs.setString(_itemsKey, itemsJson);
    } catch (e) {
      throw Exception('Gagal menyimpan data');
    }
  }

  Future<void> clearAllItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_itemsKey);
    } catch (e) {
      throw Exception('Gagal menghapus data');
    }
  }

  Future<String> exportData(List<ShoppingItem> items) async {
    try {
      final List<Map<String, dynamic>> maps = items.map((item) => item.toMap()).toList();
      return json.encode({
        'version': '1.0',
        'created_at': DateTime.now().toIso8601String(),
        'total_items': items.length,
        'data': maps,
      });
    } catch (e) {
      throw Exception('Gagal mengekspor data');
    }
  }

  Future<List<ShoppingItem>> importData(String jsonData) async {
    try {
      final Map<String, dynamic> data = json.decode(jsonData);
      final List<dynamic> jsonList = data['data'] as List<dynamic>;
      return jsonList.map((item) => ShoppingItem.fromMap(item)).toList();
    } on FormatException {
      throw Exception('Format JSON tidak valid');
    } catch (e) {
      throw Exception('Gagal mengimpor data: $e');
    }
  }
}