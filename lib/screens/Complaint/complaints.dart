import 'package:flutter/material.dart';
import 'package:helpdesk_app/model/complaints_model.dart';
import 'acknowledgeComplaintsPage.dart';
import '../dashboard_page.dart';
import '../qr_scanner_page.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/Complaint/detailComplaints.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<ComplaintsPage> {
  TextEditingController searchController = TextEditingController();
  List<Complaint> allData = [];
  List<Complaint> filteredData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    var rawJson = [
      {
        "id": 6982,
        "task_id": "H202601300955310037",
        "task_type": "H",
        "problem_detail": "Printer Problem\r\n\r\nintest: mubin",
        "ticket_status": "PENDING",
        "name": "WAN NOR AZRIYANA BINTI WAN ALI",
        "terminal_id": "2333",
        "description": "<b>PRINTER / SCANNER</b>",
        "location": "11th Floor",
        "units": "UNIT PENGURUSAN PENGETAHUAN",
        "hp": "014 2615580",
        "assign_to": [
          {"name": "SHARIFFUDDIN BIN ALI BASHA", "status": "PENDING"},
          {"name": "MOHD NAZRIN BIN ABU HASSAN", "status": "NEW"},
        ],
      },
      {
        "id": 6983,
        "task_id": "H202601301020440099",
        "problem_detail": "Internet slow\r\n\r\nurgent",
        "ticket_status": "NEW",
        "name": "KAMAL AZUDIN BIN MD.YUSOF",
        "terminal_id": "1010",
        "description": "<b>INTERNET / WIRELESS</b>",
        "location": "15th Floor",
        "units": "UNIT TEKNOLOGI MAKLUMAT",
        "hp": "019 1234567",
        "assign_to": [
          {"name": "SHARIFFUDDIN BIN ALI BASHA", "status": "NEW"},
          {"name": "MOHD NAZRIN BIN ABU HASSAN", "status": "NEW"},
        ],
      },
    ];

    setState(() {
      allData = rawJson.map((item) => Complaint.fromJson(item)).toList();
      filteredData = allData;
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'NEW': return const Color(0xFFB73C3C);
      case 'PENDING': return Colors.orange;
      case 'COMPLETED': return Colors.green;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          bool isTablet = screenWidth > 600;
          double contentWidth = isTablet ? screenWidth * 0.95 : screenWidth;

          return Column(
            children: [
              // --- HEADER  ---
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  // Mengikut 'notch' telefon secara automatik
                  top: MediaQuery.of(context).padding.top + 15,
                  bottom: isTablet ? 45 : 30,
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
                    // Bahagian Icon & Tajuk
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.report, 
                          // Saiz ikon membesar mengikut lebar skrin secara terkawal
                          size: (screenWidth * 0.08).clamp(28.0, 42.0), 
                          color: Colors.white
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Complaints',
                          style: TextStyle(
                            // Saiz fon dinamik
                            fontSize: (screenWidth * 0.07).clamp(22.0, 34.0),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Search Bar yang lebih fleksibel
                    Padding(
                      padding: EdgeInsets.symmetric(
                        // Margin kiri/kanan lebih besar pada tablet supaya bar tak terlalu panjang
                        horizontal: isTablet ? (screenWidth * 0.15) : 20
                      ),
                      child: Container(
                        // Tinggi bar mengikut kesesuaian peranti
                        height: (screenWidth * 0.12).clamp(45.0, 60.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Center( // Center supaya teks berada di tengah secara vertikal
                          child: TextField(
                            controller: searchController,
                            textAlignVertical: TextAlignVertical.center, // Teks input sentiasa di tengah
                            onChanged: (value) {
                              setState(() {
                                filteredData = allData.where((item) =>
                                    item.name.toLowerCase().contains(value.toLowerCase()) ||
                                    item.category.toLowerCase().contains(value.toLowerCase())).toList();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search name / type',
                              hintStyle: TextStyle(fontSize: (screenWidth * 0.035).clamp(13.0, 16.0)),
                              prefixIcon: Icon(Icons.search, size: (screenWidth * 0.05).clamp(20.0, 26.0)),
                              border: InputBorder.none,
                              isDense: true, // Padatkan ruang dalaman
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- LIST CARDS (Struktur Operation) ---
              Expanded(
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        return _buildComplaintCard(filteredData[index], isTablet);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildComplaintCard(Complaint item, bool isTablet) {
    double scale = isTablet ? 1.2 : 1.0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(isTablet ? 30 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: InkWell( // Menggantikan GestureDetector supaya ada kesan ripple
        onTap: () {
          bool isAnyPending = item.assignTo?.any((a) => a.status.toUpperCase() == 'PENDING') ?? false;
          if (isAnyPending || item.status.toUpperCase() == 'PENDING') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Acknowlegecomplaints(
              complaint: item, terminal: item.terminalId, location: item.location)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailComplaintsPage(complaint: item)));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildChip(item.category, Colors.blue.shade50, Colors.blue.shade700, scale),
                _buildChip(item.status, _getStatusColor(item.status).withOpacity(0.1), _getStatusColor(item.status), scale),
              ],
            ),
            const SizedBox(height: 25),
            // Row Profile
            Row(
              children: [
                CircleAvatar(
                  radius: isTablet ? 35 : 25,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person_rounded, size: isTablet ? 35 : 25, color: Colors.grey),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isTablet ? 20 : 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        item.location.toUpperCase(),
                        style: TextStyle(
                          fontSize: isTablet ? 15 : 13,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            // Description Box
            Container(
              padding: EdgeInsets.symmetric(vertical: isTablet ? 25 : 18, horizontal: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                item.problemDetail,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color bg, Color text, double scale) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10 * scale),
      ),
      child: Text(
        label,
        style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 10 * scale),
      ),
    );
  }

  // Bottom Navigation Bar (Sama seperti kod anda)
  Widget _buildBottomNavigationBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: isTablet ? 40 : 0),
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

  Widget _buildNavItem(BuildContext context, IconData icon, String label, {Widget? destination, double iconSize = 28, double fontSize = 11}) {
    return InkWell(
      onTap: () { if (destination != null) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination)); },
      child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: iconSize, color: Colors.grey), Text(label, style: TextStyle(fontSize: fontSize, color: Colors.grey))]),
    );
  }

  Widget _buildQRItem(BuildContext context, {double iconSize = 30}) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerPage())),
      child: Container(padding: EdgeInsets.all(iconSize * 0.4), decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle), child: Icon(Icons.qr_code_scanner, color: Colors.white, size: iconSize)),
    );
  }
}