import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/sale_record.dart';
import 'package:intl/intl.dart';

class SalesScreen extends StatefulWidget {
  final double totalSales;
  final Function(double) onUpdateTotalSales;
  final Function(SaleRecord) onRecordSale;

  const SalesScreen({
    super.key,
    required this.totalSales,
    required this.onUpdateTotalSales,
    required this.onRecordSale,
  });

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedEggType = 'Small';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final quantity = int.tryParse(_quantityController.text) ?? 0;
      final pricePerPiece = double.tryParse(_priceController.text) ?? 0.0;
      final totalPrice = quantity * pricePerPiece;

      widget.onUpdateTotalSales(widget.totalSales + totalPrice);

      final record = SaleRecord(
        date: _selectedDate,
        quantity: quantity,
        price: totalPrice,
        eggType: _selectedEggType,
      );

      widget.onRecordSale(record);

      _quantityController.clear();
      _priceController.clear();
    }
  }

  void _clearSales() {
    widget.onUpdateTotalSales(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // TITLE CARD
        Card(
          color: const Color(0xFF2E3D2F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // SALES TOTAL CARD
        Stack(
          children: [
            Card(
              color: const Color(0xFFF4CE8F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.white, size: 40),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Today\'s Sales', style: TextStyle(color: Colors.white, fontSize: 18)),
                        Text('₱${widget.totalSales.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: TextButton(
                onPressed: _clearSales,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Clear', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // FORM CARD
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Record Daily Sales',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) setState(() => _selectedDate = date);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Sale Date',
                          filled: true,
                          fillColor: const Color(0xFFEFF7EE),
                        ),
                        controller: TextEditingController(
                          text: DateFormat('yyyy-MM-dd').format(_selectedDate),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedEggType,
                    onChanged: (val) => setState(() => _selectedEggType = val!),
                    items: ['Small', 'Medium', 'Large']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    decoration: const InputDecoration(
                      labelText: 'Egg Type',
                      filled: true,
                      fillColor: Color(0xFFEFF7EE),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      filled: true,
                      fillColor: Color(0xFFEFF7EE),
                    ),
                    validator: (value) =>
                        (value == null || value.isEmpty) ? 'Enter quantity' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Price per Piece',
                      filled: true,
                      fillColor: Color(0xFFEFF7EE),
                    ),
                    validator: (value) =>
                        (value == null || value.isEmpty) ? 'Enter price' : null,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCB9559),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
