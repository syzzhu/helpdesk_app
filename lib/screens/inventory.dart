import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'qr_scanner_page.dart';
import 'dashboard_page.dart';

class InventoryPage extends StatelessWidget {
  final String name;
  final String department;

  const InventoryPage({
    super.key,
    required this.name,
    required this.department,
  });
  // Warna Tema
  static const Color primaryBlue = Color(0xFF00AEEF);
  static const Color secondaryBlue = Color(0xFF0089BB);
  static const Color labelGrey = Color(0xFF64748B);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color textDark = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    // --- RESPONSIVE CHECK ---
    final screenSize = MediaQuery.of(context).size;
    final double scaleFactor = (screenSize.width / 400).clamp(1.0, 1.5);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of( context).padding.top + (10 * scaleFactor),
              bottom: 25 * scaleFactor,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryBlue, secondaryBlue],
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
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.article_rounded, color: Colors.white, size: 32),
                    SizedBox(width: 12),
                    Text(
                      'Inventory Details',
                      style: TextStyle(
                        fontSize: 22 * scaleFactor,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 800 * scaleFactor,
                ),
                child: ListView(
                padding : const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                children: [
                // --- TERMINAL & SPB SECTION ---
                _buildCleanBox(
                  child: Column(
                    children: [
                      _buildDataRow("TERMINAL NUMBER ", "NB4108", scaleFactor),
                      const Divider(height: 20, thickness: 0.5),
                      _buildDataRow("SPB (NEW)", "DEFAULTKKMM338", scaleFactor),
                      const Divider(height: 20, thickness: 0.5),
                      _buildDataRow("SPA (OLD)", "DEFAULTKKMM338", scaleFactor),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                _buildModernLabel("CONTACT PERSON", scaleFactor),
                _buildCleanBox(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(
                          Icons.person,
                          color: Colors.blue.shade700,
                          size: 30,
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
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              department,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(
                                  Icons.phone_rounded,
                                  size: 16,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 6),
                                Text(
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
                ),
                const SizedBox(height: 24),

                _buildModernLabel("NETWORK & SYSTEM", scaleFactor),
                _buildCleanBox(
                  child: Column(
                    children: [
                      _buildDataRow("IP Address", "WIFI - GUEST", scaleFactor),
                      const SizedBox(height: 12),
                      _buildDataRow("Remarks", "POBER1225/01139", scaleFactor),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            size: 12,
                            color: labelGrey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Tarikh Terima : 12/01/2026",
                            style: TextStyle(
                              color: Colors.blueGrey.shade700,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                _buildModernLabel("ASSET SPECIFICATION", scaleFactor),
                _buildCleanBox(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: primaryBlue.withOpacity(0.05),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "HP PROBOOK 4 G11 14 INCI AI PC",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: secondaryBlue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildDataRow("Category", "NOTEBOOK/LAPTOP", scaleFactor),
                            _buildDataRow("Brand", "HP (Hewlett-Packard)", scaleFactor),
                            _buildDataRow("Company", "FUTURE MAKERS SDN BHD", scaleFactor),
                            _buildDataRow("Serial No", "5CD54107FD", scaleFactor),
                            _buildDataRow("Asset Tag", "DEFAULTKKMM338", scaleFactor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                _buildModernLabel("SOFTWARE", scaleFactor),
                _buildCleanBox(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      const ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Text(
                          "Microsoft Office LTSC Standard 2024",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: textDark,
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            "7RYVY-CNR43-84TWF-RFKCM-39RPW",
                            style: TextStyle(
                              fontSize: 12,
                              color: labelGrey,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 12,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.history_rounded,
                              size: 12,
                              color: labelGrey,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Updated: 2026-01-14 09:46:36",
                              style: TextStyle(
                                fontSize: 10,
                                color: labelGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          ),
          _buildBottomNavigationBar(context),
        ],
      ),
    );
  }

  // --- WIDGET HELPERS (Pindahkan semua ke dalam class) ---

  Widget _buildContactSection(double scale){
    return _buildCleanBox(
      child: Row (
        children: [
          CircleAvatar(
            radius: 26 * scale,
            backgroundColor: Colors.blue.shade50,
            child: Icon(
              Icons.person,
              color: Colors.blue.shade700,
              size: 30 * scale,
            ),
          ),
          SizedBox(width: 15 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: Colors.grey[700], fontSize: 13 * scale)),
                Text(department, style: TextStyle(color: Colors.grey[700], fontSize: 11 * scale)),
                SizedBox(height: 8 * scale),
                Row(
                  children: [
                    Icon(Icons.phone_rounded, size: 16 * scale, color: Colors.green),
                    SizedBox(width: 6 * scale),
                    Text("019-777 7777", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12 * scale)),
                  ],
                )
              ]
            )
          )
        ]
      ),
    );
  }
  Widget _buildDataRow(String label, String value, double scale) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: labelGrey,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13 * scale,
                color: textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernLabel(String text, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8 * scale, left: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
          decoration: BoxDecoration(
            color: labelGrey,
            borderRadius: BorderRadius.circular(4 * scale),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9 * scale,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCleanBox({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
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
