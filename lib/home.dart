import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'notif.dart';
import 'akun.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  final Map<String, dynamic> userInfo; // Menyimpan userInfo

  // Tambahkan email dan userInfo sebagai parameter di HomeScreen
  HomeScreen({required this.email, required this.userInfo});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: <Widget>[
        // Halaman Utama
        Center(
          child: Text(
            'Selamat Datang di Halaman Utama!',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        // Halaman Notifikasi
        NotificationPage(),
        // Halaman Profil (kirim parameter email dan userInfo ke AccountPage)
        AccountPage(email: widget.email, userInfo: widget.userInfo), // Memperbaiki di sini
        // Halaman Clips
        const Center(
          child: Text(
            'Clips Page',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue[700],
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.notifications),
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifikasi',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Akun',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.video_library),
            icon: Icon(Icons.video_library_outlined),
            label: 'Clips',
          ),
        ],
      ),
    );
  }
}
