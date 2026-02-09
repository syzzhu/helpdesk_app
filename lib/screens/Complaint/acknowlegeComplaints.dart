import 'package:flutter/material.dart';
import 'package:helpdesk_app/model/complaints_model.dart';
import 'package:helpdesk_app/screens/Complaint/complaints.dart';
import 'package:helpdesk_app/screens/Complaint/inventoryComplaints.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/comment_page.dart';
import 'package:helpdesk_app/screens/dashboard_page.dart';
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
 // Get color based on status
 Color _getStatusColor(String status) {
   status = status.toUpperCase();
   if (status == 'NEW') return Colors.redAccent;
   if (status == 'PENDING') return const Color.fromARGB(255, 243, 195, 72);
   return Colors.grey;
 }


 @override
 Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
   final item = widget.complaint;


   return Scaffold(
     backgroundColor: const Color(0xFFF8FAFC),
     body: Column(
       children: [
         // --- HEADER ---
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
                   Icon(Icons.assignment_turned_in, color: Colors.white, size: 40),
                   SizedBox(width: 10),
                   Text(
                     'Details',
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


         // --- TICKET ID BAR ---
         Center(
           child: Container(
             width: size.width * 0.9,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(12),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.05),
                   blurRadius: 10,
                 ),
               ],
             ),
             child: ClipRRect(
               borderRadius: BorderRadius.circular(12),
               child: Row(
                 children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                     color: _getStatusColor(item.status),
                     child: Text(
                       item.status.toUpperCase(),
                       style: const TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                   Expanded(
                     child: Text(
                       item.taskId,
                       textAlign: TextAlign.center,
                       style: const TextStyle(fontWeight: FontWeight.bold),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ),
         const SizedBox(height: 20),


         // --- CONTENT ---
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
                       child: const Icon(Icons.person, color: Colors.blue),
                     ),
                     const SizedBox(width: 15),
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             item.name.toUpperCase(),
                             style: const TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 13,
                             ),
                           ),
                           Text(
                             item.location.toUpperCase(),
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
                             children: [
                               Container(
                                 padding: const EdgeInsets.all(12),
                                 decoration: BoxDecoration(
                                   color: Colors.grey[350],
                                   borderRadius: BorderRadius.circular(10),
                                 ),
                                 child: Text(
                                   item.category,
                                   textAlign: TextAlign.center,
                                   style: const TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 12,
                                   ),
                                 ),
                               ),
                               const SizedBox(height: 8),
                               Text(
                                 item.problemDetail,
                                 textAlign: TextAlign.center,
                                 style: const TextStyle(
                                   fontSize: 15,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ],
                           ),
                         ),
                         const SizedBox(height: 12),
                         _buildInfoRow(
                           label: "TERMINAL :",
                           value: widget.terminal,
                         ),
                         const SizedBox(height: 5),
                         _buildInfoRow(
                           label: "LOCATION :",
                           value: widget.location,
                         ),
                       ],
                     ),
                     Positioned(
                       right: 0,
                       top: 0,
                       child: IconButton(
                         icon: const Icon(
                           Icons.inventory_2_rounded,
                           color: Color(0xFF0089BB),
                           size: 22,
                         ),
                         onPressed: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => InventoryComplaintsPage(
                                 complaint: item,
                               ),
                             ),
                           );
                         },
                       ),
                     ),
                   ],
                 ),
               ),
               const SizedBox(height: 20),


               _buildModernLabel("TECHNICAL PERSON"),
               _buildCleanBox(
                 child: Column(
                   children: [
                     Align(
                       alignment: Alignment.centerRight,
                       child: IconButton(
                         icon: const Icon(Icons.chat_bubble_outline_rounded),
                         onPressed: () => Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => CommentPage(status: item.status),
                           ),
                         ),
                       ),
                     ),
                     _buildTechnicalRow("NEW", "SHARIFFUDDIN BIN ALI BASHA"),
                     const SizedBox(height: 10),
                     _buildTechnicalRow("NEW", "MOHD NAZRIN BIN ABU HASSAN"),
                   ],
                 ),
               ),
               const SizedBox(height: 35),


               ElevatedButton(
                 onPressed: () {
                   Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(builder: (context) => const ComplaintsPage()),
                     (route) => false,
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


         // --- BOTTOM NAVIGATION ---
         _buildBottomNavigationBar(context),
       ],
     ),
   );
 }


 // --- HELPERS ---
 Widget _buildModernLabel(String text) {
   return Padding(
     padding: const EdgeInsets.only(left: 5, bottom: 10),
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
         width: 80,
         child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
       ),
       const SizedBox(width: 10),
       Expanded(
         child: Container(
           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
           decoration: BoxDecoration(
             color: Colors.grey[350],
             borderRadius: BorderRadius.circular(4),
           ),
           child: Text(value ?? "-", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
         ),
       ),
     ],
   );
 }


 Widget _buildTechnicalRow(String tag, String name) {
   return Row(
     children: [
       Container(
         width: 70,
         padding: const EdgeInsets.symmetric(vertical: 8),
         decoration: BoxDecoration(
           color: Colors.redAccent,
           borderRadius: BorderRadius.circular(4),
         ),
         alignment: Alignment.center,
         child: Text(tag, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
       ),
       const SizedBox(width: 10),
       Expanded(
         child: Container(
           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
           decoration: BoxDecoration(
             color: Colors.grey[200],
             borderRadius: BorderRadius.circular(4),
           ),
           child: Text(name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
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
         _buildNavItem(context, Icons.home_outlined, "Home", destination: const DashboardPage()),
         _buildQRItem(context),
         _buildNavItem(context, Icons.list_alt_rounded, "Options", destination: const ListOptionsPage()),
       ],
     ),
   );
 }


 Widget _buildNavItem(BuildContext context, IconData icon, String label, {Widget? destination}) {
   return InkWell(
     onTap: () {
       if (destination != null) {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
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
     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerPage())),
     child: Container(
       padding: const EdgeInsets.all(12),
       decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
       child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
     ),
   );
 }
}
