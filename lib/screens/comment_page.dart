import 'package:flutter/material.dart';
import 'qr_scanner_page.dart';
import 'dashboard_page.dart';

class CommentPage extends StatelessWidget {
  final String status;

  const CommentPage({super.key, required this.status});

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
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 26,
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

          // --- TICKET ID BAR ---
          Center(
            child: Container(
              width: 350,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'L202601141050510002',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // --- LIST OF COMMENTS ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildCommentBubble(
                  name: "NORIZAN BINTI MOHD YUSOF",
                  date: "14 Jan",
                  time: "10:52 AM",
                  comment:
                      "Please Check the ticket. Saya dah hantar laporan tapi belum ada respon. Terima kasih!!",
                  isMe: false,
                ),
                _buildCommentBubble(
                  name: "System Admin",
                  date: "14 Jan",
                  time: "12:52 PM",
                  comment:
                      "Ticket has been assigned to technician. Status: In Progress.",
                  isMe: true,
                ),
              ],
            ),
          ),

          // --- BOTTOM NAV BAR ---
          _buildBottomNavigationBar(context),
        ],
      ),
    );
  }

  Widget _buildCommentBubble({
    required String name,
    required String date,
    required String time,
    required String comment,
    required bool isMe,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bahagian Atas (Header Komen)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? Colors.blueGrey.shade50 : Colors.blue.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: isMe
                      ? Colors.blueGrey
                      : const Color(0xFF00AEEF),
                  child: Icon(
                    isMe ? Icons.admin_panel_settings : Icons.person,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: isMe
                          ? Colors.blueGrey.shade900
                          : Colors.blue.shade900,
                    ),
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // Bahagian Isi Komen
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              comment,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
