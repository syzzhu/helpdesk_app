import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/Complaint/acknowlegeComplaints.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/Operation/detailOperation.dart';
//import 'detail_operation.dart';
import '../dashboard_page.dart';
import '../qr_scanner_page.dart';
import 'detailOperation.dart';

class OperationPage extends StatefulWidget {
  const OperationPage({super.key});

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  // Letak dalam class _OperationPageState
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allData = []; // Data asal
  List<Map<String, dynamic>> filteredData = []; // Data yang akan dipaparkan

  @override
  void initState() {
    super.initState();
    // Masukkan data anda di sini supaya boleh di-filter
    allData = [
      {
        'name': 'SITI SARADATUL HUSNA BINTI ISHAK',
        'dept': 'BAHAGIAN KEWANGAN & AKAUN',
        'type': 'DISMANTLE',
        'status': 'NEW',
        'desc':
            'Wakil Aset RADIO KOMUNIKASI...Wakil Aset RADIO KOMUNIKASI...Wakil Aset RADIO KOMUNIKASI...',
        'color': Colors.redAccent,
      },
      /*
      {
        'name': 'MOHD ISKANDAR',
        'dept': 'BAHAGIAN TEKNOLOGI MAKLUMAT & KOMUNIKASI',
        'type': 'INSTALLATION',
        'status': 'PENDING',
        'desc':
            'Installation Aurora Protect Software...Installation Aurora Protect Software...',
        'color': Colors.orange,
      },*/
    ];
    filteredData = allData;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // dapatkan saiz skrin
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
                    Icon(Icons.business_center, size: 45, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'Operation',
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
                  //false,
                  //size,
                  destination: const DashboardPage(),
                ),

                _buildQRItem(context),

                _buildNavItem(
                  context,
                  Icons.list_alt_rounded,
                  "Options",
                  //false,
                  //size,
                  destination: const ListOptionsPage(),
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
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailOperationPage(
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
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                textAlign: TextAlign.center,
                description,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
    String label, {
    Widget? destination,
  }) {
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
          Icon(icon, size: 28, color: Colors.grey),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildQRItem(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QRScannerPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
      ),
    );
  }
}
