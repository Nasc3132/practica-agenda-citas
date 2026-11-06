# Práctica guiada: así está construida Agenda de Citas

Duración aproximada: **20 minutos**. Esta es una sola aplicación: comienza compilando y con sus botones y lista operativos. Durante la exposición completaremos cuatro zonas marcadas con comentarios `PRÁCTICA` en `lib/main.dart`. No hay Firebase ni autenticación real.

## Tres áreas dentro de la misma aplicación

- **Simulacro**: permite jugar las 8 preguntas A/B/C, muestra inmediatamente si la respuesta es correcta, explica por qué y lleva el puntaje.
- **Por dentro**: recorrido manipulable que muestra el viaje de un dato por `TextEditingController`, `validator`, `setState()` y la lista temporal. El código activo cambia y se resalta en cada paso.
- **Mini agenda**: contiene el login simulado, el formulario de citas y la lista temporal donde se aplica lo aprendido.

La navegación inferior permite cambiar entre ambas áreas sin salir de la aplicación. Las preguntas también permanecen escritas en esta guía para que quien expone tenga el guion y los fragmentos exactos que debe modificar.

## ¿Qué parte de Agenda de Citas estamos reproduciendo?

Esta práctica parte directamente del [repositorio original](https://github.com/Nasc3132/agenda-citas) y conserva su idea central: capturar nombre, fecha, hora y motivo, guardar cada cita temporalmente y actualizar la pantalla de inmediato.

- `StatefulWidget` → en la aplicación original, `PantallaAgenda` conserva una pantalla cuyo contenido cambia cuando se agrega una cita. Aquí sucede lo mismo en `PantallaPractica`.
- `TextEditingController` → captura y permite limpiar los datos escritos. El proyecto original tiene controladores para nombre, fecha, hora y motivo; aquí conservamos esos cuatro y agregamos correo y contraseña para el simulacro de login.
- Lista de citas → el original usa una `List<Map<String, String>>`; esta copia educativa usa la misma estructura como almacenamiento temporal. Al cerrar la aplicación, la información desaparece.
- `setState()` → agrega la cita y le pide a Flutter reconstruir la interfaz para mostrarla inmediatamente.
- Campos del formulario → reproducimos nombre, fecha, hora y motivo.
- Validaciones → el original revisa si algún texto está vacío antes de guardar. La práctica mantiene esa intención, pero muestra mensajes específicos junto a cada campo.

El proyecto original usa `TextField` y hace la comprobación de los cuatro textos dentro de `_guardarCita()`. En esta práctica introducimos `Form`, `GlobalKey<FormState>`, `TextFormField` y `validator` como una manera más estructurada de revisar varios campos juntos. El login es simulado y solo sirve para practicar esas mismas herramientas antes de aplicarlas a las citas.

## Preparación (antes de iniciar el cronómetro)

1. Abre `lib/main.dart` y ejecuta `flutter run -d chrome`.
2. Localiza los comentarios `PRÁCTICA — PASO 5`, `PASO 6`, `PASO 7` y `PASO 9`.
3. Explica que los validadores devuelven temporalmente `null`. En Flutter, eso significa “sin error”; por eso el proyecto compila, aunque todavía acepta datos incorrectos.
4. Conserva esta guía abierta para copiar los cambios exactos cuando el grupo elija una respuesta.

## Ruta de 20 minutos

| Tiempo | Actividad |
|---|---|
| 0:00–1:30 | Relación con la aplicación original |
| 1:30–3:00 | Paso 1: `StatefulWidget` |
| 3:00–4:30 | Paso 2: controladores |
| 4:30–6:00 | Paso 3: `Form` y su llave |
| 6:00–7:30 | Paso 4: `TextFormField` |
| 7:30–9:30 | Paso 5: campos obligatorios |
| 9:30–12:00 | Paso 6: correo |
| 12:00–14:00 | Paso 7: contraseña |
| 14:00–15:30 | Paso 8: `validate()` |
| 15:30–17:30 | Paso 9: formulario de cita |
| 17:30–20:00 | Paso 10: `setState()` y prueba final |

---

## Paso 1 — `StatefulWidget` (pregunta 1 de 8)

### Qué estamos explicando

La lista empieza vacía y cambia cada vez que guardamos una cita. La pantalla debe recordar esa lista y volver a dibujar su contenido.

### Pregunta

¿Qué tipo de widget necesita la pantalla que muestra una lista que cambia?

### Opciones

A)

