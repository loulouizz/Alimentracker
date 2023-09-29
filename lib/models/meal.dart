class Meal {
  final String? id;
  final String name;
  final int kcal;
  final String conteudo;
  final String horario;
  final String data;

  const Meal({this.id, required this.name, required this.kcal, required this.conteudo, required this.horario, required this.data});

  // Método para converter um objeto Meal em um mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'kcal': kcal,
      'conteudo': conteudo,
      'horario': horario,
      'data': data,
    };
  }

  // Método para criar um objeto Meal a partir de um mapa
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      name: map['name'],
      kcal: map['kcal'],
      conteudo: map['conteudo'],
      horario: map['horario'],
      data: map['data'],
    );
  }
}