import 'dart:convert';

TareasResponse negociosResponseFromJson(String str) =>
    TareasResponse.fromJson(json.decode(str));

String negociosResponseToJson(TareasResponse data) =>
    json.encode(data.toJson());

class TareasResponse {
  final int? id;
  final String titulo;
  final String nota;
  final int siCompleted;
  final String fecha;
  final String horainico;
  final String horafin;
  final int color;
  final int redimir;
  final String repetir;

  TareasResponse({
    this.id,
    required this.titulo,
    required this.nota,
    required this.siCompleted,
    required this.fecha,
    required this.horainico,
    required this.horafin,
    required this.color,
    required this.redimir,
    required this.repetir,
  });

  TareasResponse copyWith({
    int? id,
    String? titulo,
    String? nota,
    int? siCompleted,
    String? fecha,
    String? horainico,
    String? horafin,
    int? color,
    int? redimir,
    String? repetir,
  }) =>
      TareasResponse(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        nota: nota ?? this.nota,
        siCompleted: siCompleted ?? this.siCompleted,
        fecha: fecha ?? this.fecha,
        horainico: horainico ?? this.horainico,
        horafin: horafin ?? this.horafin,
        color: color ?? this.color,
        redimir: redimir ?? this.redimir,
        repetir: repetir ?? this.repetir,
      );

  factory TareasResponse.fromJson(Map<String, dynamic> json) => TareasResponse(
        id: json["id"],
        titulo: json["titulo"],
        nota: json["nota"],
        siCompleted: json["siCompleted"],
        fecha: json["fecha"],
        horainico: json["horainico"],
        horafin: json["horafin"],
        color: json["color"],
        redimir: json["redimir"],
        repetir: json["repetir"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "nota": nota,
        "siCompleted": siCompleted,
        "fecha": fecha,
        "horainico": horainico,
        "horafin": horafin,
        "color": color,
        "redimir": redimir,
        "repetir": repetir,
      };
}
