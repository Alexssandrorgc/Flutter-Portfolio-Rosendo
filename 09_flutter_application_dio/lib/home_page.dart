import 'package:flutter/material.dart';
import 'api_service.dart';

class HomePage extends StatefulWidget {
  // Asegúrate de tener un constructor (puede ser const)
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService api = ApiService();
  
  // 1. Variable renombrada de 'posts' a 'users'
  List<dynamic> users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData(); // Llama al método para cargar datos
  }

  Future<void> loadData() async {
    // 2. Llama al nuevo método 'getUsers'
    final data = await api.getUsers();
    setState(() {
      users = data; // Asigna los datos a 'users'
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título actualizado para la tarea
        title: const Text("Demo DIO - Usuarios"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              // 3. Usa la longitud de la lista 'users'
              itemCount: users.length,
              itemBuilder: (context, index) {
                // 4. Obtiene el usuario actual
                final user = users[index];

                // 5. Muestra 'name' y 'email' como pide la tarea
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  leading: CircleAvatar( // (Extra) Añade un avatar con las iniciales
                    child: Text(user['name'][0]),
                  ),
                );
              },
            ),
    );
  }
}