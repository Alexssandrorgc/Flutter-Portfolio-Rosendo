import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
await Firebase.initializeApp();
}

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();

FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
home: NotificationPage(),
);
}
}

class NotificationPage extends StatefulWidget {
@override
State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
String? token;

@override
void initState() {
super.initState();
loadToken();
FirebaseMessaging.onMessage.listen((message) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text("Notificación recibida: ${message.notification?.title}")),
);
});
}

Future<void> loadToken() async {
token = await FirebaseMessaging.instance.getToken();
setState(() {});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text("Actividad Notificaciones")),
body: Padding(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Token del dispositivo:", style: TextStyle(fontWeight: FontWeight.bold)),
SelectableText(token ?? "Cargando..."),
SizedBox(height: 20),
Text("Tarea:"),
Text("Usa el token mostrado para enviarte una notificación desde Firebase Console."),
],
),
),
);
}
}