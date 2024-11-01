import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart'; // Impor Device Preview
import 'login.dart'; // Impor halaman login

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Ubah menjadi false jika tidak ingin menggunakan Device Preview
      builder: (context) => MyApp(), // Aplikasi Anda
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Ganti dengan halaman awal Anda
      builder: DevicePreview.appBuilder, // Tambahkan ini untuk integrasi Device Preview
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _navigateToLogin();
    });
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: _navigateToLogin, // Berpindah jika layar diklik
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 1.0), // Menggeser ke kiri
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo-tins.png',
                  width: 80, // Sesuaikan ukuran logo
                  height: 80,
                ),
                SizedBox(width: 8), // Jarak antara logo dan teks
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Timah',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900, // Ketebalan maksimal
                          color: Colors.black,
                          shadows: [
                          ],
                        ),
                      ),
                      TextSpan(
                        text: '.id',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900, // Ketebalan maksimal
                          color: Color(0xFF001F54), // Warna biru dongker
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
