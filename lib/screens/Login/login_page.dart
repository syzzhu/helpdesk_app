import 'package:flutter/material.dart';
import '../dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscurePassword = true;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    if (_idController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your ID')),
      );
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
      return;
    }
    
    if (_idController.text == "admin" && _passwordController.text == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Error'),
        content: const Text('Wrong ID or Password. Please try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Dapatkan maklumat skrin
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final bool isTablet = screenWidth > 600;

    // Skala dinamik (Base on iPhone 12 width 390)
    double scale = screenWidth / 390;
    if (isTablet) scale = 1.2; // Limit skala untuk tablet supaya tak terlalu besar

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column( // Guna Column supaya Logo dan Content tak bertindih
          children: [
            // LOGO SECTION (Top Left)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/bernama_logo.webp', 
                    height: 40 * scale,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.business, size: 40),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Bernama',
                    style: TextStyle(
                      fontSize: 18 * scale, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),

            // CONTENT SECTION
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? screenWidth * 0.2 : 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HelpDesk\nLogin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36 * scale, 
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.06),

                      // Input ID
                      _buildLabel('ID', scale),
                      const SizedBox(height: 8),
                      _buildTextField(_idController, 'ID', false, scale),

                      const SizedBox(height: 20),

                      // Input Password
                      _buildLabel('PASSWORD', scale),
                      const SizedBox(height: 8),
                      _buildTextField(
                        _passwordController, 
                        'Password', 
                        obscurePassword, 
                        scale,
                        suffix: IconButton(
                          icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => obscurePassword = !obscurePassword),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 55 * scale,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00AEEF),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _handleLogin,
                          child: Text(
                            'LOG IN',
                            style: TextStyle(
                              fontSize: 16 * scale,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                      // Beri sedikit ruang bawah untuk peranti skrin pendek
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk kurangkan kod berulang
  Widget _buildLabel(String text, double scale) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 12 * scale,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, bool obscure, double scale, {Widget? suffix}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(fontSize: 14 * scale),
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}