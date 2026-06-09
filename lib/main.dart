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
  bool yaGano = false; // variable "yaganó" 
  int mejorRecord = 999;
  bool primerIntento = true;
  String pistaActual = 'inicio';

  double valorActualSlider = 50.0; // Valor inicial del slider
  
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
  void initState() { // Es una función especial que se ejecuta UNA SOLA VEZ cuando el widget se crea por primera vez. Es como el "constructor" de la clase.
    super.initState();  // SIEMPRE se llama primero porque es el método de la clase padre que necesitamos ejecutar
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
    setState(() { // Le dice a Flutter que los datos han cambiado y que tiene que redibujar la pantalla. Sin setState, aunque las variables cambien, la interfaz no se actualiza.
      intentos = 0;
      yaGano = false;
      primerIntento = true;
      pistaActual = 'inicio';
      mensaje = "¡Empieza a jugar!"; // Para imágenes
    });
  }

  void _verificarNumero() {
    int intento = valorActualSlider.round();

    setState(() {
      if (yaGano){
        // Si ya había ganado, no hacer nada
        return;
      }

      primerIntento = false;
      intentos++;

      if (intento == numeroSecreto) {
        yaGano = true;
        pistaActual = 'ganaste';

        // Comprueba si es nuevo récord

        if (intentos < mejorRecord) {
          mejorRecord = intentos;
          mensaje = "¡NUEVO RÉCORD! Lo adivinaste en $intentos intentos";
        }else {
          mensaje = "¡FELICIDADES! Lo adivinaste en $intentos intentos";
        }
        debugPrint("¡FELICIDADES! Lo adivinaste en $intentos intentos");
      }
      else if (intento < numeroSecreto) {
        pistaActual = 'mayor';
        mensaje = "¡Es MAYOR! Intenta de nuevo.";
        debugPrint("¡Es MAYOR! Intenta de nuevo.");
      }
      else {
        pistaActual = 'menor';
        mensaje = "¡Es MENOR! Intenta de nuevo.";
        debugPrint("¡Es MENOR! Intenta de nuevo.");
      }
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
            
            // IMAGEN SEGÚN EL ESTADO
            Container(
              width:150,   
              height:150, 
              child: Image.asset(
                yaGano 
                  ? 'assets/imagenes/ganaste.gif'
                  : pistaActual == 'mayor' 
                    ? 'assets/imagenes/pista_es_numero_mayor.jpg'
                    : pistaActual == 'menor'
                      ? 'assets/imagenes/pista_es_numero_menor.jpg'
                      : 'assets/imagenes/inicio.jpg',
              ),
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
            
            
            const SizedBox(height: 30),
            // SLIDER (Una barra que permite elegir un valor en un rango)
            Slider(
              value: valorActualSlider,
              min: 0,
              max: 100,
              divisions: 100,
              label: valorActualSlider.round().toString(),
              onChanged: (double value){ // Función que se ejecuta cuando se mueve el slider. Es double porque slider devulve un double y no un int.
                setState(() {
                  valorActualSlider = value; // Guardo el nuevo valor y actualizo la pantalla
                });
              },
            ),

            const SizedBox(height: 10), // Espacio en blanco en VERTICAL

            // NÚMERO SELECCIONADO
            Text(valorActualSlider.round().toString(), style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold )),
            
            const SizedBox(height: 20),

            // BOTONES + Y -
            Row( // Contenedor horizontal
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // espacio igual entre todos
              children: [ // Lista de widgets dentro del row
                // Botón - 
                ElevatedButton( // Botón con sobra
                  onPressed: (){
                    setState(() { // Actualizar la pantalla
                      if (valorActualSlider > 0) {
                        valorActualSlider--;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400], padding: const EdgeInsets.all(20),),

                  child: const Icon(Icons.remove, size:30), // Ícono dentro del botón
                  ),

                  // Botón + 
                  ElevatedButton(onPressed: (){
                    setState(() {
                      if (valorActualSlider < 100) {
                        valorActualSlider++;
                      }
                    });
                  },
                    style:ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[400],
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Icon(Icons.add, size: 30),
                  ),
                ],
              ),

            const SizedBox(height: 30),

            // Botón ADIVINAR
            ElevatedButton(
              onPressed: yaGano ? _generarNumero : _verificarNumero,
              style: ElevatedButton.styleFrom(
                backgroundColor: yaGano ? Colors.green : const Color.fromARGB(255, 130, 99, 185),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: Text(yaGano ? "JUGAR DE NUEVO" : "ADIVINAR", style: const TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 30),

            
            // ---------------
            // NÚMERO SECRETO  
            // ---------------

            
            //Container(
            //  padding: const EdgeInsets.all(20),
            //  decoration: BoxDecoration(
            //    color: Colors.amber[100],     // fondo amarillo
            //    borderRadius: BorderRadius.circular(15),  // bordes redondeados
            //    border: Border.all(color: Colors.amber, width: 2),
            //  ),
            //  child: Text(
            //    "🔒 Número: $numeroSecreto",  // ⚠️ Esto es para pruebas
            //    style: const TextStyle(
            //      fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //      color: Colors.amber,
            //    ),
            //  ),
            //),
            
            const SizedBox(height: 20),
            
            // -----------------------------
            // MENSAJE
            // -----------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: yaGano ? Colors.green : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                mensaje, 
                style: TextStyle(fontSize: 15), 
                textAlign: TextAlign.center
              ),
            ),
            
            
            const SizedBox(height: 10),
            
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