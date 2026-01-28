import 'package:flutter/material.dart';
import 'qr_scanner_page.dart';
import 'dashboard_page.dart';

class LastPage extends StatelessWidget {
  const LastPage({super.key});

  static const Color primaryBlue = Color(0xFF00AEEF);
  static const Color secondaryBlue = Color(0xFF0089BB);
  static const Color labelGrey = Color(0xFF64748B);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color textDark = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 30),
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
                const Text(
                  'LAPTOP ASSET INFO',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 245, 242, 242),
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'NB4109', //
                    style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(255, 245, 242, 242),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                // --- SPB & SPA SECTION ---
                _buildCleanBox(
                  child: Column(
                    children: [
                      _buildDataRow("SPB (NEW)", "DEFAULTKKMM338"), //
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(height: 1, thickness: 0.5),
                      ),
                      _buildDataRow("SPA (OLD)", "DEFAULTKKMM338"), //
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- CONTACT PERSON ---
                _buildModernLabel("CONTACT PERSON"),
                _buildCleanBox(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: primaryBlue.withOpacity(0.1),
                        child: const Icon(
                          Icons.person_rounded,
                          color: primaryBlue,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "KAMAL AZUDIN BIN MD.YUSOF", //
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: textDark,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "PENYIARAN ( TV & RADIO )", //
                              style: TextStyle(color: labelGrey, fontSize: 12),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_rounded,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "019-777 7777", //
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: textDark,
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

                // --- NETWORK & REMARKS ---
                _buildModernLabel("NETWORK & SYSTEM"),
                _buildCleanBox(
                  child: Column(
                    children: [
                      _buildDataRow("IP Address", "WIFI - GUEST"), //
                      const SizedBox(height: 12),
                      _buildDataRow("Remarks", "POBER1225/01139"), //
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Divider(height: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              size: 12,
                              color: labelGrey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Tarikh Terima : 12/01/2026", //
                              style: TextStyle(
                                color: labelGrey,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- ASSET SPECIFICATION ---
                _buildModernLabel("ASSET SPECIFICATION"),
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
                          "HP PROBOOK 4 G11 14 INCI AI PC", //
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
                            _buildDataRow("Category", "NOTEBOOK/LAPTOP"), //
                            _buildDataRow("Brand", "HP (Hewlett-Packard)"), //
                            _buildDataRow(
                              "Company",
                              "FUTURE MAKERS SDN BHD",
                            ), //
                            _buildDataRow("Serial No", "5CD54107FD"), //
                            _buildDataRow("Asset Tag", "DEFAULTKKMM338"), //
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- SOFTWARE SECTION ---
                _buildModernLabel("SOFTWARE"),
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
                          "Microsoft Office LTSC Standard 2024", //
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: textDark,
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            "7RYVY-CNR43-84TWF-RFKCM-39RPW", //
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
                              "Updated: 2026-01-14 09:46:36", //
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
          _buildBottomNavigationBar(context),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF64748B),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
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
}

Widget _buildBottomNavigationBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
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
          destination: const DashboardPage(),
        ),
        _buildQRItem(context),
        _buildNavItem(
          context,
          Icons.list_alt_rounded,
          "Options",
          destination: null,
        ),
      ],
    ),
  );
}

Widget _buildNavItem(
  BuildContext context,
  IconData icon,
  String label, {
  Widget? destination,
}) {
  return InkWell(
    onTap: () {
      if (destination != null)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
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
