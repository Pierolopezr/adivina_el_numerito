import 'package:flutter/material.dart';  // Flutter UI toolkit
import 'dart:math';                     // Números aleatorios

// =======================
// PUNTO DE ENTRADA
// =======================
void main() {
  runApp(const MyApp());  // ejecutar la app
}

// ========================================================
// WIDGET PRINCIPAL - La "entrada" de la app
// ========================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: título interno (para debug)
      title: 'Adivina el Número',
      
      // home: qué pantalla mostrar primero?
      home: Scaffold(
        // appBar: la barra de arriba
        appBar: AppBar(
          title: const Text("Adivina el Número "),
          backgroundColor: Colors.deepPurple,
        ),
        
        // body: el contenido principal
        body: const NumeroScreen(),
      ),
    );
  }
}

// ========================================================
// PANTALLA DEL JUEGO - Stateful (puede cambiar)
// ========================================================
class NumeroScreen extends StatefulWidget {
  const NumeroScreen({super.key});

  @override
  State<NumeroScreen> createState() => _NumeroScreenState();
}

// ========================================================
// EL ESTADO DEL JUEGO - Aquí guardamos los datos
// ========================================================
class _NumeroScreenState extends State<NumeroScreen> {
  
  // ========================================
  // VARIABLES (LA MEMORIA)
  // ========================================
  
  int numeroSecreto = 0;    // El número que hay que adivinar
  String mensaje = "¡Empieza a jugar!";
  int intentos = 0;          // Contador de intentos
  
  // ========================================
  // initState - Primera función que corre
  // ========================================
  
  /* 
   * initState() es especial. Se ejecuta UNA SOLA VEZ
   * cuando el widget se crea por primera vez.
   * 
   * Es como el "constructor" de la clase.
   */
  @override
  void initState() {
    super.initState();  // SIEMPRE se llama primero
    _generarNumero();   // Generar el número al iniciar
  }

  // ========================================
  // GENERAR NÚMERO ALEATORIO
  // ========================================
  
  void _generarNumero() {
    // 1. Crear un objeto "Random" que puede tirar dados
    final random = Random();
    
    // 2. Tirar el dado y guardar el resultado
    // nextInt(101) = número entre 0 y 100
    numeroSecreto = random.nextInt(101);
    
    // 3. Guardar el resultado en consola (para depurar)
    debugPrint("🎲 Número secreto generado: $numeroSecreto");
    
    // 4. Resetear el contador de intentos
    setState(() {
      intentos = 0;
      mensaje = "¡Empieza a jugar!";
    });
  }

  // ========================================
  // DISEÑO DE LA PANTALLA
  // ========================================
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // -------------
            // icono grande
            // -------------
            const Icon(
              Icons.help_outline,  // icono de pregunta
              size: 80,
              color: Colors.deepPurple,
            ),
            
            const SizedBox(height: 20),
            
            // ----------------
            // TÍTULO
            // ----------------
            const Text(
              "¿Cuál es el número?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40),
            
            // ---------------
            // NÚMERO SECRETO
            // ---------------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber[100],     // fondo amarillo
                borderRadius: BorderRadius.circular(15),  // bordes redondeados
                border: Border.all(color: Colors.amber, width: 2),
              ),
              child: Text(
                "🔒 Número: $numeroSecreto",  // ⚠️ Esto es para pruebas
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // --------------------------------
            // MENSAJE
            // --------------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                mensaje,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // --------------------------------
            // CONTADOR DE INTENTOS
            // --------------------------------
            Text(
              "Intentos: $intentos",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}