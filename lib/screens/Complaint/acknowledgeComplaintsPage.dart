import 'package:flutter/material.dart';
import 'package:helpdesk_app/model/complaints_model.dart';
import 'package:helpdesk_app/screens/Complaint/detailComplaints.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import '../qr_scanner_page.dart';
import '../dashboard_page.dart';

class DetailComplaintsPage extends StatefulWidget {
  final Complaint complaint;

  const DetailComplaintsPage({super.key, required this.complaint});

  @override
  State<DetailComplaintsPage> createState() => _DetailComplaintsPageState();
}

class _DetailComplaintsPageState extends State<DetailComplaintsPage> {
  String? selectedTerminal;
  String? selectedLocation;

  final List<String> terminalOptions = ['Terminal A', 'Terminal B', 'Terminal C', '2342'];
  final List<String> locationOptions = ['Level 1', 'Level 2', 'Level 3', '11th Floor'];

  @override
  void initState() {
    super.initState();
    if (terminalOptions.contains(widget.complaint.terminalId)) {
      selectedTerminal = widget.complaint.terminalId;
    }
    if (locationOptions.contains(widget.complaint.location)) {
      selectedLocation = widget.complaint.location;
    }
  }

  Color _getStatusColor(String status) {
    status = status.toUpperCase();
    if (status == 'NEW') return Colors.redAccent;
    if (status == 'PENDING') return const Color.fromARGB(255, 243, 195, 72);
    return Colors.grey;
  }

  bool _shouldShowAcknowledgeButton() {
    if (widget.complaint.status.toUpperCase().trim() != 'NEW') return false;
    if (widget.complaint.assignTo == null || widget.complaint.assignTo!.isEmpty) return true;
    return widget.complaint.assignTo!.any(
      (assign) =>
          assign.status?.toUpperCase().trim() == 'NEW' ||
          assign.status?.toUpperCase().trim() == 'PENDING',
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- Contoh tweak responsive ---
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
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: screenHeight * 0.05, bottom: 15 * scaleH),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF00AEEF), Color(0xFF0089BB)]),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: avatarRadius * 0.7),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description, color: Colors.white, size: avatarRadius * 1.2),
                    SizedBox(width: 15 * scaleW),
                    Text(
                      'Acknowledge',
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
          SizedBox(height: 15 * scaleH),

          // STATUS & TASK ID
          Center(
            child: Container(
              width: screenWidth * 0.9,
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
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          //fontSize: fontSmall,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        complaint.taskId,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15 * scaleH),

          // CONTENT
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20 * scaleW),
              children: [
                _buildModernLabel("CONTACT PERSON", fontSmall),
                _buildCleanBox(
                  padding: EdgeInsets.all(15 * scaleH),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(Icons.person, color: Colors.blue, size: avatarRadius * 0.8),
                      ),
                      SizedBox(width: 15 * scaleW),
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
                            SizedBox(height: 15 * scaleH / 2),
                            Row(
                              children: [
                                Icon(Icons.business, size: fontSmall, color: Colors.grey),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    complaint.units.toUpperCase(),
                                    style: TextStyle(color: Colors.grey[700], fontSize: fontSmall),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15 * scaleH / 2),
                            Row(
                              children: [
                                Icon(Icons.phone, size: fontSmall, color: Colors.green),
                                SizedBox(width: 5),
                                Text(
                                  complaint.hp,
                                  style: TextStyle(color: Colors.grey, fontSize: fontSmall),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15 * scaleH),
                _buildModernLabel("TICKET INFORMATION", fontSmall),
                _buildCleanBox(
                  padding: EdgeInsets.all(15 * scaleH),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15 * scaleH, horizontal: 20 * scaleW),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.blueGrey.withOpacity(0.05)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10 * scaleW, vertical: 5 * scaleH),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0EA5E9).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                complaint.category.toUpperCase(),
                                style: TextStyle(
                                  color: const Color(0xFF0284C7),
                                  fontWeight: FontWeight.w900,
                                  fontSize: fontSmall,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15 * scaleH),
                              child: Divider(
                                height: 1,
                                thickness: 1.5,
                                color: Colors.blueGrey.withOpacity(0.2),
                              ),
                            ),
                            Text(
                              complaint.problemDetail,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: fontSmall, color: const Color(0xFF191919)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15 * scaleH),

                      // TERMINAL & LOCATION DROPDOWN
                      _buildDropdownRow(
                        label: "TERMINAL :",
                        selectedValue: selectedTerminal,
                        options: terminalOptions,
                        fontSize: fontSmall,
                        onChanged: (val) => setState(() => selectedTerminal = val),
                      ),
                      SizedBox(height: 15 * scaleH),
                      _buildDropdownRow(
                        label: "LOCATION :",
                        selectedValue: selectedLocation,
                        options: locationOptions,
                        fontSize: fontSmall,
                        onChanged: (val) => setState(() => selectedLocation = val),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15 * scaleH * 3),

               if (_shouldShowAcknowledgeButton())
                Padding(
                  padding: EdgeInsets.fromLTRB(15 * scaleW, 10 * scaleH, 15 * scaleW, 20 * scaleH), // 20 untuk jarak bawah
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Acknowlegecomplaints(
                            complaint: complaint,
                            terminal: selectedTerminal,
                            location: selectedLocation,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00AEEF),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, buttonHeight),
                      elevation: 5, // Tambah sedikit bayang supaya nampak timbul
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text(
                      "DETAILS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: fontTitle,
                        letterSpacing: 1.5, // Biar teks DETAILS nampak luas sikit
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
}

// --- WIDGET HELPERS ---
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

Widget _buildCleanBox({required Widget child, EdgeInsets? padding}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
    ),
    clipBehavior: Clip.hardEdge,
    child: child,
  );
}

// --- RESPONSIVE DROPDOWN ROW ---
Widget _buildDropdownRow({
  required String label,
  required String? selectedValue,
  required List<String> options,
  required Function(String?) onChanged,
  double fontSize = 14,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double labelWidth = constraints.maxWidth * 0.3;
      double dropdownWidth = constraints.maxWidth - labelWidth - 10;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: labelWidth,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey.shade700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: dropdownWidth,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: options.contains(selectedValue) ? selectedValue : null,
                    isExpanded: true,
                    hint: Text(
                      "Select Option",
                      style: TextStyle(fontSize: fontSize * 0.9, color: Colors.grey),
                    ),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                    items: options
                        .map(
                          (opt) => DropdownMenuItem(
                            value: opt,
                            child: Text(
                              opt,
                              style: TextStyle(
                                  fontSize: fontSize * 0.95,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1E293B)),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
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
