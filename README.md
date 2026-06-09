# adivina_el_numerito

A new Flutter project from PIERO LÓPEZ - 2 DAM.

## Getting Started



# Día 1:  CREANDO APP FLUTTER + EMULADOR ANDROID STUDIO
Mediante los comandos de ">create flutter adivinar_numerito" creo la app. 

Me genera un problema, no hay un emulador de dispotivo para visualizar la app, con el comando "Flutter run" me lanza solo a acudir a los navegadores disponibles (en mi caso Microsoft Edge) 
 
![alt text](image.png) 

Por lo que tengo que descargar Android studio para crear un emulador de android. 
Para esto, entro en Android Studio, me voy a **tools>device manager >añadir dispositivo móvil (pixel 7 Pro)**. 

Escogí una API que tenga más usos , en este caso la API 35. 

<img src="fotos flutter/dia 1.png" width="500"> 


Una vez echo eso, proseguí a ejecutar nuevamente `Flutter run` y empezó a descargar herramientas, luego empezó a ejecutar el Gradle, luego va compilando (El APK se va ejecutando) y se va instalando. 


<img src="fotos flutter/dia 1.3.png" width="550" height="150">

<img src="fotos flutter/dia 1.4.png" width="150"> 


Con esto estaría todo preparado. 

# Día 2: LÓGICA DEL NÚMERO ALEATORIO 

Haremos uso primero de dos widgets, el `StatelessWidget` y `StatefulWidget`.
- StatelessWidget: Es un widget "sin memoria". Una vez que se dibuja, no cambia.    
- StatefulWidget: Es un widget "con memoria". Este sí puede redibujarse cuando su estado cambia.

Empezaremos a usar estados (state), ya que es la memoria de nuestra app. Guarda datos que pueden cambiar.

Planteo un razonamiento para ver como sería la generación de número aleatorios en Flutter:
`
Usuario abre la app  ->  
Flutter ejecuta initState() ->  
Se crea un objeto Random() -> 
Random decide un número (ej: 47) ->
Se guarda en la variable numeroSecreto -> 
Flutter redibuja la pantalla con ese número  
` 

Una vez planteado, creamos variables, funciones y clases para definir con más precisión:

```
1. main() llama a runApp()
2. Flutter crea MyApp
3. Flutter ve "home: NumeroScreen()"
4. Se crea NumeroScreen (StatefulWidget)
5. Se crea _NumeroScreenState (el estado)
6. Se ejecuta initState() por primera vez.
7. Dentro de initState, se llama a _generarNumero()
8. _generarNumero() crea Random() y genera un número.
9. Se guarda en numeroSecreto
10. setState() le dice a Flutter: "Redibuja!!" 
11. Se ejecuta build() y muestra la pantalla.
```


- Usamos initState() porque es una función especial que se ejecuta UNA SOLA VEZ cuando el widget se crea por primera vez. Es como el "constructor" de la clase.
- Siempre hay que llamar a super.initState() primero porque es el método de la clase padre que necesitamos ejecutar.
- Al usar setState() le dice a Flutter que los datos han cambiado y que tiene que redibujar la pantalla. Sin setState, aunque las variables cambien, la interfaz no se actualiza. 

<img src="fotos flutter/dia2.png" width="250" height="550"> 

<img src="fotos flutter/dia2.1.png" width="550" height="150">

":)"

# Día 3: INTERFAZ INTERACTIVA (SLIDER Y BOTONES)

Hoy añadí la parte interactiva del juego: Un Slider (barra deslizable) y botones para que el usuario pueda elegir un número.

***Problema:*** En el día 2, el usuario solo podía mirar el número secreto en pantalla. No podía hacer nada para jugar.
***Solución:*** Hacer que el usuario pueda elegir un númro para comparar con el secreto. 

**Los 3 nuevos widgets**

1. Slider: Es una barra que te permite elegir un valor en un rango. 

    <img src="fotos flutter/dia3.1.png" width="550" height="150">
2. ElevatedButton: Es un botón moderno con sombra. 

    <img src="fotos flutter/dia3.2.png" width="500" height="350"> 

3. Row: Es un contenedor horizontal. Permite poner widgets uno al lado del otro.

**setState()** 

Cada vez que el usuario interactua, necesitamos `setState()` para que Flutter redibuje la pantalla. 

**Round** 

El Slider usa double porque se mueve suavemente (50.5, 50.6,...), para poder mostrarlo, usamos `.round()` para convertirlo en int.

**Conexión entre los botones** 

Los botones **NO** están conectados directamente entre sí. Ambos están conectados a la misma variable: `valorActualSlider`. 

**Resultado:**

<img src="fotos flutter/dia 3.png" width="250" height="550"> 
  
:)  

# Día 4: LÓGICA DEL JUEGO (COMPARAR Y PISTAS)

Hoy haré que la app compare los números y dé pistas. 

***Problema***: No puedo comparar el número con el número secreto, no recibo pistas, y no funciona el contador de intentos.  
***Solución:*** Hacer un botón ADIVINAR, comparaciones, actualizar mensajes con pistas, funcionamiento de contar intentos. 

**_verificarNumero()**  
Creamos una función `_verificarNumero()` que compara los números, donde añadiremos una nueva variable `yaGano`, que nos permitirá saber si el usuario ya ganó.

<img src="fotos flutter/dia4.2.png" width="350" height="250"> 

**Botón dinámico**  
El botón cambia según si ganaste o no. 

<img src="fotos flutter/dia4.png" width="550" height="150"> 

**Mensaje de pistas** 
Muestra pistas al ir intentando adivinar el número. 

<img src="fotos flutter/dia4.3.png" width="250" height="550"> 

**Mensaje de victoria**  
El mensaje cambia de color cuando ganas. 

<img src="fotos flutter/dia4.4.png" width="250" height="550"> 

# Día 5: DISEÑO VISUAL + IMÁGENES + RÉCORD 
Hoy vamos a añadir imágenes que cambian según el estado del juego, diseño visual y un sistema de récords. 

**Imágenes según el estado**
Ahora la app muestra diferentes imágenes dependiendo de si:

Es el primer intento (imagen de inicio)
La pista es "mayor" (imagen indicando número mayor)
La pista es "menor" (imagen indicando número menor)
¡Has ganado! (imagen de victoria) 


**Nueva variable: pistaActual**

Usamos una variable `pistaActual` para recordar qué pista se dio última vez, así la imagen no cambia al mover el slider.

**Lógica de imagen** 

<img src="fotos flutter/dia5.1.png" width="350" height="250"> 

**Declarar en pubspec.yaml** 

<img src="fotos flutter/dia5.png" width="350" height="100"> 

**Sistema de récords** 
Guardamos la mejor puntuación (menos intentos) en una variable `int mejorRecord = 999`, comenzamos con un número alto. Cuando ganas, comparamos si tus intentos son menores que el récord.

**Ocultar número secreto** 

El número secreto ya no se muestra en pantalla para hacer el juego más difícil. Solo aparece en la consola de debug.

**TRABAJO FINALIZADO** 

<img src="fotos flutter/dia5.2.png" width="250" height="550"> 