```dart
class PantallaPractica extends StatelessWidget
```

B)

```dart
class PantallaPractica extends StatefulWidget
```

C)

```dart
class PantallaPractica extends Container
```

### Respuesta correcta

**B.**

### Por qué

`StatefulWidget` puede conservar datos que cambian durante el uso de la pantalla. Aquí conserva `_citas`. `StatelessWidget` es adecuado cuando el widget no necesita cambiar su propio estado.

### Cambio que debemos realizar

No hay que escribirlo: ya está preparado cerca del inicio de `main.dart`. Señala estas dos partes:

```dart
class PantallaPractica extends StatefulWidget {
  const PantallaPractica({super.key});

  @override
  State<PantallaPractica> createState() => _PantallaPracticaState();
}
```

### Qué probar

Observa el texto `Citas registradas: 0`. Al final volveremos aquí y veremos que el número cambia sin reiniciar la aplicación.

---

## Paso 2 — `TextEditingController` (pregunta 2 de 8)

### Qué estamos explicando

Cada controlador se conecta con un campo. Su propiedad `.text` contiene exactamente lo que escribió el usuario.

### Pregunta

Necesitamos leer lo que escribe el usuario en el campo correo. ¿Qué debemos utilizar?

### Opciones

A)

```dart
String correo = '';
```

B)

```dart
final correoController = TextEditingController();
```

C)

```dart
Container();
```

### Respuesta correcta

**B.**

### Por qué

`TextEditingController` permite leer, modificar y limpiar el contenido de un campo. Usamos uno para correo, contraseña, nombre, fecha, hora y motivo.

### Cambio que debemos realizar

No hay que escribirlo; muestra la conexión ya preparada:

```dart
final _correoController = TextEditingController();

TextFormField(
  controller: _correoController,
)
```

Para leer el valor usamos `_correoController.text`. Para limpiar un campo usamos `_correoController.clear()`.

### Qué probar

Escribe `noe@gmail.com` y explica que `_correoController.text` contiene ese texto. No es necesario imprimirlo.

---

## Paso 3 — `Form` y `GlobalKey<FormState>`

### Qué estamos explicando

`Form` agrupa varios campos para revisarlos juntos. `GlobalKey<FormState>` funciona como la llave que nos permite pedirle al formulario que ejecute todas sus validaciones.

### Cambio que debemos realizar

No hay que escribirlo. Identifica un formulario y su llave ya preparados:

```dart
final _loginFormKey = GlobalKey<FormState>();

Form(
  key: _loginFormKey,
  child: Column(
    children: [/* campos */],
  ),
)
```

Tenemos una llave para el login y otra para la cita, de modo que cada botón valida solamente su sección.

### Qué probar

Señala que ambos formularios pueden vivir en la misma pantalla sin mezclar sus reglas.

---

## Paso 4 — `TextField` y `TextFormField` (pregunta 3 de 8)

### Qué estamos explicando

`TextField` captura texto. `TextFormField` también captura texto, pero se integra con `Form` y permite agregar una función `validator` que devuelve un mensaje de error.

### Pregunta

¿Qué campo debemos elegir si queremos usar `validator`?

### Opciones

A)

```dart
TextField(controller: _correoController)
```

B)

```dart
TextFormField(
  controller: _correoController,
  validator: _validarCorreo,
)
```

C)

```dart
Text(controller: _correoController)
```

### Respuesta correcta

**B.**

### Por qué

`TextFormField` pertenece al `Form` y sabe mostrar debajo del campo el texto que devuelve `validator`. Si el validador devuelve `null`, Flutter entiende que no hay error.

### Cambio que debemos realizar

No hay que escribirlo. Compara un `TextField` del proyecto original con los `TextFormField` de esta práctica y localiza:

```dart
validator: _validarCorreo,
```

### Qué probar

Pulsa **Iniciar sesión** con los campos vacíos. Todavía no aparece un error porque las funciones preparadas devuelven `null`. Eso cambiará en los pasos siguientes.

---

## Paso 5 — Campos obligatorios (pregunta 4 de 8)

### Qué estamos explicando

Crearemos una regla reutilizable. Si el valor no existe o, después de quitar espacios, queda vacío, devolvemos el mensaje específico recibido por la función.

### Pregunta

¿Qué condición detecta correctamente un campo vacío, incluso si el usuario escribió solo espacios?

### Opciones

A)

