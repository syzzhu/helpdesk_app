import 'package:flutter/material.dart';
import 'detailPM.dart';
import 'dashboard_page.dart'; // Pastikan import dashboard ada
import 'qr_scanner_page.dart';

class PMPage extends StatefulWidget {
  const PMPage({super.key});

  @override
  State<PMPage> createState() => _PMState();
}

class _PMState extends State<PMPage> {
  // Letak dalam class _PMState
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allData = []; // Data asal
  List<Map<String, dynamic>> filteredData = []; // Data yang akan dipaparkan

  @override
  void initState() {
    super.initState();
    // Masukkan data anda di sini supaya boleh di-filter
    allData = [
      {
        'name': 'KAMAL AZUDIN BIN MD.YUSOF\nPENYIARAN (TV & RADIO)',
        'dept': '15th Floor - BERNAMA RADIO',
        'type': 'INTERNET / WIRELESS',
        'status': 'NEW',
        'desc': 'Can’t access internet',
        'desc1':
            'Preventive Maintenance (COMPUTER SET)- FATINLYANA \nYASMIN BINTI FADZLI YUSOF',
        'color': Colors.redAccent,
      },
      {
        'name': 'KAMAL AZUDIN BIN MD.YUSOF\nPENYIARAN (TV & RADIO)',
        'dept': '15th Floor - BERNAMA RADIO',
        'type': 'NOTEBOOK/LAPTOP/IPAD/MACBOOK',
        'status': 'PENDING',
        'desc': 'PC Hang',
        'desc1': 'Preventive Maintenance (LAPTOP)- FARAH BINTI MOHD',
        'color': Colors.orange,
      },
    ];
    filteredData = allData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00AEEF), Color(0xFF0089BB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings_rounded, size: 42, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'Preventive \nMaintenance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          String query = value.toLowerCase();
                          filteredData = allData.where((item) {
                            // 1. Check nama
                            bool matchesName = item['name']
                                .toLowerCase()
                                .contains(query);
                            // 2. Check type
                            bool matchesType = item['type']
                                .toLowerCase()
                                .contains(query);
                            return matchesName || matchesType;
                          }).toList();
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search name / type',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF00AEEF),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- LIST OF CARDS ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: _buildOperationCard(
                    context,
                    type: item['type'],
                    status: item['status'],
                    statusColor: item['color'],
                    name: item['name'],
                    department: item['dept'],
                    description: item['desc'],
                    desc1: item['desc1'],
                  ),
                );
              },
            ),
          ),
          // --- BOTTOM NAV BAR  ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home Page (Klik untuk ke Dashboard)
                _buildNavItem(
                  context,
                  Icons.home_outlined,
                  "Home",
                  false,
                  size,
                  destination: const DashboardPage(),
                ),

                _buildQRItem(context),

                _buildNavItem(
                  context,
                  Icons.list_alt_rounded,
                  "Options",
                  false,
                  size,
                  destination: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER CARD ---
  Widget _buildOperationCard(
    BuildContext context, {
    required String type,
    required String status,
    required Color statusColor,
    required String name,
    required String department,
    required String description,
    required String desc1,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPMPage(
              status: status,
              name: name,
              department: department,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildChip(type, Colors.blue.shade50, Colors.blue.shade700),
                  _buildChip(status, statusColor.withOpacity(0.1), statusColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.grey,
                      size: 35,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          department,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // --- DESCRIPTION (CENTER) ---
            // --- DESCRIPTION CONTAINERS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container pertama untuk description
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100], // warna container pertama
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 8), // jarak antara container
                  // Container kedua untuk desc1
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100], // warna container kedua
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      desc1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: text,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  // --- HELPER NAV ITEM DENGAN NAVIGASI ---
  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive, 
    Size size,{
    Widget? destination,
  }) {
    //final double iconSize = size.width * 0.07; //responsive icon size
    //final double fontSize = size.width * 0.03; //responsive font size

    return GestureDetector(
      onTap: () {
        if (destination != null && !isActive) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => destination),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: size.width * 0.07, // responsive ikut screen
            color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.035, // responsive
              color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRItem(BuildContext context) {
    // get the size of the screen
    final size = MediaQuery.of(context).size;

    // Base size for circle and icon
    final double radius = size.width * 0.07; //responsive size
    //final double iconSize = radius * 0.8; 
    //final double padding = radius * 0.5;
    final double translationY = -radius * 0.2; //transform radius

    return GestureDetector(
      onTap: () async {
        final String? qrResult = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const QRScannerPage()),
        );

        if (qrResult != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Hasil Scan: $qrResult')));
        }
      },
      child: Container(
        transform: Matrix4.translationValues(0, translationY, 0),
        padding: EdgeInsets.all(radius * 0.35),
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: radius * 0.3,
              offset: Offset(0, radius * 0.2),
            ),
          ],
        ),
        child: Icon(Icons.qr_code_scanner, color: Colors.white, size: radius * 0.75),
      ),
    );
  }
}
