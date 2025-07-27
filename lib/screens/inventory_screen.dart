import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryScreen extends StatefulWidget {
  final int smallEggs;
  final int mediumEggs;
  final int largeEggs;
  final void Function(String type, int quantity, String action) onUpdateInventory;

  const InventoryScreen({
    super.key,
    required this.smallEggs,
    required this.mediumEggs,
    required this.largeEggs,
    required this.onUpdateInventory,
  });

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String selectedType = 'Large';
  String action = 'Add to stock';
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  void clearCounts() {
    widget.onUpdateInventory('Small', 0 - widget.smallEggs, 'Remove from current stock');
    widget.onUpdateInventory('Medium', 0 - widget.mediumEggs, 'Remove from current stock');
    widget.onUpdateInventory('Large', 0 - widget.largeEggs, 'Remove from current stock');
  }

  @override
  Widget build(BuildContext context) {
    int currentCount = selectedType == 'Small'
        ? widget.smallEggs
        : selectedType == 'Medium'
            ? widget.mediumEggs
            : widget.largeEggs;

    int total = widget.smallEggs + widget.mediumEggs + widget.largeEggs;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Statistics-style title card
          Card(
            color: const Color(0xFF2E3D2F),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 20),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Inventory Management',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),

          // Inventory display card
          Card(
            color: const Color(0xFF4AC1C5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.inventory, color: Colors.white, size: 40),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Inventory ($selectedType Eggs)',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '$currentCount eggs',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total: $total eggs',
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.swap_horiz, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (selectedType == 'Small') {
                              selectedType = 'Medium';
                            } else if (selectedType == 'Medium') {
                              selectedType = 'Large';
                            } else {
                              selectedType = 'Small';
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: clearCounts,
                    child: const Text(
                      'Clear',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Form card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Manage Egg Inventory', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    items: ['Small', 'Medium', 'Large'].map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) => setState(() => selectedType = value!),
                    decoration: InputDecoration(
                      labelText: 'Egg Type',
                      filled: true,
                      fillColor: const Color(0xFFEFF6EE),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: action,
                    items: ['Add to stock', 'Remove from current stock'].map((act) {
                      return DropdownMenuItem(value: act, child: Text(act));
                    }).toList(),
                    onChanged: (value) => setState(() => action = value!),
                    decoration: InputDecoration(
                      labelText: 'Action',
                      filled: true,
                      fillColor: const Color(0xFFEFF6EE),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity (Pieces)',
                      filled: true,
                      fillColor: const Color(0xFFEFF6EE),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Notes (Optional)',
                      filled: true,
                      fillColor: const Color(0xFFEFF6EE),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final qty = int.tryParse(quantityController.text) ?? 0;
                      if (qty <= 0) return;
                      widget.onUpdateInventory(selectedType, qty, action);
                      quantityController.clear();
                      notesController.clear();
                      setState(() {}); // Refresh UI
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFcb9559),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Center(child: Text('Update Inventory', style: GoogleFonts.poppins(fontSize: 16))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
