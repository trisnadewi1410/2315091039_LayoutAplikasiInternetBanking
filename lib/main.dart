import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const KoperasiApp());
}

// User model to store account information
class User {
  final String username;
  final String name;
  double balance;
  List<Transaction> transactions;

  User({
    required this.username, 
    required this.name, 
    this.balance = 5200000000.0,
    this.transactions = const [],
  });
}

// Transaction model to track account activities
class Transaction {
  final DateTime date;
  final String type;
  final double amount;
  final String description;

  Transaction({
    required this.date,
    required this.type,
    required this.amount,
    required this.description,
  });
}

class KoperasiApp extends StatelessWidget {
  const KoperasiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koperasi Undiksha',
      theme: ThemeData(
        primaryColor: const Color(0xFF1A237E),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF1A237E),
          secondary: const Color(0xFF1565C0),
        ),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Hardcoded user for demonstration
  final User _user = User(
    username: "2315091039", 
    name: "Ni Komang Ayu Trisna"
  );

  void _login() {
    if (_usernameController.text == _user.username && 
        _passwordController.text == "2315091039") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainMenuScreen(user: _user)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _buildStatusBar(),
              Container(
                color: Colors.blue[900],
                height: 120,
                alignment: Alignment.center,
                child: const Text(
                  "Koperasi Undiksha",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Image.network(
                'https://raw.githubusercontent.com/trisnadewi1410/Trisna-PersonalWebsite/main/img/logo.png.png',
                width: 120,
                height: 120,
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTextField("Username", _usernameController, false),
                    const SizedBox(height: 10),
                    _buildTextField("Password", _passwordController, true),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          minimumSize: const Size(150, 45),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: _login,
                        child: const Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text("Daftar Mbanking", style: TextStyle(color: Colors.blue)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Lupa Password?", style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Copyright © 2025 Koperasi Undiksha",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      height: 20,
      color: Colors.blue[900],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool obscure) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue[900]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
      ],
    );
  }
}

class MainMenuScreen extends StatefulWidget {
  final User user;

