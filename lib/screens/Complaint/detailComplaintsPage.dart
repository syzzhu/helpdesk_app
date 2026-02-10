import 'package:flutter/material.dart';
import 'package:helpdesk_app/model/complaints_model.dart'; // Pastikan import model betul
import 'package:helpdesk_app/screens/Complaint/acknowlegeComplaints.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import '../qr_scanner_page.dart';
import '../dashboard_page.dart';

class DetailComplaintsPage extends StatefulWidget {
  final Complaint complaint; // Guna objek model

  const DetailComplaintsPage({super.key, required this.complaint});

  @override
  State<DetailComplaintsPage> createState() => _DetailComplaintsPageState();
}

class _DetailComplaintsPageState extends State<DetailComplaintsPage> {
  String? selectedTerminal;
  String? selectedLocation;

  final List<String> terminalOptions = [
    'Terminal A',
    'Terminal B',
    'Terminal C',
    '2342',
  ];
  final List<String> locationOptions = [
    'Level 1',
    'Level 2',
    'Level 3',
    '11th Floor',
  ];
  @override
  void initState() {
    if (terminalOptions.contains(widget.complaint.terminalId)) {
      selectedTerminal = widget.complaint.terminalId;
    }

    if (locationOptions.contains(widget.complaint.location)) {
      selectedLocation = widget.complaint.location;
    }
  }

  // Fungsi pembantu untuk dapatkan warna secara dinamik
  Color _getStatusColor(String status) {
    status = status.toUpperCase();
    if (status == 'NEW') return Colors.redAccent;
    if (status == 'PENDING') return const Color.fromARGB(255, 243, 195, 72);
    return Colors.grey;
  }

  bool _shouldShowAcknowledgeButton() {
    if (widget.complaint.status.toUpperCase().trim() != 'NEW') {
      return false;
    }

    // FIX: Check if assignTo is null OR empty safely
    if (widget.complaint.assignTo == null ||
        widget.complaint.assignTo.isEmpty) {
      return true;
    }

    final hasUnacknowledged =
        widget.complaint.assignTo?.any(
          (assign) =>
              assign.status?.toUpperCase().trim() == 'NEW' ||
              assign.status?.toUpperCase().trim() == 'PENDING',
        ) ??
        false; // Jika assignTo null, dia akan return false
    return hasUnacknowledged;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final complaint = widget.complaint; // Mudahkan akses data

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: size.height * 0.05, bottom: 25),
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
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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

          // --- TICKET ID BAR (Warna Dinamik Ada Di Sini) ---
          Center(
            child: Container(
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        // MENGGUNAKAN WARNA DINAMIK DARI JSON
                        color: _getStatusColor(complaint.status),
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
                        complaint.taskId, // ID DARI JSON
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // CONTENT
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildModernLabel("CONTACT PERSON"),
                _buildCleanBox(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Biar avatar maintain kat atas
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue.shade50,
                            // Jika ada image dari JSON, boleh guna NetworkImage di sini nanti
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
                                // NAMA PEMOHON
                                Text(
                                  complaint.name.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // UNIT
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
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                // NOMBOR TELEFON
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
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _buildModernLabel("TICKET INFORMATION"),
                _buildCleanBox(
                  child: Column(
                    children: [
                      // --- KOTAK INFO MASALAH ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.blueGrey.withOpacity(0.05),
                          ),
                        ),
                        child: Column(
                          children: [
                            // 1. CATEGORY BADGE
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
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ),

                            // 2. GARIS PEMISAH HALUS (Antara Category & Description)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Divider(
                                height: 1,
                                thickness: 1.5,
                                indent: 0,
                                endIndent: 0,
                                color: Colors.blueGrey.withOpacity(0.2),
                              ),
                            ),

                            // 3. PROBLEM DETAIL (DESCRIPTION)
                            Text(
                              complaint.problemDetail,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 25, 25, 26),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // DROPBOWN UNTUK TERMINAL & LOKASI
                      _buildDropdownRow(
                        label: "TERMINAL :",
                        selectedValue:
                            selectedTerminal, // Guna variable yang kita dah set dlm initState
                        options: terminalOptions,
                        onChanged: (val) =>
                            setState(() => selectedTerminal = val),
                      ),
                      const SizedBox(height: 5),

                      // --- DROPBOWN UNTUK LOCATION ---
                      _buildDropdownRow(
                        label: "LOCATION :",
                        selectedValue:
                            selectedLocation, // Guna variable yang kita dah set dlm initState
                        options: locationOptions,
                        onChanged: (val) =>
                            setState(() => selectedLocation = val),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                if (_shouldShowAcknowledgeButton())
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Acknowlegecomplaints(
                            complaint: widget.complaint, // HANTAR OBJEK PENUH
                            terminal: selectedTerminal,
                            location: selectedLocation,
                          ),
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
                      "DETAILS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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

  // --- RE-USE WIDGETS AND HELPERS ---
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

/*Widget _buildTechnicalRow(String status, String name) {
   return Row(
     children: [
       Container(
         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
         decoration: BoxDecoration(
             color: Colors.redAccent,
             borderRadius: BorderRadius.circular(6)),
         child: Text(status,
             style:
                 const TextStyle(color: Colors.white, fontSize: 10)),
       ),
       const SizedBox(width: 10),
       Expanded(
         child: Text(name,
             style:
                 const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
       ),
     ],
   );
 }*/

/*Widget _buildDropdownRow(String label) {
   return Row(
     children: [
       Container(
         width: 80,
         padding: const EdgeInsets.all(5),
         decoration: BoxDecoration(
           color: Colors.grey[400],
           border: Border.all(color: Colors.grey),
         ),
         child: Text(
           label,
           style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
         ),
       ),
       const SizedBox(width: 10),
       Expanded(
         child: Container(
           padding: const EdgeInsets.all(5),
           decoration: BoxDecoration(
             color: Colors.grey[400],
             border: Border.all(color: Colors.grey),
           ),
           child: const Text(
             "- PLEASE SELECT -",
             style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
           ),
         ),
       ),
     ],


   );
 }*/

Widget _buildDropdownRow({
  required String label,
  required String? selectedValue,
  required List<String> options,
  required Function(String?) onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        // Label Section - Dibuat lebih kemas tanpa kotak kelabu tebal
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

        // Dropdown Section - Menggunakan background putih & border halus
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: (options.contains(selectedValue)) ? selectedValue : null,
                isExpanded: true,
                hint: const Text(
                  "Select Option",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                // Safety check: Pastikan options tidak null sebelum .map
                items: options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    ),
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
