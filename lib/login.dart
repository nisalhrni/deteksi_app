import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'forgot_paasword.dart'; // Pastikan file ini ada
import 'home.dart'; // File untuk halaman home Anda

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() async {
    final String email = _usernameController.text;
    final String password = _passwordController.text;

    // Ubah URL localhost untuk mendukung Android emulator atau browser
    final response = await http.post(
      Uri.parse('http://localhost/deteksi_apd/login.php'),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        'email': email,
        'password': password,
      },
    );

    // Tambahkan log untuk melihat status respons
    print("Login response status: ${response.statusCode}");
    print("Login response body: ${response.body}");

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['success']) {
        print("Login berhasil. Meminta data pengguna...");

        // Ambil data pengguna dari user_info.php
        final userResponse = await http.post(
          Uri.parse('http://localhost/deteksi_apd/user_info.php'),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: {
            'email': email,
          },
        );

        // Tambahkan log untuk respons user info
        print("User info response status: ${userResponse.statusCode}");
        print("User info response body: ${userResponse.body}");

        if (userResponse.statusCode == 200) {
          final userData = json.decode(userResponse.body);

          if (userData['success']) {
            // Navigasi ke HomeScreen dengan data pengguna
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(email: email, userInfo: userData['data'])),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tidak dapat mengambil informasi pengguna')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengakses user info')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error: ${response.statusCode}')),
      );
    }
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 110),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 80),
            SizedBox(
              height: 60,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _forgotPassword,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF001F54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
