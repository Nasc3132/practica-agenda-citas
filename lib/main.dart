import 'package:flutter/material.dart';

void main() {
  runApp(const PracticaAgendaApp());
}

class PracticaAgendaApp extends StatelessWidget {
  const PracticaAgendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Práctica: Agenda de Citas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5547D7)),
        scaffoldBackgroundColor: const Color(0xFFF6F5FC),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF9F8FD),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: const PantallaPractica(),
    );
  }
}

class PreguntaPractica {
  const PreguntaPractica({
    required this.paso,
    required this.pregunta,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.explicacion,
  });

  final String paso;
  final String pregunta;
  final List<String> opciones;
  final int respuestaCorrecta;
  final String explicacion;
}

const _preguntas = <PreguntaPractica>[
  PreguntaPractica(
    paso: 'Paso 1 · StatefulWidget',
    pregunta: '¿Qué tipo de widget necesita una pantalla cuya lista cambia?',
    opciones: ['StatelessWidget', 'StatefulWidget', 'Container'],
    respuestaCorrecta: 1,
    explicacion:
        'StatefulWidget conserva datos que cambian. En nuestra agenda, la '
        'lista crece cada vez que guardamos una cita.',
  ),
  PreguntaPractica(
    paso: 'Paso 2 · TextEditingController',
    pregunta: '¿Qué usamos para leer lo escrito en el campo correo?',
    opciones: [
      "String correo = '';",
      'TextEditingController correoController = TextEditingController();',
      'Container();',
    ],
    respuestaCorrecta: 1,
    explicacion:
        'TextEditingController permite leer, modificar y limpiar el contenido '
        'de un campo mediante su propiedad .text.',
  ),
  PreguntaPractica(
    paso: 'Paso 4 · TextFormField',
    pregunta: '¿Qué campo permite utilizar validator dentro de un Form?',
    opciones: ['TextField()', 'TextFormField(validator: validar)', 'Text()'],
    respuestaCorrecta: 1,
    explicacion:
        'TextFormField se integra con Form y puede mostrar el mensaje que '
        'devuelve su función validator.',
  ),
  PreguntaPractica(
    paso: 'Paso 5 · Campo obligatorio',
    pregunta: '¿Qué condición también detecta un texto con solo espacios?',
    opciones: [
      'value == null || value.trim().isEmpty',
      "value == 'Flutter'",
      'value.length > 20',
    ],
    respuestaCorrecta: 0,
    explicacion:
        'trim() quita los espacios de los extremos e isEmpty comprueba si '
        'quedó algún contenido.',
  ),
  PreguntaPractica(
    paso: 'Paso 6 · Correo',
    pregunta: '¿Qué revisión ayuda a validar un correo de forma sencilla?',
    opciones: [
      'Comprobar solamente que no esté vacío',
      'Separar por @ y revisar usuario, dominio y punto',
      'Comprobar que tenga exactamente 6 caracteres',
    ],
    respuestaCorrecta: 1,
    explicacion:
        'Al separar por @ deben quedar dos partes: un usuario y un dominio '
        'válidos. El dominio también debe contener un punto.',
  ),
  PreguntaPractica(
    paso: 'Paso 7 · Contraseña',
    pregunta: '¿Qué condición detecta una contraseña menor de 6 caracteres?',
    opciones: ['texto.length == 6', 'texto.length < 6', 'texto.length > 6'],
    respuestaCorrecta: 1,
    explicacion:
        '< 6 significa menor que seis. Una contraseña de seis o más '
        'caracteres puede continuar.',
  ),
  PreguntaPractica(
    paso: 'Paso 8 · validate()',
    pregunta: '¿Qué instrucción ejecuta las reglas de todos los campos?',
    opciones: [
      '_formKey.currentState!.save()',
      '_formKey.currentState!.validate()',
      '_controller.clear()',
    ],
    respuestaCorrecta: 1,
    explicacion:
        'validate() pregunta a cada campo si cumple su regla. Devuelve true '
        'solo cuando todos son correctos.',
  ),
  PreguntaPractica(
    paso: 'Paso 10 · setState()',
    pregunta: '¿Qué usamos para agregar una cita y actualizar la pantalla?',
    opciones: [
      'setState(() { _citas.add(nuevaCita); });',
      "Text('Nueva cita');",
      '_citas.clear();',
    ],
    respuestaCorrecta: 0,
    explicacion:
        'setState() avisa a Flutter que los datos cambiaron. La pantalla se '
        'reconstruye y muestra la nueva cita inmediatamente.',
  ),
];

