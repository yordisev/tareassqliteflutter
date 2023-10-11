import 'package:alarmasqlite/config/temas.dart';
import 'package:alarmasqlite/controller/tarea_controller.dart';
import 'package:alarmasqlite/models/tareas_model.dart';
import 'package:alarmasqlite/widgets/boton.dart';
import 'package:alarmasqlite/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NuevaTareaScreen extends StatefulWidget {
  @override
  State<NuevaTareaScreen> createState() => _NuevaTareaScreenState();
}

class _NuevaTareaScreenState extends State<NuevaTareaScreen> {
  final TareaController _tareaController = Get.put(TareaController());
  final TextEditingController _titulocontroller = TextEditingController();
  final TextEditingController _notacontroller = TextEditingController();
  DateTime _seleccionardia = DateTime.now();
  String _fechainicio = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _fechafin = "09:30 PM";
  int _seleccionarrepetir = 5;
  List<int> repetirlista = [5, 10, 15, 20];
  String _seleccionarno = "none";
  List<String> listadonone = ["no repetir", "Diaria", "Semanal", "Mensual"];
  int _seleccionarcolor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nueva Tarea',
              style: headingStyle,
            ),
            InputsWin(
              titulo: 'Titulo',
              valor: 'Ingrese el Titulo',
              controller: _titulocontroller,
            ),
            InputsWin(
                titulo: 'Nota',
                valor: 'Ingrese La Nota',
                controller: _notacontroller),
            InputsWin(
              titulo: 'Fecha',
              valor: DateFormat.yMd().format(_seleccionardia),
              widget: IconButton(
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                ),
                onPressed: () {
                  print(11111111);
                  _getFechas();
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InputsWin(
                    titulo: 'Hora Inicio',
                    valor: _fechainicio,
                    widget: IconButton(
                      icon: Icon(
                        Icons.access_time_filled_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _getHoras(ishorainicial: true);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: InputsWin(
                    titulo: 'Hora Fin',
                    valor: _fechafin,
                    widget: IconButton(
                      icon: Icon(
                        Icons.access_time_filled_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _getHoras(ishorainicial: false);
                      },
                    ),
                  ),
                )
              ],
            ),
            InputsWin(
              titulo: 'Repetir Alarma',
              valor: '$_seleccionarrepetir Repetir Alarma',
              widget: DropdownButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: subtitleStyle,
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newvalue) {
                  setState(() {
                    _seleccionarrepetir = int.parse(newvalue!);
                  });
                },
                items: repetirlista.map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
            InputsWin(
              titulo: 'Cada cuanto',
              valor: '$_seleccionarno',
              widget: DropdownButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: subtitleStyle,
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newvalue) {
                  setState(() {
                    _seleccionarno = newvalue!;
                  });
                },
                items:
                    listadonone.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Color:',
                    style: titleStyle,
                  ),
                  SizedBox(height: 8),
                  Wrap(
                      children: List<Widget>.generate(3, (int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _seleccionarcolor = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: index == 0
                              ? primaryCtUr
                              : index == 1
                                  ? pinkClr
                                  : yellowCtlr,
                          child: _seleccionarcolor == index
                              ? Icon(Icons.done, color: Colors.white, size: 16)
                              : Container(),
                        ),
                      ),
                    );
                  }))
                ]),
                BotonWid(nombre: ' + Generar', opTap: () => _validarfecha())
              ],
            )
          ],
        )),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/avatar.png"),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  _getFechas() async {
    DateTime? _datapicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1993),
        lastDate: DateTime(2050));
    if (_datapicker != null) {
      setState(() {
        _seleccionardia = _datapicker;
        print(_seleccionardia);
      });
    } else {
      print('No selecciono fecha');
    }
  }

  _getHoras({required bool ishorainicial}) async {
    var pickedTime = await _verhora();
    String _formatearhora = pickedTime.format(context);
    if (pickedTime == null) {
      print('cancelada la seleccion');
    } else if (ishorainicial == true) {
      setState(() {
        _fechainicio = _formatearhora;
      });
    } else if (ishorainicial == false) {
      setState(() {
        _fechafin = _formatearhora;
      });
    }
  }

  _verhora() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_fechainicio.split(":")[0]),
          minute: int.parse(_fechainicio.split(":")[1].split(" ")[0])),
    );
  }

  _validarfecha() {
    if (_titulocontroller.text.isNotEmpty && _notacontroller.text.isNotEmpty) {
      _guardarendb();
      Get.back();
    } else {
      Get.snackbar('Requeridos', 'Todos los campos son requeridos',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          icon: Icon(Icons.warning_amber_rounded),
          colorText: pinkClr);
    }
  }

  _guardarendb() async {
    int value = await _tareaController.InsertarTarea(
        tareasResponse: TareasResponse(
      titulo: _titulocontroller.text,
      nota: _notacontroller.text,
      siCompleted: 0,
      fecha: DateFormat.yMd().format(_seleccionardia),
      horainico: _fechainicio,
      horafin: _fechafin,
      color: _seleccionarcolor,
      redimir: _seleccionarrepetir,
      repetir: _seleccionarno,
    ));

    print('mi value es $value');
  }
}
