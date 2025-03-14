import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text == "1" && _passwordController.text == "1") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username atau password salah!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              color: Colors.blue[900],
              height: 120,
              alignment: Alignment.center,
              child: Text("Koperasi Undiksha", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            Image.asset('assets/logo.png', width: 120, height: 120),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                _inputField("Username", _usernameController),
                SizedBox(height: 10),
                _inputField("Password", _passwordController, obscureText: true),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: _login,
                  child: Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ]),
            ),
          ]),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text("Copyright © 2025 Koperasi Undiksha", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue[900]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(10)),
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Koperasi Undiksha"), backgroundColor: Colors.blue[900], actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(children: [
                ClipOval(
                  child: Image.network('https://example.com/profile.jpg', width: 80, height: 80, fit: BoxFit.cover),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Nasabah", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("I Ketut Resika Arthana"),
                    SizedBox(height: 5),
                    Text("Total Saldo Anda", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Rp. 1.200.000"),
                  ]),
                ),
              ]),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: [
                _menuItem(Icons.account_balance_wallet, "Cek Saldo"),
                _menuItem(Icons.sync_alt, "Transfer"),
                _menuItem(Icons.account_balance, "Deposito"),
                _menuItem(Icons.payment, "Pembayaran"),
                _menuItem(Icons.monetization_on, "Peminjaman"),
                _menuItem(Icons.history, "Mutasi"),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "QR Code"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: Colors.blue),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12))
        ],
      ),
    );
  }
}