```dart
if (value == null || value.trim().isEmpty) {
  return mensaje;
}
return null;
```

B)

```dart
if (value == 'Flutter') {
  return mensaje;
}
return null;
```

C)

```dart
return mensaje;
```

### Respuesta correcta

**A.**

### Por qué

El valor puede ser `null`, estar vacío o contener solo espacios. `trim()` quita los espacios de los extremos e `isEmpty` revisa si quedó algún contenido. Devolvemos `null` cuando todo está bien.

### Cambio que debemos realizar

Debajo del comentario `PRÁCTICA — PASO 5`, agrega esta función completa:

```dart
String? _validarObligatorio(String? value, String mensaje) {
  if (value == null || value.trim().isEmpty) {
    return mensaje;
  }
  return null;
}
```

### Qué probar

Todavía no se verá en la interfaz: en el paso 9 conectaremos esta regla con cada campo de la cita. Esta separación permite explicar primero la regla y después su uso.

---

## Paso 6 — Validar correo (pregunta 5 de 8)

### Qué estamos explicando

El correo debe tener texto antes de `@` y un dominio con punto después de `@`. Usaremos `split('@')` para mantener la regla comprensible, sin una expresión regular complicada.

### Pregunta

¿Qué revisión rechaza `nombre`, `nombre@` y `@gmail.com`, pero acepta `nombre@gmail.com`?

### Opciones

A)

```dart
final partes = texto.split('@');
final esValido = partes.length == 2 &&
    partes[0].isNotEmpty &&
    partes[1].contains('.') &&
    !partes[1].startsWith('.') &&
    !partes[1].endsWith('.');
```

B)

```dart
final esValido = texto.isNotEmpty;
```

C)

```dart
final esValido = texto.length == 6;
```

### Respuesta correcta

**A.**

### Por qué

Al separar por `@` deben existir exactamente dos partes. La primera no puede estar vacía y el dominio debe contener un punto que no esté al inicio ni al final. Es una validación educativa, no un verificador completo de todos los formatos de correo posibles.

### Cambio que debemos realizar

Reemplaza el cuerpo preparado de `_validarCorreo` por este contenido:

```dart
String? _validarCorreo(String? value) {
  final texto = value?.trim() ?? '';

  if (texto.isEmpty) {
    return 'Ingresa el correo electrónico.';
  }

  final partes = texto.split('@');
  final esValido = partes.length == 2 &&
      partes[0].isNotEmpty &&
      partes[1].contains('.') &&
      !partes[1].startsWith('.') &&
      !partes[1].endsWith('.');

  if (!esValido) {
    return 'Ingresa un correo válido.';
  }
  return null;
}
```

### Qué probar

- Incorrectos: `nombre`, `nombre@`, `@gmail.com`. Deben mostrar **Ingresa un correo válido.**
- Correcto: `nombre@gmail.com`. El correo ya no debe mostrar error.

---

## Paso 7 — Contraseña (pregunta 6 de 8)

### Qué estamos explicando

Primero comprobamos que haya texto. Luego revisamos una longitud mínima de seis caracteres.

### Pregunta

¿Qué condición detecta que una contraseña tiene menos de seis caracteres?

### Opciones

A)

```dart
if (texto.length == 6)
```

B)

```dart
if (texto.length < 6)
```

C)

```dart
if (texto.length > 6)
```

### Respuesta correcta

**B.**

### Por qué

`< 6` significa “menor que seis”. Una contraseña de seis o más caracteres pasa la regla; una de cinco o menos produce el mensaje.

### Cambio que debemos realizar

Reemplaza el cuerpo preparado de `_validarContrasena` por:

```dart
String? _validarContrasena(String? value) {
  final texto = value ?? '';

  if (texto.isEmpty) {
    return 'Ingresa la contraseña.';
  }
  if (texto.length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres.';
  }
  return null;
}
```

### Qué probar

- Incorrecto: `123` debe mostrar **La contraseña debe tener al menos 6 caracteres.**
- Correcto: `123456` debe aceptarse.

---

## Paso 8 — `validate()` (pregunta 7 de 8)

### Qué estamos explicando

Cuando presionamos el botón, `validate()` pregunta a todos los campos de ese `Form` si cumplen sus reglas. Devuelve `true` solamente cuando todos responden con `null`.

### Pregunta

¿Qué instrucción ejecuta todos los validadores del formulario de login?

### Opciones

A)

```dart
_loginFormKey.currentState!.save();
```

