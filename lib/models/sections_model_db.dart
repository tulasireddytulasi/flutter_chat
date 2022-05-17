import 'package:hive/hive.dart';
import 'package:karkinos_test/models/questionnaires_model_db.dart';

part 'sections_model_db.g.dart';

@HiveType(typeId: 0)
class SectionsModelDB extends HiveObject {
  SectionsModelDB(
      {required this.sectionName,
      required this.sectionKey,
      required this.versionNumber,
      required this.locale,
      required this.questionnaires});

  @HiveField(0)
  String sectionName;

  @HiveField(1)
  String sectionKey;

  @HiveField(2)
  String versionNumber;

  @HiveField(3)
  String locale;

  @HiveField(4)
  List<QuestionnairesModelDB> questionnaires;
}
