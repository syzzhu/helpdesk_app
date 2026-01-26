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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 25),
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
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ComplaintsPage()),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.article_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Detail',
                      style: TextStyle(
                        fontSize: 26, //
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // --- CONTENT SECTION ---
          // Ticket ID Bar
            Center( // Guna Center supaya box tu duduk tengah selepas dipendekkan
            child: SizedBox(
              width: 350, 
              child: _buildCleanBox(
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(status, style: const TextStyle(color: Colors.white)),
                    ),
                    const Expanded( // Ini akan isi baki ruang dalam 280 tadi
                      child: Text(
                        'H202601141050510002',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // CONTACT PERSON
                _buildHeaderLabel("CONTACT PERSON"),
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
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone_rounded,
                                  size: 16,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "019-777 7777",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
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
                const SizedBox(height: 20),

                // TICKET INFORMATION
                _buildHeaderLabel("TICKET INFORMATION"),
                _buildCleanBox(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            Text(
                              "INTERNET / WIRELESS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "START DATE : 15 JAN 2026",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              "END DATE : 15 JAN 2026",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          "Wakil Aset RADIO: Encik Shukhaiman/Puan Azlina Zakaria mohon mengemaskini No.Invois & DO set komputer baharu pada Modul Perolehan (SPB) seterusnya melengkapkan rekod pengguna dan penempatan dan membuat janaan no. aset di Model Aset(SPB).",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 13, // Besarkan dari 11 ke 13
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // LAPTOP SECTION
                _buildCleanBox(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00AEEF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "LAPTOP",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "KKMM/BERNAMA/H/15/241",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // BUTTON ACKNOWLEDGE
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AEEF),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "ACKNOWLEDGE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 25),
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
  Widget _buildHeaderLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
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
        if (destination != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DetailComplaintsPage(
                status: status,
                name: name,
                department: department,
              ),
            ),
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
