import 'package:alarmasqlite/db/basededatos.dart';
import 'package:alarmasqlite/models/tareas_model.dart';
import 'package:get/get.dart';

class TareaController extends GetxController {
  @override
  void onReady() {
    listartareas();
    super.onReady();
  }

  Future<int> InsertarTarea({TareasResponse? tareasResponse}) async {
    return await DBHelper.insert(tareasResponse);
  }

  var tareaslista = <TareasResponse>[].obs;
  void listartareas() async {
    List<Map<String, dynamic>> tareas = await DBHelper.query();
    tareaslista.assignAll(
        tareas.map((data) => new TareasResponse.fromJson(data)).toList());
  }

  void deletetareas(TareasResponse tareasResponse) {
    var respuesta = DBHelper.delete(tareasResponse);
    listartareas();
    print(respuesta);
  }

  void actualizartareas(int id) async {
    await DBHelper.update(id);
    listartareas();
  }
}