B)

```dart
_loginFormKey.currentState!.validate();
```

C)

```dart
_correoController.clear();
```

### Respuesta correcta

**B.**

### Por qué

`currentState` obtiene el estado del formulario y `validate()` consulta todos sus `validator`. Si todos están correctos, podemos continuar.

### Cambio que debemos realizar

No hay que escribirlo; ya está conectado al botón:

```dart
if (_loginFormKey.currentState!.validate()) {
  _mostrarMensaje('Inicio de sesión correcto.');
}
```

### Qué probar

1. Correo `noe` y contraseña `123`: deben aparecer los dos errores.
2. Correo `noe@gmail.com` y contraseña `123456`: debe aparecer **Inicio de sesión correcto.**

No se consulta Firebase ni un servidor. Solo comprobamos el formulario.

---

## Paso 9 — Aplicar lo aprendido a una cita

### Qué estamos explicando

Conectaremos la función del paso 5 a los cuatro `TextFormField`. Cada campo enviará su propio mensaje para indicar exactamente qué falta.

### Cambio que debemos realizar

Busca los cuatro comentarios `PRÁCTICA — PASO 9` y reemplaza cada:

```dart
validator: (value) => null,
```

En el campo **Nombre de la persona** escribe:

```dart
validator: (value) =>
    _validarObligatorio(value, 'Ingresa el nombre de la persona.'),
```

En **Fecha** escribe:

```dart
validator: (value) =>
    _validarObligatorio(value, 'Ingresa la fecha.'),
```

En **Hora** escribe:

```dart
validator: (value) =>
    _validarObligatorio(value, 'Ingresa la hora.'),
```

En **Motivo** escribe:

```dart
validator: (value) =>
    _validarObligatorio(value, 'Ingresa el motivo.'),
```

### Qué probar

Pulsa **Guardar cita** sin escribir nada. Deben aparecer estos cuatro mensajes y la lista debe seguir en cero:

- **Ingresa el nombre de la persona.**
- **Ingresa la fecha.**
- **Ingresa la hora.**
- **Ingresa el motivo.**

Después completa solo el nombre. La cita todavía no debe guardarse porque faltan fecha, hora y motivo.

---

## Paso 10 — `setState()` (pregunta 8 de 8)

### Qué estamos explicando

Cuando la cita es válida, la agregamos a `_citas`. `setState()` le avisa a Flutter: “Los datos cambiaron, vuelve a mostrar la pantalla”.

### Pregunta

¿Qué fragmento agrega una cita y actualiza inmediatamente la interfaz?

### Opciones

A)

```dart
setState(() {
  _citas.add(nuevaCita);
});
```

B)

```dart
Text('Nueva cita');
```

C)

```dart
_citas.clear();
```

### Respuesta correcta

**A.**

### Por qué

La lista cambia dentro de `setState()`. Flutter vuelve a ejecutar `build`, el contador usa la nueva longitud y la lista crea una tarjeta adicional.

### Cambio que debemos realizar

No hay que escribirlo; muestra el bloque ya preparado en `_guardarCita()`:

```dart
setState(() {
  _citas.add({
    'nombre': _nombreController.text.trim(),
    'fecha': _fechaController.text.trim(),
    'hora': _horaController.text.trim(),
    'motivo': _motivoController.text.trim(),
  });
});
```

### Qué probar

Escribe:

- Nombre: `Ana López`
- Fecha: `15/10/2026`
- Hora: `10:30 AM`
- Motivo: `Reunión del proyecto`

Pulsa **Guardar cita**. Debe ocurrir todo esto sin recargar la página:

1. aparece **Cita guardada correctamente.**;
2. el contador cambia de 0 a 1;
3. la cita aparece inmediatamente;
4. los cuatro campos quedan limpios.

## Comprobación final

Al terminar los cuatro cambios, verifica este recorrido:

1. `noe` → **Ingresa un correo válido.**
2. `noe@gmail.com` → correo aceptado.
3. `123` → **La contraseña debe tener al menos 6 caracteres.**
4. `123456` junto con el correo correcto → **Inicio de sesión correcto.**
5. Cita vacía → cuatro mensajes específicos y ninguna cita guardada.
6. Cita completa → se agrega y aparece de inmediato.

La idea para cerrar la exposición es: **los controladores obtienen los datos, los validadores deciden si son correctos, `validate()` coordina la revisión y `setState()` actualiza lo que vemos.**
