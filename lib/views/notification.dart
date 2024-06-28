import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/notification_response.dart';
import 'package:servifix_flutter/api/service/notificationService.dart';
import 'package:servifix_flutter/api/preferences/userPreferences.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  late String token;
  late int userId;
  Future<List<NotificationResponse>>? _notificationsFuture; // nullable future
  final _notificationService = Notificationservice();

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    UserPreferences userPreferences = UserPreferences();
    token = (await userPreferences.getToken()) ?? '';
    userId = (await userPreferences.getUserId()) ?? 0;

    setState(() {
      _notificationsFuture = _notificationService.getNotificationByAccountId(userId, token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Center(
              child: Text('Notificaciones',
                  style: TextStyle(fontSize: 20)
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<NotificationResponse>>(
          future: _notificationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No se encontraron notificaciones.'));
            } else {
              final notifications = snapshot.data!;
              return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return ListTile(
                    leading: Icon(Icons.circle, size: 14, color: Colors.green),
                    title: Text(notification.title),
                    subtitle: Text(notification.content),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}