// lib/models/sale_record.dart

class SaleRecord {
  final DateTime date;
  final int quantity;
  final double price; // This is total price
  final String eggType;

  SaleRecord({
    required this.date,
    required this.quantity,
    required this.price,
    required this.eggType,
  });
}
