class Nota {

  String id;
  String title;
  DateTime date;

  Nota(this.id, this.title, this.date);

  factory Nota.fromJson(Map<String, dynamic> json) { // Transforma dados do banco (JSON) em um objeto nota
    return Nota(
      json['id'] as String,
      json['title'] as String,
      DateTime.parse(json['date'] as String)
    );
  }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "title": title,
//       "date": date.toIso8601String(),
//     };
//   }
}