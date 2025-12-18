import 'package:flutter/material.dart';
import '../models/shopping_item.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class ShoppingProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  
  List<ShoppingItem> _items = [];
  bool _isLoading = false;
  String _error = '';
  bool _showBoughtOnly = false;

  List<ShoppingItem> get items => _items;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get showBoughtOnly => _showBoughtOnly;

  Future<void> loadItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final List<ShoppingItem> localItems = await _storageService.loadItems();
      
      if (localItems.isNotEmpty) {
        _items = localItems;
        _error = '';
      } else {
        final List<ShoppingItem> apiItems = await _apiService.fetchShoppingItems();
        _items = apiItems;
        await _storageService.saveItems(apiItems);
        _error = '';
      }
      
      _items.sort((a, b) => b.date.compareTo(a.date));
      
    } catch (e) {
      _error = 'Gagal memuat data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(ShoppingItem item) async {
    try {
      _items.insert(0, item);
      await _storageService.saveItems(_items);
      notifyListeners();
    } catch (e) {
      throw Exception('Gagal menambah item: $e');
    }
  }

  Future<void> updateItem(ShoppingItem item) async {
    try {
      final index = _items.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        _items[index] = item;
        await _storageService.saveItems(_items);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Gagal mengupdate item: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      _items.removeWhere((item) => item.id == id);
      await _storageService.saveItems(_items);
      notifyListeners();
    } catch (e) {
      throw Exception('Gagal menghapus item: $e');
    }
  }

  Future<void> toggleBought(String id) async {
    try {
      final index = _items.indexWhere((item) => item.id == id);
      if (index != -1) {
        final item = _items[index];
        _items[index] = item.copyWith(isBought: !item.isBought);
        await _storageService.saveItems(_items);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Gagal mengubah status: $e');
    }
  }

  Future<void> clearAllItems() async {
    try {
      _items.clear();
      await _storageService.clearAllItems();
      notifyListeners();
    } catch (e) {
      throw Exception('Gagal menghapus semua item: $e');
    }
  }

  void toggleShowBoughtOnly() {
    _showBoughtOnly = !_showBoughtOnly;
    notifyListeners();
  }

  List<ShoppingItem> get filteredItems {
    if (_showBoughtOnly) {
      return _items.where((item) => item.isBought).toList();
    }
    return _items;
  }

  List<ShoppingItem> get boughtItems => _items.where((item) => item.isBought).toList();
  List<ShoppingItem> get notBoughtItems => _items.where((item) => !item.isBought).toList();
  
  int get totalItems => _items.length;
  int get boughtCount => boughtItems.length;
  int get notBoughtCount => notBoughtItems.length;

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + (item.price ?? 0) * item.quantity);
  }

  Future<String> exportData() async {
    try {
      return await _storageService.exportData(_items);
    } catch (e) {
      throw Exception('Gagal mengekspor data: $e');
    }
  }

  Future<void> importData(String jsonData) async {
    try {
      final items = await _storageService.importData(jsonData);
      _items = items;
      await _storageService.saveItems(_items);
      notifyListeners();
    } catch (e) {
      throw Exception('Gagal mengimpor data: $e');
    }
  }
}