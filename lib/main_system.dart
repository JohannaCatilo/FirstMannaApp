import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/sale_record.dart';
import 'main.dart';
import 'screens/egg_production_screen.dart';
import 'screens/sales_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/about_screen.dart';

class MainSystem extends StatefulWidget {
  @override
  State<MainSystem> createState() => _MainSystemState();
}

class _MainSystemState extends State<MainSystem> {
  int _selectedIndex = 2;

  int totalEggs = 0;
  double totalSales = 0.0;
  int smallEggs = 0;
  int mediumEggs = 0;
  int largeEggs = 0;

  List<SaleRecord> salesHistory = [];

  void updateTotalEggs(int newTotal) {
    setState(() => totalEggs = newTotal);
  }

  void updateTotalSales(double newSales) {
    setState(() => totalSales = newSales);
  }

  void updateInventoryFromScreen(String type, int quantity, String action) {
    setState(() {
      if (type == 'Small') {
        smallEggs = (action == 'Add to stock')
            ? smallEggs + quantity
            : (smallEggs - quantity).clamp(0, double.infinity).toInt();
      } else if (type == 'Medium') {
        mediumEggs = (action == 'Add to stock')
            ? mediumEggs + quantity
            : (mediumEggs - quantity).clamp(0, double.infinity).toInt();
      } else if (type == 'Large') {
        largeEggs = (action == 'Add to stock')
            ? largeEggs + quantity
            : (largeEggs - quantity).clamp(0, double.infinity).toInt();
      }
    });
  }

  void addToSalesHistory(SaleRecord sale) {
    setState(() {
      salesHistory.insert(0, sale);
    });
  }

  final List<String> _labels = ['Eggs', 'Sales', 'Home', 'Inventory', 'Stats'];
  final List<IconData> _icons = [
    Icons.egg,
    Icons.shopping_cart,
    Icons.home,
    Icons.list,
    Icons.pie_chart,
  ];

  @override
  Widget build(BuildContext context) {
    const drawerIconColor = Color(0xFF8AAE8F);

    final List<Widget> _screens = [
      EggProductionScreen(
        totalEggs: totalEggs,
        onUpdateTotalEggs: updateTotalEggs,
      ),
      SalesScreen(
        totalSales: totalSales,
        onUpdateTotalSales: updateTotalSales,
        onRecordSale: addToSalesHistory,
      ),
      DashboardScreen(
        totalEggs: totalEggs,
        totalSales: totalSales,
        smallEggs: smallEggs,
        mediumEggs: mediumEggs,
        largeEggs: largeEggs,
        salesHistory: salesHistory,
      ),
      InventoryScreen(
        smallEggs: smallEggs,
        mediumEggs: mediumEggs,
        largeEggs: largeEggs,
        onUpdateInventory: updateInventoryFromScreen,
      ),
      StatisticsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: drawerIconColor,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          _labels[_selectedIndex],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF8AAE8F)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'First Manna Farm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ClipOval(
                    child: Image.asset(
                      'assets/images/mannalogo.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: drawerIconColor),
              title: const Text('Main'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info, color: drawerIconColor),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AboutScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: drawerIconColor),
              title: const Text('Sign Out'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => WelcomeScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFF1B1B2F),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              final isSelected = index == _selectedIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _icons[index],
                          size: 24,
                          color: isSelected ? Colors.white : Colors.grey[400],
                        ),
                        const SizedBox(height: 4),
                        AnimatedOpacity(
                          opacity: isSelected ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            _labels[index],
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
