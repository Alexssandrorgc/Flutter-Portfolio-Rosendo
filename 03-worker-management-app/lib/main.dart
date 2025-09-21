import 'package:flutter/material.dart';
import 'worker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabajadores',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WorkerPage(),
    );
  }
}

class WorkerPage extends StatefulWidget {
  const WorkerPage({super.key});

  @override
  State<WorkerPage> createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  final List<Worker> _workers = [];

  String? _errorMsg;

  void _addWorker() {
    setState(() {
      _errorMsg = null; 
    });

    final String idText = _idController.text.trim();
    final String nombre = _nombreController.text.trim();
    final String apellidos = _apellidosController.text.trim();
    final String edadText = _edadController.text.trim();

    if (idText.isEmpty || nombre.isEmpty || apellidos.isEmpty || edadText.isEmpty) {
      setState(() {
        _errorMsg = 'Todos los campos son obligatorios';
      });
      return;
    }

    final int? id = int.tryParse(idText);
    final int? edad = int.tryParse(edadText);

    if (id == null || edad == null) {
      setState(() {
        _errorMsg = 'ID y edad deben ser números válidos';
      });
      return;
    }

    if (edad < 18) {
      setState(() {
        _errorMsg = 'Solo se pueden registrar mayores de edad';
      });
      return;
    }

    final bool idExistente = _workers.any((w) => w.id == id);
    if (idExistente) {
      setState(() {
        _errorMsg = 'El ID $id ya existe';
      });
      return;
    }

    final worker = Worker(
      id: id,
      nombre: nombre,
      apellidos: apellidos,
      edad: edad,
    );

    setState(() {
      _workers.add(worker);
      _idController.clear();
      _nombreController.clear();
      _apellidosController.clear();
      _edadController.clear();
    });
  }

  void _removeLastWorker() {
    if (_workers.isNotEmpty) {
      setState(() {
        _workers.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Trabajadores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ID'),
              ),
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _apellidosController,
                decoration: const InputDecoration(labelText: 'Apellidos'),
              ),
              TextField(
                controller: _edadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Edad'),
              ),
              const SizedBox(height: 10),
              if (_errorMsg != null)
                Text(
                  _errorMsg!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addWorker,
                child: const Text('Agregar trabajador'),
              ),
              ElevatedButton(
                onPressed: _removeLastWorker,
                child: const Text('Eliminar último trabajador'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Lista de trabajadores:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _workers.length,
                itemBuilder: (context, index) {
                  final worker = _workers[index];
                  return ListTile(
                    title: Text('${worker.nombre} ${worker.apellidos}'),
                    subtitle: Text('ID: ${worker.id} | Edad: ${worker.edad}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
