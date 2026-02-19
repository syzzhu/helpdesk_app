import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'detailPM.dart';
import '../dashboard_page.dart';
import '../qr_scanner_page.dart';

class PMPage extends StatefulWidget {
  const PMPage({super.key});

  @override
  State<PMPage> createState() => _PMState();
}

class _PMState extends State<PMPage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allData = [];
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    allData = [
      {
        'name': 'KAMAL AZUDIN BIN MD.YUSOF\nPENYIARAN (TV & RADIO)',
        'dept': '15th Floor - BERNAMA RADIO',
        'type': 'INTERNET / WIRELESS',
        'status': 'NEW',
        'desc': 'Can’t access internet',
        'desc1': 'Preventive Maintenance (COMPUTER SET)- FATINLYANA \nYASMIN BINTI FADZLI YUSOF',
        'color': Colors.redAccent,
      },
    ];
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          bool isTablet = screenWidth > 600;
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
                        Icon(Icons.settings_rounded, size: isTablet ? 40 : 30, color: Colors.white),
                        const SizedBox(width: 12),
                        Text(
                          'Preventive\nMaintenance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isTablet ? 30 : 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                            filteredData = allData.where((i) => 
                              i['name'].toLowerCase().contains(v.toLowerCase()) ||
                              i['type'].toLowerCase().contains(v.toLowerCase())
                            ).toList();
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
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        return _buildPMCard(filteredData[index], isTablet);
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

  Widget _buildPMCard(Map<String, dynamic> item, bool isTablet) {
    double scale = isTablet ? 1.2 : 1.0;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(isTablet ? 30 : 20),
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPM(
                status: item['status'],
                name: item['name'],
                department: item['dept'],
              ),
            ),
          );
        },
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
                          fontSize: isTablet ? 18 : 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        item['dept'],
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 11,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Kotak Deskripsi 1
            Container(
              padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 15, horizontal: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                item['desc'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Kotak Deskripsi 2 (desc1)
            Container(
              padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 15, horizontal: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                item['desc1'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
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
    final isTablet = size.width >= 600;

    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: isTablet ? 40 : 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, Icons.home_outlined, "Home", destination: const DashboardPage(), isTablet: isTablet),
          _buildQRItem(context, isTablet: isTablet),
          _buildNavItem(context, Icons.list_alt_rounded, "Options", destination: const ListOptionsPage(), isTablet: isTablet),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, {Widget? destination, required bool isTablet}) {
    return InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isTablet ? 36 : 28, color: Colors.grey),
          Text(label, style: TextStyle(fontSize: isTablet ? 16 : 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildQRItem(BuildContext context, {required bool isTablet}) {
    double iconSize = isTablet ? 36 : 30;
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerPage())),
      child: Container(
        padding: EdgeInsets.all(iconSize * 0.4),
        decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Icon(Icons.qr_code_scanner, color: Colors.white, size: iconSize),
      ),
    );
  }
}