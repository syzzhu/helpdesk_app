import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/Operation/detailOperation.dart';
import '../dashboard_page.dart';
import '../qr_scanner_page.dart';
import 'package:helpdesk_app/screens/ListOption.dart';

class OperationPage extends StatefulWidget {
  const OperationPage({super.key});

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allData = [
    {
      'name': 'SITI SARADATUL HUSNA BINTI ISHAK',
      'dept': 'BAHAGIAN KEWANGAN & AKAUN',
      'type': 'DISMANTLE',
      'status': 'NEW',
      'desc': 'Wakil Aset RADIO KOMUNIKASI...Wakil Aset RADIO KOMUNIKASI...',
    },
    {
      'name': 'MOHD ISKANDAR',
      'dept': 'BAHAGIAN TEKNOLOGI MAKLUMAT & KOMUNIKASI',
      'type': 'INSTALLATION',
      'status': 'PENDING',
      'desc': 'Installation Aurora Protect Software...Installation Aurora Protect Software...',
    },
  ];
  late List<Map<String, dynamic>> filteredData;

  @override
  void initState() {
    super.initState();
    filteredData = allData;
  }

  Color _getStatusTextColor(String status) {
    return status.toUpperCase() == 'NEW' ? const Color(0xFFB73C3C) : Colors.orange.shade700;
  }

  Color _getStatusBgColor(String status) {
    return status.toUpperCase() == 'NEW' ? const Color(0xFFFFEAEA) : const Color(0xFFFFF4E5);
  }

  @override
  Widget build(BuildContext context) {
    // MediaQueries untuk dynamic scaling
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth / 375; // Baseline 375 (iPhone 11/Standard)

      return Scaffold(
      backgroundColor: Colors.grey[100],
      // 1. Guna LayoutBuilder untuk mengesan lebar skrin semasa
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          bool isTablet = screenWidth > 600;
          
          // Tetapkan had lebar maksimum untuk kandungan supaya tidak terlalu melarat pada tablet
          double contentWidth = isTablet ? screenWidth * 0.95 : screenWidth;

          return Column(
            children: [
              // --- HEADER RESPONSIVE ---
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  bottom: isTablet ? 40 : 30,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF00AEEF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.business_center, 
                            size: isTablet ? 40 : 30, 
                            color: Colors.white),
                        const SizedBox(width: 12),
                        Text(
                          'Operation',
                          style: TextStyle(
                            fontSize: isTablet ? 32 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Search Bar dipadatkan sedikit pada skrin besar
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? (screenWidth * 0.1) : 20
                      ),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (v) => setState(() {
                            filteredData = allData
                                .where((i) => i['name'].toLowerCase().contains(v.toLowerCase()))
                                .toList();
                          }),
                          decoration: const InputDecoration(
                            hintText: 'Search name / type',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- LIST CARDS RESPONSIVE ---
              Expanded(
                child: Center( // Center supaya pada tablet, list berada di tengah
                  child: Container(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final item = filteredData[index];
                        // Pastikan fungsi _buildResponsiveCard menerima parameter isTablet
                        return _buildResponsiveCard(item, isTablet);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildResponsiveCard(Map<String, dynamic> item, bool isTablet) {
    double scale = isTablet ? 1.2 : 1.0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      // --- TAMBAH INKWELL DI SINI ---
      child: InkWell(
        borderRadius: BorderRadius.circular(25), // Supaya kesan ripple ikut border card
        onTap: () {
          // Navigasi ke Detail Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailOperationPage(status: item['status'], name: item['name'], department: item['dept']), // Pastikan class DetailOperation anda sedia menerima parameter
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 30 : 20), // Alihkan padding ke sini supaya seluruh kawasan boleh ditekan
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _chip(item['type'], const Color(0xFFE3F2FD), const Color(0xFF1976D2), scale),
                  _chip(item['status'], _getStatusBgColor(item['status']), _getStatusTextColor(item['status']), scale),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  CircleAvatar(
                    radius: isTablet ? 35 : 25,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, size: isTablet ? 35 : 25, color: Colors.grey),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isTablet ? 20 : 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          item['dept'],
                          style: TextStyle(
                            fontSize: isTablet ? 15 : 13,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(vertical: isTablet ? 25 : 18, horizontal: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  item['desc'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, Color bg, Color text, double scale) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 5 * scale),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8 * scale)),
      child: Text(label, style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 10 * scale)),
    );
  }

 Widget _buildBottomNavigationBar(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final spacing = size.height * 0.015;
  final isTablet = size.width >= 600;

  return Container(
    padding: EdgeInsets.symmetric(vertical: spacing, horizontal: isTablet ? 40 : 0),
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2)),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavItem(
          context,
          Icons.home_outlined,
          "Home",
          destination: const DashboardPage(),
          iconSize: isTablet ? 36 : 28,
          fontSize: isTablet ? 16 : 11,
        ),
        _buildQRItem(context, iconSize: isTablet ? 36 : 30),
        _buildNavItem(
          context,
          Icons.list_alt_rounded,
          "Options",
          destination: const ListOptionsPage(),
          iconSize: isTablet ? 36 : 28,
          fontSize: isTablet ? 16 : 11,
        ),
      ],
    ),
  );
}

 Widget _buildNavItem(BuildContext context, IconData icon, String label,
    {Widget? destination, double iconSize = 28, double fontSize = 11}) {
  return InkWell(
    onTap: () {
      if (destination != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: Colors.grey),
        Text(label, style: TextStyle(fontSize: fontSize, color: Colors.grey)),
      ],
    ),
  );
}

Widget _buildQRItem(BuildContext context, {double iconSize = 30}) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRScannerPage()),
    ),
    child: Container(
      padding: EdgeInsets.all(iconSize * 0.4),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.qr_code_scanner, color: Colors.white, size: iconSize),
    ),
  );
}
}