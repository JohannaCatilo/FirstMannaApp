import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8AAE8F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: const Color(0xFFe2f1e4), // light matte green
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'The Egg & Sales Tracker is a dedicated mobile application designed to streamline the management of your poultry farm\'s egg production and sales. It empowers farmers to effortlessly log daily egg counts, manage inventory, process sales orders, and track revenue. With intuitive data visualization, the app provides valuable insights into production trends and sales performance, helping you optimize operations and boost profitability.',
              style: GoogleFonts.poppins(fontSize: 14, height: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
