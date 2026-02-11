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
      body: Column(
        children: [
          // --- HEADER RESPONSIVE ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              bottom: 30 * scaleFactor,
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
                    Icon(Icons.business_center, size: 35 * scaleFactor, color: Colors.white),
                    SizedBox(width: 10 * scaleFactor),
                    Text(
                      'Operation',
                      style: TextStyle(
                        fontSize: 28 * scaleFactor,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20 * scaleFactor),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
                  child: Container(
                    height: 50 * scaleFactor,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (v) => setState(() {
                        filteredData = allData.where((i) => i['name'].toLowerCase().contains(v.toLowerCase())).toList();
                      }),
                      decoration: InputDecoration(
                        hintText: 'Search name / type',
                        prefixIcon: Icon(Icons.search, size: 20 * scaleFactor),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15 * scaleFactor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- LIST CARDS RESPONSIVE ---
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16 * scaleFactor),
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                return _buildResponsiveCard(item, scaleFactor);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildResponsiveCard(Map<String, dynamic> item, double scale) {
    return Container(
      margin: EdgeInsets.only(bottom: 16 * scale),
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
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
          SizedBox(height: 15 * scale),
          Row(
            children: [
              CircleAvatar(
                radius: 25 * scale,
                backgroundColor: Colors.grey[200],
                child: Icon(Icons.person, size: 25 * scale, color: Colors.grey),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name'],
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14 * scale)),
                    Text(item['dept'],
                        style: TextStyle(fontSize: 11 * scale, color: Colors.grey[500])),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15 * scale),
          Container(
            padding: EdgeInsets.all(12 * scale),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            child: Text(
              item['desc'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12 * scale, fontWeight: FontWeight.w500),
            ),
          ),
        ],
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