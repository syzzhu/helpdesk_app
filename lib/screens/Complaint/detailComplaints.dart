import 'package:flutter/material.dart';
import 'package:helpdesk_app/model/complaints_model.dart';
import 'package:helpdesk_app/screens/Complaint/complaints.dart';
import 'package:helpdesk_app/screens/Complaint/inventoryComplaints.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/comment_page.dart';
import 'package:helpdesk_app/screens/dashboard_page.dart';
import 'package:helpdesk_app/screens/inventory.dart';
import 'package:helpdesk_app/screens/qr_scanner_page.dart';

class Acknowlegecomplaints extends StatefulWidget {
  final Complaint complaint;
  final String? terminal;
  final String? location;

  const Acknowlegecomplaints({
    super.key,
    required this.complaint,
    this.terminal,
    this.location,
  });

  @override
  State<Acknowlegecomplaints> createState() => _AcknowlegecomplaintsState();
}

class _AcknowlegecomplaintsState extends State<Acknowlegecomplaints> {
  // Helper warna status
  Color _getStatusColor(String status) {
    status = status.toUpperCase();
    if (status == 'NEW') return Colors.redAccent;
    if (status == 'PENDING') return const Color.fromARGB(255, 243, 195, 72);
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    // Clamp font & sizes supaya phone tak gila besar
    final scaleW = screenWidth / 375; // base iPhone 11 width
    final scaleH = screenHeight / 812;
    final fontTitle = (screenWidth * 0.035).clamp(14.0, 22.0); // max 22, min 14
    final fontSmall = (screenWidth * 0.020).clamp(11.0, 16.0);
    final avatarRadius = (screenWidth * 0.07).clamp(20.0, 40.0);
    final buttonHeight = (screenHeight * 0.065).clamp(45.0, 70.0);

    final complaint = widget.complaint;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: screenHeight * 0.05, bottom: 15 * scaleH),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00AEEF), Color(0xFF0089BB)],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.description, color: Colors.white, size: 35),
                    const SizedBox(width: 10),
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 36,
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
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18 * scaleW,
                        vertical: 12 * scaleH,
                      ),
                      decoration: BoxDecoration(
                        color: complaint.status.toUpperCase() == 'NEW'
                            ? Colors.redAccent
                            : (complaint.status.toUpperCase() == 'PENDING'
                                ? const Color.fromARGB(255, 243, 195, 72)
                                  : Colors.grey),
                        ),
                      child: Text(
                        complaint.status.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${complaint.taskId}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- SCROLLABLE CONTENT ---
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20 * scaleW, vertical: 15 * scaleH),
              children: [
                _buildModernLabel("CONTACT PERSON", fontSmall),
                _buildCleanBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              complaint.name.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontTitle,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.business,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    complaint.units.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: fontSmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  complaint.hp,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: fontSmall,
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

                _buildModernLabel("TICKET INFORMATION", fontSmall),
                _buildCleanBox(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.blueGrey.withOpacity(0.05),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0EA5E9).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    complaint.category.toUpperCase(),
                                    style: const TextStyle(
                                      color: Color(0xFF0284C7),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.blueGrey.withOpacity(0.1),
                                  ),
                                ),
                                Text(
                                  complaint.problemDetail,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow(
                            label: "TERMINAL :",
                            value: widget.terminal,
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            label: "LOCATION :",
                            value: widget.location,
                          ),
                        ],
                      ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InventoryPage(
                                      name: complaint.name, // Tambah 'widget.'
                                      department:
                                          complaint.department, // Tambah 'widget.'
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.inventory_2_rounded,
                                  color: Color(0xFF0089BB),
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _buildModernLabel("TECHNICAL PERSON", fontSmall),
                _buildCleanBox(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Colors.blueGrey,
                            size: 20,
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CommentPage(status: complaint.status),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (complaint.assignTo == null || complaint.assignTo!.isEmpty)
                        const Text(
                          "No technician assigned",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      else
                        ...complaint.assignTo!.map((assign) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _buildTechnicalRow(
                              assign.status?.toUpperCase() ?? "UNKNOWN",
                              assign.name.toUpperCase(),
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 35),

                // Button Finish
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0EA5E9).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ComplaintsPage(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0EA5E9),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, buttonHeight),
                      elevation: 0, //shadow 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "FINISH",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontTitle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomNavigationBar(context),
        ],
      ),
    );
  }

  // --- HELPERS ---
  Widget _buildModernLabel(String text, double fontSize) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, bottom: 10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: const Color(0xFF64748B), borderRadius: BorderRadius.circular(4)),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold)),
      ),
    ),
  );
}

  Widget _buildCleanBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12),
        ],
      ),
      child: child,
    );
  }

  Widget _buildInfoRow({required String label, String? value}) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey.shade700,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value ?? "-",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTechnicalRow(String tag, String name) {
    Color statusColor;
    if (tag == "NEW") {
      statusColor = Colors.redAccent;
    } else if (tag == "PENDING") {
      statusColor = const Color.fromARGB(255, 243, 195, 72);
    } else {
      statusColor = Colors.grey;
    }

    return Row(
      children: [
        Container(
          width: 75,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF334155),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        color: Colors.white,
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
            destination: const ListOptionsPage(),
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
