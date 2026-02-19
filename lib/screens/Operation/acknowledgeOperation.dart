import 'dart:math';
import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/inventory.dart';
import '../qr_scanner_page.dart';
import '../dashboard_page.dart';
import 'operation.dart';
import '../comment_page.dart';

class AcknowledgeoperationPage extends StatelessWidget {
  final String status;
  final String name;
  final String department;

  const AcknowledgeoperationPage({
    super.key,
    required this.status,
    required this.name,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    // scaling factor
    final scaleW = screenWidth / 375; // base iPhone 11 width
    final scaleH = screenHeight / 812; // base iPhone 11 height
    final scaleText = min(scaleW, scaleH);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 50 * scaleH, bottom: 25 * scaleH),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 30 * scaleText,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_turned_in,
                        color: Colors.white, size: 32 * scaleText),
                    SizedBox(width: 12 * scaleW),
                    Text(
                      'Acknowledge',
                      style: TextStyle(
                        fontSize: 26 * scaleText,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20 * scaleH),

          // --- TICKET ID BAR ---
          Center(
            child: Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12 * scaleW),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18 * scaleW, vertical: 12 * scaleH),
                      decoration: BoxDecoration(
                        color: status.toUpperCase() == 'NEW'
                            ? Colors.redAccent
                            : (status.toUpperCase() == 'PENDING'
                                ? const Color.fromARGB(255, 243, 195, 72)
                                : Colors.grey),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12 * scaleText,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'L202601141050510002',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontSize: 13 * scaleText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20 * scaleW),
              children: [
                _buildModernLabel("CONTACT PERSON", scaleText),
                _buildCleanBox(
                  scaleText: scaleText,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26 * scaleW,
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(
                          Icons.person,
                          color: Colors.blue.shade700,
                          size: 30 * scaleText,
                        ),
                      ),
                      SizedBox(width: 15 * scaleW),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13 * scaleText,
                              ),
                            ),
                            SizedBox(height: 4 * scaleH),
                            Text(
                              department,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12 * scaleText,
                              ),
                            ),
                            SizedBox(height: 8 * scaleH),
                            Row(
                              children: [
                                Icon(Icons.phone_rounded,
                                    size: 16 * scaleText, color: Colors.green),
                                SizedBox(width: 6 * scaleW),
                                Text(
                                  "019-777 7777",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13 * scaleText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20 * scaleH),

                _buildModernLabel("TICKET INFORMATION", scaleText),
                _buildCleanBox(
                  scaleText: scaleText,
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15 * scaleW),
                            color: Colors.grey[200],
                            child: Column(
                              children: [
                                Text(
                                  "WORK ORDER : DISMANTLE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13 * scaleText,
                                    color: Colors.blueGrey.shade900,
                                  ),
                                ),
                                SizedBox(height: 4 * scaleH),
                                Text(
                                  "START DATE : 15 JAN 2026",
                                  style: TextStyle(fontSize: 12 * scaleText),
                                ),
                                Text(
                                  "END DATE : 15 JAN 2026",
                                  style: TextStyle(fontSize: 12 * scaleText),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 10 * scaleW,
                            top: 10 * scaleH,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InventoryPage(
                                      name: name,
                                      department: department,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(8 * scaleW),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.inventory_2_rounded,
                                  color: const Color(0xFF0089BB),
                                  size: 22 * scaleText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(18 * scaleW),
                        child: Text(
                          "Wakil Aset RADIO: Encik Shukhaiman/Puan Azlina Zakaria mohon mengemaskini No.Invois & DO set komputer baharu pada Modul Perolehan (SPB) seterusnya melengkapkan rekod pengguna dan penempatan dan membuat janaan no. aset di Model Aset(SPB).",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 13 * scaleText,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18 * scaleH),

                _buildCleanBox(
                  scaleText: scaleText,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14 * scaleW, vertical: 8 * scaleH),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00AEEF),
                          borderRadius: BorderRadius.circular(6 * scaleW),
                        ),
                        child: Text(
                          "LAPTOP",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11 * scaleText,
                          ),
                        ),
                      ),
                      SizedBox(width: 12 * scaleW),
                      Expanded(
                        child: Text(
                          "KKMM/BERNAMA/H/15/241",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13 * scaleText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20 * scaleH),
                _buildModernLabel("TECHNICAL PERSON", scaleText),
                _buildCleanBox(
                  scaleText: scaleText,
                  color: Colors.white,
                  padding: EdgeInsets.all(12 * scaleW),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CommentPage(status: status)),
                            );
                          },
                          child: Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Colors.black,
                            size: 26 * scaleText,
                          ),
                        ),
                      ),
                      SizedBox(height: 8 * scaleH),
                      _buildTechnicalRow("NEW", "SHARIFFUDDIN BIN ALI BASHA",
                          scaleText),
                      SizedBox(height: 10 * scaleH),
                      _buildTechnicalRow("NEW", "MOHD NAZRIN BIN ABU HASSAN",
                          scaleText),
                    ],
                  ),
                ),

                SizedBox(height: 35 * scaleH),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OperationPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AEEF),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 55 * scaleH),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text(
                    "FINISH",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16 * scaleText),
                  ),
                ),
                SizedBox(height: 25 * scaleH),
              ],
            ),
          ),
          _buildBottomNavigationBar(context),
        ],
      ),
    );
  }

  // --- HELPER WIDGETS ---
  Widget _buildTechnicalRow(String tag, String name, double scaleText) {
    return Row(
      children: [
        Container(
          width: 80 * scaleText,
          padding: EdgeInsets.symmetric(vertical: 10 * scaleText),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(4 * scaleText),
          ),
          alignment: Alignment.center,
          child: Text(
            tag,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12 * scaleText,
            ),
          ),
        ),
        SizedBox(width: 10 * scaleText),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 10 * scaleText, horizontal: 15 * scaleText),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4 * scaleText),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 11 * scaleText,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernLabel(String text, double scaleText) {
    return Padding(
      padding: EdgeInsets.only(left: 5 * scaleText, bottom: 10 * scaleText),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 12 * scaleText, vertical: 6 * scaleText),
          decoration: BoxDecoration(
            color: const Color(0xFF64748B),
            borderRadius: BorderRadius.circular(4 * scaleText),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10 * scaleText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCleanBox({
    required Widget child,
    EdgeInsets? padding,
    Color? color,
    double scaleText = 1,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.all(15 * scaleText),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(15 * scaleText),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
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
