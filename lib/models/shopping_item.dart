class ShoppingItem {
  final String id;
  final String name;
  final int quantity;
  final String? note;
  final DateTime date;
  bool isBought;
  final double? price;

  ShoppingItem({
    required this.id,
    required this.name,
    this.quantity = 1,
    this.note,
    required this.date,
    this.isBought = false,
    this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'note': note ?? '',
      'date': date.toIso8601String(),
      'isBought': isBought,
      'price': price,
    };
  }

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: json['name'] ?? 'Unknown Item',
      quantity: json['quantity'] ?? 1,
      note: json['note']?.isNotEmpty == true ? json['note'] : null,
      date: json['date'] != null 
          ? DateTime.parse(json['date'])
          : DateTime.now(),
      isBought: json['isBought'] ?? false,
      price: json['price']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() => toJson();
  factory ShoppingItem.fromMap(Map<String, dynamic> map) => ShoppingItem.fromJson(map);

  ShoppingItem copyWith({
    String? id,
    String? name,
    int? quantity,
    String? note,
    DateTime? date,
    bool? isBought,
    double? price,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
      date: date ?? this.date,
      isBought: isBought ?? this.isBought,
      price: price ?? this.price,
    );
  }
}