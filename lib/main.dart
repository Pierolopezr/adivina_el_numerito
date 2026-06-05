import 'package:flutter/material.dart'; // 1. Importa las herramientas de diseño de Flutter

void main() {
  runApp(const MyApp()); // 2. Inicia la aplicación
}

class MyApp extends StatelessWidget { // 3. Widget inmutable (no cambia)
  const MyApp({super.key});           // StatelessWidget: Es un widget "sin memoria". Una vez que se dibuja, no cambia    
                                      // StatefulWidget: Es un widget "con memoria". Este sí puede redibujarse cuando su estado cambia
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  // 4. Estilo visual de Android/iOS automático
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 21, 215, 53)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // 5. La pantalla principal
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
// Este widget es la página principal de tu aplicación. Es con estado, lo que significa
// que tiene un objeto State (definido abajo) que contiene campos que afectan
// cómo se ve.

// Esta clase es la configuración para el estado. Contiene los valores (en este
// caso el título) proporcionados por el padre (en este caso el widget App) y
// usados por el método build del State. Los campos en una subclase de Widget siempre
// se marcan como "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