// La pantalla cambia cuando se agrega una cita, por eso es StatefulWidget.
class PantallaPractica extends StatefulWidget {
  const PantallaPractica({super.key});

  @override
  State<PantallaPractica> createState() => _PantallaPracticaState();
}

class _PantallaPracticaState extends State<PantallaPractica> {
  int _seccionActual = 0;
  int _preguntaActual = 0;
  int? _respuestaSeleccionada;
  int _aciertos = 0;
  bool _simulacroTerminado = false;
  int _pasoLaboratorio = 0;
  String _textoCapturado = '';
  bool? _resultadoValidacion;
  final List<String> _citasLaboratorio = [];

  final _loginFormKey = GlobalKey<FormState>();
  final _citaFormKey = GlobalKey<FormState>();

  // Los controladores leen y limpian lo que escribe el usuario.
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _nombreController = TextEditingController();
  final _fechaController = TextEditingController();
  final _horaController = TextEditingController();
  final _motivoController = TextEditingController();
  final _laboratorioController = TextEditingController();

  // Igual que en la aplicación original, las citas viven solo en memoria.
  final List<Map<String, String>> _citas = [];

  // PRÁCTICA — PASO 5:
  // Aquí agregaremos la función _validarObligatorio durante la exposición.

  String? _validarCorreo(String? value) {
    // PRÁCTICA — PASO 6:
    // Aquí agregaremos la validación sencilla del correo.
    return null;
  }

  String? _validarContrasena(String? value) {
    // PRÁCTICA — PASO 7:
    // Aquí revisaremos que tenga al menos 6 caracteres.
    return null;
  }

  void _iniciarSesion() {
    // validate pregunta a todos los campos del formulario si son válidos.
    if (_loginFormKey.currentState!.validate()) {
      _mostrarMensaje('Inicio de sesión correcto.');
    }
  }

