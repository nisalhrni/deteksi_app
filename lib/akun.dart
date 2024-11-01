import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:convert'; // Untuk menggunakan json.encode
import 'package:http/http.dart' as http; // Untuk membuat permintaan HTTP

class AccountPage extends StatelessWidget {
  final String email;
  final Map<String, dynamic> userInfo;

  AccountPage({required this.email, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
    TextEditingController(text: userInfo['name']);
    final TextEditingController positionController =
    TextEditingController(text: userInfo['position']);
    final TextEditingController divisionController =
    TextEditingController(text: userInfo['division']);
    final TextEditingController departmentController =
    TextEditingController(text: userInfo['department']);

    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
    TextEditingController();

    void _showChangePasswordDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ubah Kata Sandi'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newPasswordController,
                  decoration: InputDecoration(labelText: 'Kata Sandi Baru'),
                  obscureText: true,
                ),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Konfirmasi Kata Sandi'),
                  obscureText: true,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String newPassword = newPasswordController.text;
                  String confirmPassword = confirmPasswordController.text;

                  if (newPassword.isNotEmpty && newPassword == confirmPassword) {
                    // Kirim permintaan untuk mengubah kata sandi
                    final response = await http.post(
                      Uri.parse('http://10.0.2.2/deteksi_apd/change_password.php'), // Ganti dengan URL API Anda
                      headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                      },
                      body: {
                        'email': email,
                        'new_password': newPassword,
                      },
                    );

                    if (response.statusCode == 200) {
                      final result = json.decode(response.body);
                      if (result['success']) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Kata sandi berhasil diubah!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal mengubah kata sandi')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Server error')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Kata sandi tidak cocok atau kosong')),
                    );
                  }
                },
                child: Text('Simpan'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
                child: Text('Batal'),
              ),
            ],
          );
        },
      );
    }

    void _logout() {
      // Clear any stored user session if necessary

      // Navigate back to login page and remove all previous routes
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Anda telah logout!')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Akun Saya'),
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Info Personal',
                style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 17),
              Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: TextEditingController(text: email),
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 25),
              Text(
                'Info Pekerjaan',
                style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 17),
              Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: positionController,
                  decoration: InputDecoration(
                    labelText: 'Posisi',
                    prefixIcon: Icon(Icons.work),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: divisionController,
                  decoration: InputDecoration(
                    labelText: 'Divisi',
                    prefixIcon: Icon(Icons.business),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: departmentController,
                  decoration: InputDecoration(
                    labelText: 'Departemen',
                    prefixIcon: Icon(Icons.apartment),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 17),
              Text(
                'Pengaturan',
                style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Ubah Kata Sandi'),
                onTap: _showChangePasswordDialog,
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: _logout, // Memanggil fungsi logout
              ),
            ],
          ),
        ),
      ),
    );
  }
}