  const MainMenuScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            _buildStatusBar(),
            _buildAppBar(context),
            _buildUserInfoCard(),
            _buildMenuGrid(context),
            _buildHelpSection(),
            _buildBottomNavigation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: const Color(0xFF1A237E),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40),
          const Text(
            'Koperasi Undiksha',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://raw.githubusercontent.com/trisnadewi1410/Trisna-PersonalWebsite/main/img/foto1.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoContainer('Nasabah\n${widget.user.name}'),
                const SizedBox(height: 5),
                _buildInfoContainer('Total Saldo Anda\n${_formatCurrency(widget.user.balance)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xFFE3E3F5),
      width: double.infinity,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMenuButton(Icons.book, 'Cek Saldo', () => _showBalanceDialog()),
              _buildMenuButton(Icons.send_to_mobile, 'Transfer', () => _showTransferDialog()),
              _buildMenuButton(Icons.account_balance_wallet, 'Deposito', () => _showDepositoDialog()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMenuButton(Icons.payment, 'Pembayaran', () => _showPaymentDialog()),
              _buildMenuButton(Icons.monetization_on, 'Pinjaman', () => _showLoanDialog()),
              _buildMenuButton(Icons.analytics, 'Mutasi', () => _showTransactionHistory()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildHelpSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Butuh Bantuan?'),
                Text(
                  '0812-5959-2736',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.phone,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomButton(Icons.settings, 'Setting', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
            }),
            _buildQRButton(),
            _buildBottomButton(Icons.person, 'Profile', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(user: widget.user)));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildQRButton() {
    String qrCodeUrl = 'https://raw.githubusercontent.com/trisnadewi1410/Trisna-PersonalWebsite/main/img/THCzRd_qrcode.png';
String qrData = 
  "000201010212"
  "26660016ID.COM"
  "0118936009151234567890123456" 
  "0215MID987654321" 
  "52040000" 
  "5303360"
  "5406100000" 
  "5802ID" 
  "5913Trisna" 
  "6013Amlapura" 
  "6304ABCD"; 
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QRCodeScreen(data: qrData, qrCodeUrl: qrCodeUrl)));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A237E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.qr_code,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          const Text('QR Code'),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      height: 20,
      color: Colors.blue[900],
    );
  }

  // Utility method to format currency
  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'id_ID', 
      symbol: 'Rp. ', 
      decimalDigits: 0
    ).format(amount);
  }

  // Dialog for checking balance
  void _showBalanceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cek Saldo'),
          content: Text('Saldo Anda saat ini: ${_formatCurrency(widget.user.balance)}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Dialog for fund transfer
  void _showTransferDialog() {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController accountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Transfer Dana'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: accountController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Rekening Tujuan',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Transfer',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0;
                if (amount > 0 && amount <= widget.user.balance) {
                  setState(() {
                    widget.user.balance -= amount;
                    widget.user.transactions.add(
                      Transaction(
                        date: DateTime.now(),
                        type: 'Transfer',
                        amount: amount,
                        description: 'Transfer ke ${accountController.text}',
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Transfer berhasil: ${_formatCurrency(amount)}')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Jumlah transfer tidak valid')),
                  );
                }
              },
              child: const Text('Transfer'),
            ),
          ],
        );
      },
    );
  }

  // Dialog for deposit
  void _showDepositoDialog() {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deposito'),
          content: TextField(
            controller: amountController,
            decoration: const InputDecoration(
              labelText: 'Jumlah Deposito',
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0;
                if (amount > 0) {
                  setState(() {
                    widget.user.balance += amount;
                    widget.user.transactions.add(
                      Transaction(
                        date: DateTime.now(),
                        type: 'Deposito',
                        amount: amount,
                        description: 'Deposito Baru',
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Deposito berhasil: ${_formatCurrency(amount)}')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Jumlah deposito tidak valid')),
                  );
                }
              },
              child: const Text('Deposito'),
            ),
          ],
        );
      },
    );
  }

  // Dialog for payments
  void _showPaymentDialog() {
    final TextEditingController amountController = TextEditingController();
    final List<String> paymentTypes = [
      'Listrik',
      'Air',
      'Internet',
      'Telepon',
      'BPJS',
    ];
    String selectedPaymentType = paymentTypes.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Pembayaran'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedPaymentType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPaymentType = newValue!;
                      });
                    },
                    items: paymentTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: amountController,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Pembayaran',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    double amount = double.tryParse(amountController.text) ?? 0;
                    if (amount > 0 && amount <= widget.user.balance) {
                      setState(() {
                        widget.user.balance -= amount;
                        widget.user.transactions.add(
                          Transaction(
                            date: DateTime.now(),
                            type: 'Pembayaran',
                            amount: amount,
                            description: 'Pembayaran $selectedPaymentType',
                          ),
                        );
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pembayaran $selectedPaymentType berhasil: ${_formatCurrency(amount)}')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Jumlah pembayaran tidak valid')),
                      );
                    }
                  },
                  child: const Text('Bayar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Dialog for loans
  void _showLoanDialog() {
    final TextEditingController amountController = TextEditingController();
    final List<String> loanTypes = [
      'Pinjaman Pendidikan',
      'Pinjaman Usaha',
      'Pinjaman Konsumtif',
    ];
    String selectedLoanType = loanTypes.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Pengajuan Pinjaman'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedLoanType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLoanType = newValue!;
                      });
                    },
                    items: loanTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: amountController,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Pinjaman',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    double amount = double.tryParse(amountController.text) ?? 0;
                    if (amount > 0) {
                      setState(() {
                        widget.user.balance += amount;
                        widget.user.transactions.add(
                          Transaction(
                            date: DateTime.now(),
                            type: 'Pinjaman',
                            amount: amount,
                            description: '$selectedLoanType',
                          ),
                        );
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pinjaman $selectedLoanType disetujui: ${_formatCurrency(amount)}')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Jumlah pinjaman tidak valid')),
                      );
                    }
                  },
                  child: const Text('Ajukan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Show transaction history
  void _showTransactionHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Riwayat Transaksi'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.user.transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = widget.user.transactions[index];
                return ListTile(
                  title: Text(transaction.type),
                  subtitle: Text(transaction.description),
                  trailing: Text(
                    '${transaction.type == 'Transfer' || transaction.type == 'Pembayaran' ? '-' : '+'}${_formatCurrency(transaction.amount)}',
                    style: TextStyle(
                      color: transaction.type == 'Transfer' || transaction.type == 'Pembayaran' 
                        ? Colors.red 
                        : Colors.green,
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileCard('Username', user.username),
            _buildProfileCard('Name', user.name),
            _buildProfileCard('Balance', _formatCurrency(user.balance)),
            _buildProfileCard('Email', 'trisnadewi1410@gmail.com'), 
            _buildProfileCard('Phone', '0812-5959-2736'), 
            _buildProfileCard('Address', 'Jln. Ngurah Rai'), 
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(value, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0).format(amount);
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Ubah Password'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Tambahkan logika untuk mengubah password
              },
            ),
            ListTile(
              title: const Text('Notifikasi'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Tambahkan logika untuk pengaturan notifikasi
              },
            ),
            ListTile(
              title: const Text('Keamanan'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Tambahkan logika untuk pengaturan keamanan
              },
            ),
            ListTile(
              title: const Text('Tentang Aplikasi'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Tambahkan logika untuk menampilkan informasi tentang aplikasi
              },
            ),
            ListTile(
              title: const Text('Keluar'),
              trailing: const Icon(Icons.logout),
              onTap: () {
                // Tambahkan logika untuk logout
              },
            ),
          ],
        ),
      ),
    );
  }
}

// QR Code Screen
class QRCodeScreen extends StatelessWidget {
  final String data;
  final String qrCodeUrl; // URL untuk gambar QR Code

  const QRCodeScreen({Key? key, required this.data, required this.qrCodeUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            qrCodeUrl.isEmpty
                ? Text('Tidak ada gambar QR Code')
                : Image.network(qrCodeUrl), // Menampilkan gambar dari URL
            const SizedBox(height: 20),
            Text('QR Code untuk: $data'),
          ],
        ),
      ),
    );
  }
}