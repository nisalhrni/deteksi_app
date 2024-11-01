import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      "message": "Terdeteksi pelanggaran. Silahkan klik untuk lihat detailnya.",
      "timestamp": DateTime.now().subtract(Duration(minutes: 5)),
    },
    {
      "message": "Terdeteksi pelanggaran. Silahkan klik untuk lihat detailnya.",
      "timestamp": DateTime.now().subtract(Duration(hours: 1)),
    },
    {
      "message": "Terdeteksi pelanggaran. Silahkan klik untuk lihat detailnya.",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
    },
  ];

  String formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: ListTile(
            leading: Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
            ),
            title: Text(notification['message']),
            subtitle: Text(
              'Waktu: ${formatTimestamp(notification['timestamp'])}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotificationDetailPage(notification: notification),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Halaman Detail Notifikasi
class NotificationDetailPage extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationDetailPage({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pelanggaran'),
        backgroundColor: Color(0xFF001F54),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pelanggaran',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            Text(
              'Pesan: ${notification['message']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Waktu Terdeteksi: ${DateFormat('yyyy-MM-dd HH:mm').format(notification['timestamp'])}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
