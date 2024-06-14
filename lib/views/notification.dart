import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {},
            ),
          ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No leídas',
                style: TextStyle(
                  fontSize: 15,
                )
            ),
            ListTile(
              leading: Icon(Icons.circle, size: 14, color: Colors.green),
              title: Text('Notificación 1'),
              subtitle: Text('Descripción de la notificación 1'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.circle, size: 14, color: Colors.green),
              title: Text('Notificación 2'),
              subtitle: Text('Descripción de la notificación 2'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(height: 20),
            Text('Leídas',
                style: TextStyle(
                  fontSize: 15,
                )
            ),
            ListTile(
              title: Text('Notificación 3'),
              subtitle: Text('Descripción de la notificación 3'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
