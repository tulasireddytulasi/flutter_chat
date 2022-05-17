import 'package:hive/hive.dart';

part 'questionnaires_model_db.g.dart';

@HiveType(typeId: 1)
class QuestionnairesModelDB extends HiveObject {
  QuestionnairesModelDB({
    required this.question_id,
    required this.question,
    required this.options,
    required this.option_key,
    required this.type,
    required this.next_question_id,
    required this.last_question,
  });

  @HiveField(0)
  String question_id;

  @HiveField(1)
  String question;

  @HiveField(2)
  List<String> options;

  @HiveField(3)
  List<String> option_key;

  @HiveField(4)
  String type;

  @HiveField(5)
  List<String> next_question_id;

  @HiveField(6)
  bool last_question;

  // @override
  // String toString() {
  //   return '$question_id: $question';
  // }
}
