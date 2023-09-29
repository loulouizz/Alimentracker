import 'package:alimentracker/models/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MealService {
  final CollectionReference mealCollection =
  FirebaseFirestore.instance.collection('meals');

  Stream<List<Meal>> getMealsStream() {
    return mealCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Meal.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Função para buscar todas as refeições
  Future<List<Meal>> getMeals() async {
    QuerySnapshot querySnapshot = await mealCollection.get();
    return querySnapshot.docs.map((doc) {
      return Meal.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Stream<List<Meal>> getMealsForTodayStream() {
    final DateTime dataDesejada = DateTime(2023, 9, 29);

    return FirebaseFirestore.instance
        .collection('meals')
        .where('data', isEqualTo: dataDesejada)
        .snapshots()
        .map((querySnapshot) {
      final meals = <Meal>[];
      for (final doc in querySnapshot.docs) {
        final mealData = doc.data() as Map<String, dynamic>;
        final meal = Meal.fromMap(mealData); // Substitua Meal pelo nome da sua classe de refeição
        meals.add(meal);
      }
      return meals;
    });
  }

  // Função para buscar refeições de hoje
  Future<List<Meal>> getMealsForTodayList() async {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);

    QuerySnapshot querySnapshot = await mealCollection
        .where('data', isEqualTo: formattedDate)
        .get();

    return querySnapshot.docs.map((doc) {
      return Meal.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // Função para adicionar uma refeição
  Future<void> addMeal(Meal meal) async {
    await mealCollection.add(meal.toMap());
  }

  // Função para atualizar uma refeição
  Future<void> updateMeal(String mealId, Meal updatedMeal) async {
    await mealCollection.doc(mealId).update(updatedMeal.toMap());
  }

  // Função para excluir uma refeição
  Future<void> deleteMeal(String mealId) async {
    await mealCollection.doc(mealId).delete();
  }
}
