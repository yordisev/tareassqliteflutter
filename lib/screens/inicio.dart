// import 'package:alarmasqlite/services/notificaciones_services.dart';
import 'package:alarmasqlite/config/temas.dart';
import 'package:alarmasqlite/controller/tarea_controller.dart';
import 'package:alarmasqlite/models/tareas_model.dart';
import 'package:alarmasqlite/screens/nuevatarea.dart';
import 'package:alarmasqlite/services/temas_services.dart';
import 'package:alarmasqlite/widgets/boton.dart';
import 'package:alarmasqlite/widgets/cardtareas.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InicioScreen extends StatefulWidget {
  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final _tareaController = Get.put(TareaController());
  DateTime _selecFecha = DateTime.now();
  var notificaciones;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notificaciones = NotificacionesHelper();
    // notificaciones.initializeNotification();
    // notificaciones.requestIOSPermissions();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: subHeadingStyle,
                        ),
                        Text(
                          'Today',
                          style: headingStyle,
                        ),
                      ],
                    ),
                  ),
                  BotonWid(
                      nombre: ' + Agregar',
                      opTap: () async {
                        await Get.to(() => NuevaTareaScreen());
                        _tareaController.listartareas();
                      })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: DatePicker(
                locale: "es_ES",
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: primaryCtUr,
                selectedTextColor: Colors.white,
                dateTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                dayTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                monthTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                onDateChange: (selectedDate) {
                  setState(() {
                    _selecFecha = selectedDate;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            _listarTareas(),
          ],
        ));
  }

  _listarTareas() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _tareaController.tareaslista.length,
          itemBuilder: (_, index) {
            TareasResponse tareas = _tareaController.tareaslista[index];
            if (tareas.repetir == 'Diaria') {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _VerBottonShett(context, tareas);
                            print('pruebas');
                          },
                          child: CardListadoTareas(tareas),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (tareas.fecha == DateFormat.yMd().format(_selecFecha)) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _VerBottonShett(context, tareas);
                            print('pruebas');
                          },
                          child: CardListadoTareas(tareas),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          });
    }));
  }

  _VerBottonShett(BuildContext context, TareasResponse tarea) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 4),
      height: tarea.siCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkGreyClr : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
          ),
          Spacer(),
          tarea.siCompleted == 1
              ? Container()
              : _botonShett(
                  nombre: 'Tarea Completada',
                  onTap: () {
                    _tareaController.actualizartareas(tarea.id!);
                    Get.back();
                  },
                  clr: primaryCtUr,
                  context: context),
          SizedBox(height: 10),
          _botonShett(
              nombre: 'Eliminar Tarea',
              onTap: () {
                _tareaController.deletetareas(tarea);
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context),
          SizedBox(height: 20),
          _botonShett(
              nombre: 'Cerrar',
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!,
              isClose: true,
              context: context)
        ],
      ),
    ));
  }

  _botonShett({
    required String nombre,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            nombre,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: GestureDetector(
        onTap: () {
          TemasServices().switchTheme();
          // notificaciones.displayNotification(
          //     title: 'esto es una prueba', body: 'esto es otra prueba');
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight,
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
}
