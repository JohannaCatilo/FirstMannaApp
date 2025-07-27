// ...imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EggProductionScreen extends StatefulWidget {
  final int totalEggs;
  final ValueChanged<int> onUpdateTotalEggs;

  const EggProductionScreen({
    super.key,
    required this.totalEggs,
    required this.onUpdateTotalEggs,
  });

  @override
  _EggProductionScreenState createState() => _EggProductionScreenState();
}

class _EggProductionScreenState extends State<EggProductionScreen> {
  final TextEditingController _eggCountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedHouse = 'House 1';

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitProduction() {
    final input = int.tryParse(_eggCountController.text);
    if (input != null) {
      widget.onUpdateTotalEggs(widget.totalEggs + input);
      _eggCountController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number of eggs.')),
      );
    }
  }

  void _clearEggs() {
    widget.onUpdateTotalEggs(0);
  }

  @override
  Widget build(BuildContext context) {
    final lightMatteGreen = const Color(0xFFE9F5EC);
    final dateFormatted = DateFormat('MMMM d, yyyy').format(_selectedDate);
    final totalTrays = (widget.totalEggs / 30).floor();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Updated Title Card
            Card(
              color: const Color(0xFF2E3D2F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Egg Production',
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

            // Top Summary Card
            Stack(
              children: [
                Card(
                  color: const Color(0xFF8AAE8F),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.egg, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Today's Eggs Collected",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${widget.totalEggs} pieces',
                          style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.shopping_basket, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Total Trays",
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$totalTrays trays',
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: _clearEggs,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Clear',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Input Form
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Record Daily Production',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    const Text('Date:', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: lightMatteGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dateFormatted, style: const TextStyle(fontSize: 16)),
                            const Icon(Icons.calendar_today)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text('House:', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: lightMatteGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedHouse,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: ['House 1', 'House 2', 'House 3', 'House 4', 'House 5']
                            .map((house) => DropdownMenuItem(
                                  value: house,
                                  child: Text(house),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedHouse = value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text('Eggs Collected (pieces):', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _eggCountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter number of eggs',
                        fillColor: lightMatteGreen,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitProduction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFcb9559),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text(
                          'Submit Production',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
