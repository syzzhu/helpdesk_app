import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // --- HEADER ---
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(color: Color(0xFF00AEEF)),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                const Icon(Icons.chat_bubble, size: 30, color: Colors.white),
                const SizedBox(width: 10),
                const Text(
                  'Comments',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // --- TICKET ID SECTION ---
          Container(
            color: Colors.grey[300],
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  color: Colors.red,
                  child: const Text(
                    'New',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), // Status Box
                const Expanded(
                  child: Text(
                    'H202601141050510002',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),

          // --- LIST OF COMMENTS (EXPANDABLE) ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ExpansionTile(
                    // Bahagian yang sentiasa nampak
                    leading: const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: const Text(
                      'NORIZAN BINTI MOHD YUSOF',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    subtitle: const Text(
                      'Tap to read more...', // Hint untuk user
                      style: TextStyle(fontSize: 11),
                    ),
                    trailing: const Text('14 Jan'),

                    // Bahagian yang akan keluar bila ditekan (Besar ke bawah)
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Please Check the ticket. Saya dah hantar laporan tapi belum ada respon. Mohon pihak teknikal datang ke meja saya secepat mungkin untuk check sistem. Terima kasih!!',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),

                // Contoh Card 2
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ExpansionTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: const Text('System Admin'),
                    subtitle: const Text(
                      'Tap to view update',
                      style: TextStyle(fontSize: 11),
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Ticket has been assigned to technician. Status: In Progress.',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // --- NAVIGATION BAR BOTTOM ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.home, size: 35, color: Colors.grey),
                const Icon(
                  Icons.qr_code_scanner,
                  size: 45,
                  color: Colors.black,
                ), // Ikon QR
                const Icon(Icons.list_alt, size: 35, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
