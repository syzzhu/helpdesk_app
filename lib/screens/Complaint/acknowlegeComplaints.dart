import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/Complaint/complaints.dart';
import 'package:helpdesk_app/screens/Complaint/inventoryComplaints.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/comment_page.dart';
import 'package:helpdesk_app/screens/dashboard_page.dart';
import 'package:helpdesk_app/screens/qr_scanner_page.dart';

class Acknowlegecomplaints extends StatefulWidget {
  final String status;
  final String name;
  final String department;
  final String? terminal;
  final String? location;

  const Acknowlegecomplaints({
    super.key,
    required this.status,
    required this.name,
    required this.department,
    this.terminal,
    this.location,
  });

  @override
  State<Acknowlegecomplaints> createState() => _AcknowlegecomplaintsState();
}

class _AcknowlegecomplaintsState extends State<Acknowlegecomplaints> {
  String? selectedTerminal;
  String? selectedLocation;

  final List<String> terminalOptions = [
    'Terminal A',
    'Terminal B',
    'Terminal C',
  ];

  final List<String> locationOptions = ['Level 1', 'Level 2', 'Level 3'];

  @override
  void initState() {
    super.initState();
    // Jika value dihantar dari page sebelumnya dan wujud dalam list, gunakan
    selectedTerminal = terminalOptions.contains(widget.terminal)
        ? widget.terminal
        //: terminalOptions.first;
        : null;

    selectedLocation = locationOptions.contains(widget.location)
        ? widget.location
        : null;
        //: locationOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: size.height * 0.05, bottom: 25),
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
                      size: 35,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.description, color: Colors.white, size: 40),
                    SizedBox(width: 10),
                    Text(
                      'Acknowledge',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // STATUS BOX
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
                        color: widget.status.toUpperCase() == 'NEW'
                            ? Colors.redAccent
                            : (widget.status.toUpperCase() == 'PENDING'
                                  ? const Color.fromARGB(255, 243, 195, 72)
                                  : Colors.grey),
                      ),
                      child: Text(
                        widget.status.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'H202601141050510002',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // MAIN CONTENT
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildModernLabel("CONTACT PERSON"),
                _buildCleanBox(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.blue.shade50,
                        child: const Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              widget.department.toUpperCase(),
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(
                                  Icons.phone_rounded,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "0197777777",
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
                const SizedBox(height: 20),

                _buildModernLabel("TICKET INFORMATION"),
                _buildCleanBox(
                  child: Stack(
                    children: [
                      // ===== CONTENT ASAL =====
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  child: const Text(
                                    "INTERNET / WIRELESS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    "Can't access internet",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          /*const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Can't access internet",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),*/
                          _buildInfoRow(label: "TERMINAL :", value: selectedTerminal),
                          const SizedBox(height: 5),
                          _buildInfoRow(label: "LOCATION :", value: selectedLocation),

                        ],
                      ),

                      // ===== ICON ATAS, DALAM PUTIH =====
                      Positioned(
                        right: 14,
                        top: 13,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InventoryComplaintsPage(
                                  name: widget.name,
                                  department: widget.department,
                                  terminal: selectedTerminal ?? "-",
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

                const SizedBox(height: 30),

                _buildModernLabel("TECHNICAL PERSON"),
                _buildCleanBox(
                  padding: const EdgeInsets.all(12),
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
                                    CommentPage(status: widget.status),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTechnicalRow("NEW", "SHARIFFUDDIN BIN ALI BASHA"),
                      const SizedBox(height: 10),
                      _buildTechnicalRow("NEW", "MOHD NAZRIN BIN ABU HASSAN"),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComplaintsPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AEEF),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "FINISH",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

  // =================== WIDGET HELPERS ===================

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

  // Gantikan _buildDropdownRow dengan _buildInfoRow
Widget _buildInfoRow({required String label, String? value}) {
  return Row(
    children: [
      Container(
        width: 80,
        padding: const EdgeInsets.all(5),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[350],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value ?? "-",
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildTechnicalRow(String tag, String name) {
    return Row(
      children: [
        Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
