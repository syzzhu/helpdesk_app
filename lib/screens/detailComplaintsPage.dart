import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/complaints.dart';
import 'qr_scanner_page.dart';
import 'dashboard_page.dart';

class DetailComplaintsPage extends StatelessWidget {
  final String status;
  final String name;
  final String department;

  const DetailComplaintsPage({
    super.key,
    required this.status,
    required this.name,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // dapatkan saiz skrin
    final spacing = size.height * 0.015; // responsive spacing

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: size.height * 0.06,
              bottom: size.height * 0.03,
            ),
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
                      size: size.width * 0.06,
                    ),
                    onPressed: () => Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => ComplaintsPage()),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.article_rounded,
                      color: Colors.white,
                      size: size.width * 0.08,
                    ),
                    SizedBox(width: size.width * 0.03),
                    Text(
                      'Detail',
                      style: TextStyle(
                        fontSize: size.width * 0.07,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spacing),

          // --- CONTENT SECTION ---
          // Ticket ID Bar
          Center(
            child: SizedBox(
              width: size.width * 0.9,
              child: _buildCleanBox(
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: size.height * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.035,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'H202601141050510002',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.04,
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
              padding: EdgeInsets.all(size.width * 0.05),
              children: [
                // CONTACT PERSON
                _buildHeaderLabel("CONTACT PERSON", size),
                _buildCleanBox(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: size.width * 0.07,
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(
                          Icons.person,
                          color: Colors.blue.shade700,
                          size: size.width * 0.07,
                        ),
                      ),
                      SizedBox(width: size.width * 0.035),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                            SizedBox(height: spacing * 0.25),
                            Text(
                              department,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: size.width * 0.033,
                              ),
                            ),
                            SizedBox(height: spacing * 0.5),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_rounded,
                                  size: size.width * 0.04,
                                  color: Colors.green,
                                ),
                                SizedBox(width: size.width * 0.015),
                                Text(
                                  "019-777 7777",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.035,
                                    color: Colors.black87,
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
                SizedBox(height: spacing),

                // TICKET INFORMATION
                _buildHeaderLabel("TICKET INFORMATION", size),
                _buildCleanBox(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(size.width * 0.035),
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            Text(
                              "INTERNET / WIRELESS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.035,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            SizedBox(height: spacing * 0.25),
                            Text(
                              "START DATE : 15 JAN 2026",
                              style: TextStyle(
                                fontSize: size.width * 0.032,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "END DATE : 15 JAN 2026",
                              style: TextStyle(
                                fontSize: size.width * 0.032,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.045),
                        child: Text(
                          "Wakil Aset RADIO: Encik Shukhaiman/Puan Azlina Zakaria mohon mengemaskini No.Invois & DO set komputer baharu pada Modul Perolehan (SPB) seterusnya melengkapkan rekod pengguna dan penempatan dan membuat janaan no. aset di Model Aset(SPB).",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing * 1.2),

                // LAPTOP SECTION
                _buildCleanBox(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.035,
                          vertical: size.height * 0.012,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00AEEF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "LAPTOP",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.03,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Expanded(
                        child: Text(
                          "KKMM/BERNAMA/H/15/241",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.035,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.045),

                // BUTTON ACKNOWLEDGE
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AEEF),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, size.height * 0.07),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "ACKNOWLEDGE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.045,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),

          // --- BOTTOM NAV BAR ---
          _buildBottomNavigationBar(context),
        ],
      ),
    );
  }

  // --- REFINED HELPERS ---
  Widget _buildHeaderLabel(String text, Size size) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.012, bottom: size.height * 0.01),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size.width * 0.033,
          fontWeight: FontWeight.w900,
          color: Colors.blueGrey.shade700,
          letterSpacing: 0.8,
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

  Widget _buildBottomNavigationBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive, 
    Size size,{
    Widget? destination,
  }) {
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
            size: size.width * 0.07,
            color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.035,
              color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRItem(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double radius = size.width * 0.07;
    final double translationY = -radius * 0.2;

    return GestureDetector(
      onTap: () async {
        final String? qrResult = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const QRScannerPage()),
        );
        if (qrResult != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hasil Scan: $qrResult')),
          );
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
