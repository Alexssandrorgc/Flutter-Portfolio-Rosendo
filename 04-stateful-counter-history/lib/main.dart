import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final List<int> _historial = [];
  bool _mostrarHistorial = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _historial.add(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _historial.add(_counter);
    });
  }

  void _toggleMostrarHistorial() {
    setState(() {
      _mostrarHistorial = !_mostrarHistorial;
    });
  }

  void _limpiarHistorial() {
    setState(() {
      _historial.clear();
    });
  }

  Widget _buildHistorial() {
    if (_historial.isEmpty) {
      return const Text('No hay historial todavía.');
    } else {
      return SizedBox(
        height: 150,
        child: ListView.builder(
          itemCount: _historial.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Valor: ${_historial[index]}'));
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleMostrarHistorial,
                child: Text(
                  _mostrarHistorial ? 'Ocultar historial' : 'Mostrar historial',
                ),
              ),
              ElevatedButton(
                onPressed: _limpiarHistorial,
                child: const Text('Limpiar historial'),
              ),
              const SizedBox(height: 10),
              if (_mostrarHistorial) _buildHistorial(),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
