import 'package:flutter/material.dart';
import 'detail_page.dart';

class OperationPage extends StatelessWidget {
  const OperationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Background kelabu sangat cair
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
                    Icon(
                      Icons.assignment_rounded,
                      size: 35,
                      color: Colors.white,
                    ),
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
                // Search Bar Moden
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
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search ticket or name...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF00AEEF),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- LIST OF CARDS ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: [
                _buildOperationCard(
                  context,
                  type: 'DISMANTLE',
                  status: 'NEW',
                  statusColor: Colors.redAccent,
                  name: 'SITI SARADATUL HUSNA BINTI ISHAK',
                  department: 'BAHAGIAN KEWANGAN & AKAUN',
                  description:
                      'Wakil Aset RADIO: Encik Shukhairman/Puan Azlina Zakaria mohon mengemaskini No Invois & DO set komputer ....',
                ),
                const SizedBox(height: 18),
                _buildOperationCard(
                  context,
                  type: 'INSTALLATION',
                  status: 'PENDING',
                  statusColor: Colors.orange,
                  name: 'MOHD ISKANDAR',
                  department: 'BAHAGIAN TEKNOLOGI MAKLUMAT & KOMUNIKASI',
                  description:
                      'Installation Aurora Protect/Cylance AV latest version',
                ),
              ],
            ),
          ),

          // --- BOTTOM NAV BAR ---
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
                _buildNavItem(Icons.home_filled, "Home", true),
                _buildQRItem(),
                _buildNavItem(Icons.list_alt_rounded, "Options", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Card yang lebih kemas
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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailPage()),
      ),
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
            // Row Atas (Chips)
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
            // Profile Section
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
            // Description Box
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                description,
                style: TextStyle(
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

  // Custom Chip Widget
  Widget _buildChip(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

  // Nav Item Widget
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 28,
          color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
          ),
        ),
      ],
    );
  }

  // QR Button Floating style
  Widget _buildQRItem() {
    return Container(
      transform: Matrix4.translationValues(0, -5, 0),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
    );
  }
}
