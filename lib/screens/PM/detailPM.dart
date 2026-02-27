import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import '../qr_scanner_page.dart';
import '../dashboard_page.dart';
import 'acknowledgePM.dart';

class DetailPM extends StatelessWidget {
  final String status;
  final String name;
  final String department;

  const DetailPM({
    super.key,
    required this.status,
    required this.name,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = (screenWidth * 0.07).clamp(20.0, 40.0);

    final scaleW = screenWidth / 375; // base iPhone 11 width
    final scaleH = screenHeight / 812;
    double scale(double val) {
      double s = size.width / 375;

      // Had maksimum supaya tablet tak jadi besar melampau
      if (s > 1.2) s = 1.2;

      return val * s;
    }


    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: screenHeight * 0.05, bottom: 15 * scaleH),
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
                      size: scale(30),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description, color: Colors.white, size: scale(32)),
                    SizedBox(width: scale(12)),
                    Text(
                      'Detail PM',
                      style: TextStyle(
                        fontSize: scale(26),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: scale(20)),

          // --- TICKET ID BAR ---
          Center(
            child: Container(
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: scale(18),
                        vertical: scale(12),
                      ),
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
                          fontSize: scale(12),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'PM202601141050510002',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontSize: scale(13),
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
              padding: EdgeInsets.all(scale(20)),
              children: [
                // --- CONTACT PERSON SECTION ---
                _buildModernLabel("CONTACT PERSON", scale),
                _buildCleanBox(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: avatarRadius * 0.8,
                        ),
                      ),
                      SizedBox(width: scale(15)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: scale(13),
                              ),
                            ),
                            SizedBox(height: scale(4)),
                            Text(
                              department,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: scale(12),
                              ),
                            ),
                            SizedBox(height: scale(8)),
                            Row(
                              children: [
                                Icon(Icons.phone_rounded, size: scale(16), color: Colors.green),
                                SizedBox(width: scale(6)),
                                const Text(
                                  "019-777 7777",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(scale(15)),
                ),

                SizedBox(height: scale(20)),

                // --- TICKET INFORMATION ---
                _buildModernLabel("TICKET INFORMATION", scale),
                _buildCleanBox(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(scale(15)),
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            Text(
                              "PM TYPE : COMPUTER SET",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: scale(13),
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            SizedBox(height: scale(4)),
                            Text(
                              "END DATE : 28 JAN 2026",
                              style: TextStyle(fontSize: scale(12)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(scale(18)),
                        child: Text(
                          "Preventive Maintenance (COMPUTER SET) - MUHAMMAD MUJAHID BIN ISHAK (1255) computer yang rosak mengikut petugas berikut:",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: scale(13),
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: scale(18)),

                // --- ITEM / ASSET SECTION ---
                _buildCleanBox(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: scale(14), vertical: scale(8)),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00AEEF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "LAPTOP",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: scale(11),
                          ),
                        ),
                      ),
                      SizedBox(width: scale(12)),
                      Expanded(
                        child: Text(
                          "KKMM/BERNAMA/H/15/241",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: scale(13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(scale(15)),
                ),

                SizedBox(height: scale(35)),

                // --- ACKNOWLEDGE BUTTON ---
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AcknowledgePMPage(
                          status: status,
                          name: name,
                          department: department,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AEEF),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, scale(55)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "ACKNOWLEDGE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: scale(16)),
                  ),
                ),

                SizedBox(height: scale(25)),
              ],
            ),
          ),

          // --- BOTTOM NAVIGATION BAR ---
          _buildBottomNavigationBar(context, scale),
        ],
      ),
    );
  }

  // --- HELPER WIDGETS ---
  Widget _buildModernLabel(String text, double Function(double) scale) {
    return Padding(
      padding: EdgeInsets.only(left: scale(5), bottom: scale(10)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: scale(12), vertical: scale(6)),
          decoration: BoxDecoration(
            color: const Color(0xFF64748B),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: scale(10),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCleanBox({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, double Function(double val) scale) {
    final size = MediaQuery.of(context).size;
    final spacing = size.height * 0.015;
    final isTablet = size.width >= 600;
    return Container(
      padding: EdgeInsets.symmetric(vertical: spacing, horizontal: isTablet ? 40 : 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, Icons.home_outlined, "Home", destination: const DashboardPage(), iconSize: isTablet ? 36 : 28, fontSize: isTablet ? 16 : 11),
          _buildQRItem(context, iconSize: isTablet ? 36 : 30),
          _buildNavItem(context, Icons.list_alt_rounded, "Options", destination: const ListOptionsPage(), iconSize: isTablet ? 36 : 28, fontSize: isTablet ? 16 : 11),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label,
      {Widget? destination, double iconSize = 28, double fontSize = 11}) {
    return InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => destination));
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
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QRScannerPage())),
      child: Container(
        padding: EdgeInsets.all(iconSize * 0.4),
        decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Icon(Icons.qr_code_scanner, color: Colors.white, size: iconSize),
      ),
    );
  }
  }