  void _guardarCita() {
    if (!_citaFormKey.currentState!.validate()) {
      return;
    }

    // setState avisa a Flutter que los datos cambiaron.
    setState(() {
      _citas.add({
        'nombre': _nombreController.text.trim(),
        'fecha': _fechaController.text.trim(),
        'hora': _horaController.text.trim(),
        'motivo': _motivoController.text.trim(),
      });
    });

    _nombreController.clear();
    _fechaController.clear();
    _horaController.clear();
    _motivoController.clear();
    FocusScope.of(context).unfocus();
    _mostrarMensaje('Cita guardada correctamente.');
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  void dispose() {
    _correoController.dispose();
    _contrasenaController.dispose();
    _nombreController.dispose();
    _fechaController.dispose();
    _horaController.dispose();
    _motivoController.dispose();
    _laboratorioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(switch (_seccionActual) {
          0 => 'Simulacro interactivo',
          1 => 'Por dentro de la agenda',
          _ => 'Mini agenda',
        }),
        backgroundColor: Colors.white,
      ),
      body: switch (_seccionActual) {
        0 => _construirSimulacro(),
        1 => _construirLaboratorio(),
        _ => _construirContenidoAgenda(),
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: _seccionActual,
        onDestinationSelected: (index) {
          setState(() {
            _seccionActual = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'Simulacro',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree_outlined),
            selectedIcon: Icon(Icons.account_tree),
            label: 'Por dentro',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Agenda',
          ),
        ],
      ),
    );
  }

  Widget _construirContenidoAgenda() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _construirIntroduccion(),
              const SizedBox(height: 18),
              _construirLogin(),
              const SizedBox(height: 18),
              _construirFormularioCita(),
              const SizedBox(height: 24),
              _construirLista(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirLaboratorio() {
    final codigoActivo = switch (_pasoLaboratorio) {
      0 =>
        'TextFormField(\n'
            '  controller: _nombreController,\n'
            ')',
      1 => 'final nombre = _nombreController.text;',
      2 =>
        'if (nombre.trim().isEmpty) {\n'
            "  return 'Este campo es obligatorio';\n"
            '}',
      _ =>
        'setState(() {\n'
            '  _citas.add(nombre);\n'
            '});',
    };

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Sigue el viaje de una cita',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Tú controlas cada paso. Observa cómo un dato pasa del '
                'campo de texto a la lista que aparece en pantalla.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 18),
              LinearProgressIndicator(
                value: (_pasoLaboratorio + 1) / 4,
                minHeight: 8,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 18),
              _construirMapaLaboratorio(),
              const SizedBox(height: 18),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.04, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: _construirAccionLaboratorio(),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF211F2E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.code, color: Color(0xFFB8AEFF), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Código activo en este momento',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: SelectableText(
                        codigoActivo,
                        key: ValueKey(codigoActivo),
                        style: const TextStyle(
                          color: Color(0xFFD7D1FF),
                          fontFamily: 'monospace',
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirMapaLaboratorio() {
    const titulos = ['Interfaz', 'Controller', 'Validator', 'setState'];
    const iconos = [
      Icons.keyboard_outlined,
      Icons.text_fields,
      Icons.fact_check_outlined,
      Icons.refresh,
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        for (var index = 0; index < titulos.length; index++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 175,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: index == _pasoLaboratorio
                  ? const Color(0xFFEEEAFE)
                  : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: index == _pasoLaboratorio
                    ? const Color(0xFF5547D7)
                    : const Color(0xFFE0DCEB),
                width: index == _pasoLaboratorio ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  index < _pasoLaboratorio ? Icons.check_circle : iconos[index],
                  color: index <= _pasoLaboratorio
                      ? const Color(0xFF5547D7)
                      : const Color(0xFF8A8498),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${index + 1}. ${titulos[index]}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _construirAccionLaboratorio() {
    return Card(
      key: ValueKey(_pasoLaboratorio),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: switch (_pasoLaboratorio) {
          0 => _laboratorioInterfaz(),
          1 => _laboratorioControlador(),
          2 => _laboratorioValidator(),
          _ => _laboratorioSetState(),
        },
      ),
    );
  }

  Widget _laboratorioInterfaz() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '1. Escribe un nombre',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text('Este es el dato que recibiría el formulario de la agenda.'),
        const SizedBox(height: 16),
        TextFormField(
          controller: _laboratorioController,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            labelText: 'Nombre de la persona',
            hintText: 'Ejemplo: Ana López',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F5FC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _laboratorioController.text.isEmpty
                ? 'El campo todavía está vacío.'
                : 'La interfaz muestra: "${_laboratorioController.text}"',
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () {
            setState(() {
              _textoCapturado = _laboratorioController.text;
              _pasoLaboratorio = 1;
            });
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Enviar al controlador'),
        ),
      ],
    );
  }

  Widget _laboratorioControlador() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '2. El controlador captura el texto',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'TextEditingController funciona como un puente entre el campo y '
          'nuestro código. Su propiedad .text contiene:',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFEEEAFE),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            _textoCapturado.isEmpty ? '(texto vacío)' : _textoCapturado,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF4436BA),
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () {
            setState(() {
              _resultadoValidacion = _textoCapturado.trim().isNotEmpty;
              _pasoLaboratorio = 2;
            });
          },
          icon: const Icon(Icons.fact_check_outlined),
          label: const Text('Preguntar al validator'),
        ),
      ],
    );
  }

  Widget _laboratorioValidator() {
    final esValido = _resultadoValidacion ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          esValido
              ? '3. El dato es válido'
              : '3. El validator encontró un error',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: esValido ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                esValido ? Icons.check_circle : Icons.error_outline,
                color: esValido
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFFC62828),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  esValido
                      ? 'Hay información. Podemos guardar la cita.'
                      : 'Este campo es obligatorio. No podemos guardar.',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (esValido)
          FilledButton.icon(
            onPressed: () {
              setState(() {
                _citasLaboratorio.add(_textoCapturado.trim());
                _pasoLaboratorio = 3;
              });
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Ejecutar setState()'),
          )
        else
          FilledButton.icon(
            onPressed: () {
              setState(() {
                _pasoLaboratorio = 0;
                _resultadoValidacion = null;
              });
            },
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Volver y corregir el campo'),
          ),
      ],
    );
  }

  Widget _laboratorioSetState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '4. Flutter vuelve a mostrar la pantalla',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'setState() avisó que la lista cambió. La nueva cita aparece '
          'inmediatamente:',
        ),
        const SizedBox(height: 14),
        for (var index = 0; index < _citasLaboratorio.length; index++)
          Card(
            color: const Color(0xFFEEEAFE),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(_citasLaboratorio[index]),
              subtitle: const Text('Cita temporal agregada con setState()'),
              trailing: const Icon(Icons.event_available),
            ),
          ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () {
            setState(() {
              _seccionActual = 2;
            });
          },
          icon: const Icon(Icons.calendar_month_outlined),
          label: const Text('Ahora probar la agenda completa'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _reiniciarLaboratorio,
          icon: const Icon(Icons.replay),
          label: const Text('Repetir demostración'),
        ),
      ],
    );
  }

  void _reiniciarLaboratorio() {
    setState(() {
      _laboratorioController.clear();
      _textoCapturado = '';
      _resultadoValidacion = null;
      _citasLaboratorio.clear();
      _pasoLaboratorio = 0;
    });
  }

  Widget _construirSimulacro() {
    if (_simulacroTerminado) {
      return _construirResultado();
    }

    final pregunta = _preguntas[_preguntaActual];
    final respondida = _respuestaSeleccionada != null;
    final acerto = _respuestaSeleccionada == pregunta.respuestaCorrecta;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Pregunta ${_preguntaActual + 1} de ${_preguntas.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(Icons.star_outline, size: 18),
                    label: Text('$_aciertos aciertos'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (_preguntaActual + 1) / _preguntas.length,
                minHeight: 8,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        pregunta.paso,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pregunta.pregunta,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),
                      for (
                        var index = 0;
                        index < pregunta.opciones.length;
                        index++
                      ) ...[
                        _construirOpcion(pregunta, index),
                        if (index < pregunta.opciones.length - 1)
                          const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
              ),
              if (respondida) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: acerto
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: acerto
                          ? const Color(0xFF81C784)
                          : const Color(0xFFEF9A9A),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        acerto
                            ? '¡Correcto!'
                            : 'La respuesta correcta es '
                                  '${String.fromCharCode(65 + pregunta.respuestaCorrecta)}.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: acerto
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFC62828),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(pregunta.explicacion),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _avanzarSimulacro,
                  icon: Icon(
                    _preguntaActual == _preguntas.length - 1
                        ? Icons.emoji_events_outlined
                        : Icons.arrow_forward,
                  ),
                  label: Text(
                    _preguntaActual == _preguntas.length - 1
                        ? 'Ver resultado'
                        : 'Siguiente pregunta',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirOpcion(PreguntaPractica pregunta, int index) {
    final respondida = _respuestaSeleccionada != null;
    final esCorrecta = index == pregunta.respuestaCorrecta;
    final fueSeleccionada = index == _respuestaSeleccionada;

    Color? color;
    if (respondida && esCorrecta) {
      color = const Color(0xFF2E7D32);
    } else if (respondida && fueSeleccionada) {
      color = const Color(0xFFC62828);
    }

    return OutlinedButton(
      onPressed: respondida
          ? null
          : () {
              setState(() {
                _respuestaSeleccionada = index;
                if (esCorrecta) {
                  _aciertos++;
                }
              });
            },
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        foregroundColor: color,
        side: BorderSide(
          color: color ?? Theme.of(context).colorScheme.outlineVariant,
          width: color == null ? 1 : 2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Text(
            '${String.fromCharCode(65 + index)})',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              pregunta.opciones[index],
              style: const TextStyle(fontFamily: 'monospace', height: 1.35),
            ),
          ),
          if (respondida && esCorrecta)
            const Icon(Icons.check_circle_outline)
          else if (respondida && fueSeleccionada)
            const Icon(Icons.cancel_outlined),
        ],
      ),
    );
  }

  void _avanzarSimulacro() {
    setState(() {
      if (_preguntaActual == _preguntas.length - 1) {
        _simulacroTerminado = true;
      } else {
        _preguntaActual++;
        _respuestaSeleccionada = null;
      }
    });
  }

  void _reiniciarSimulacro() {
    setState(() {
      _preguntaActual = 0;
      _respuestaSeleccionada = null;
      _aciertos = 0;
      _simulacroTerminado = false;
    });
  }

  Widget _construirResultado() {
    final porcentaje = (_aciertos / _preguntas.length * 100).round();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events,
                    size: 72,
                    color: Color(0xFFFFB300),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    '¡Simulacro terminado!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Obtuviste $_aciertos de ${_preguntas.length} '
                    'respuestas correctas ($porcentaje%).',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      setState(() {
                        _seccionActual = 1;
                      });
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: const Text('Ver cómo funciona por dentro'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: _reiniciarSimulacro,
                    icon: const Icon(Icons.replay),
                    label: const Text('Jugar de nuevo'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _construirIntroduccion() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Una copia educativa de nuestra agenda',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          'Practicaremos formularios, validaciones y la actualización '
          'inmediata de una lista temporal.',
        ),
      ],
    );
  }

  Widget _construirLogin() {
    return _tarjeta(
      titulo: '1. Inicio de sesión simulado',
      icono: Icons.login,
      contenido: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _correoController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: _validarCorreo,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contrasenaController,
              obscureText: true,
              onFieldSubmitted: (_) => _iniciarSesion(),
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              validator: _validarContrasena,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _iniciarSesion,
              icon: const Icon(Icons.login),
              label: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirFormularioCita() {
    return _tarjeta(
      titulo: '2. Nueva cita',
      icono: Icons.edit_calendar_outlined,
      contenido: Form(
        key: _citaFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nombreController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nombre de la persona',
                prefixIcon: Icon(Icons.person_outline),
              ),
              // PRÁCTICA — PASO 9: conectaremos la regla obligatoria.
              validator: (value) => null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _fechaController,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Fecha',
                hintText: '15/10/2026',
                prefixIcon: Icon(Icons.calendar_today_outlined),
              ),
              // PRÁCTICA — PASO 9: conectaremos la regla obligatoria.
              validator: (value) => null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _horaController,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Hora',
                hintText: '10:30 AM',
                prefixIcon: Icon(Icons.schedule_outlined),
              ),
              // PRÁCTICA — PASO 9: conectaremos la regla obligatoria.
              validator: (value) => null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _motivoController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Motivo',
                prefixIcon: Icon(Icons.notes_outlined),
              ),
              // PRÁCTICA — PASO 9: conectaremos la regla obligatoria.
              validator: (value) => null,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _guardarCita,
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Guardar cita'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirLista() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Citas registradas: ${_citas.length}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        if (_citas.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Aún no hay citas. Completa el formulario para agregar una.',
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _citas.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final cita = _citas[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(cita['nombre'] ?? ''),
                  subtitle: Text(
                    '${cita['fecha']} · ${cita['hora']}\n${cita['motivo']}',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _tarjeta({
    required String titulo,
    required IconData icono,
    required Widget contenido,
  }) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icono, color: const Color(0xFF5547D7)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            contenido,
          ],
        ),
      ),
    );
  }
}
