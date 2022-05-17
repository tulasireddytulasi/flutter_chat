import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:karkinos_test/models/questionnaires_model_db.dart';
import 'package:karkinos_test/models/sections_model_db.dart';
import 'package:karkinos_test/utils/constants.dart';

class ChatBotProvider extends ChangeNotifier {
  final Box<SectionsModelDB> _questionsData =
      Hive.box<SectionsModelDB>(sectionBoxName);

  Box<SectionsModelDB> get questionsData => _questionsData;

  final Map _questionnairesMap = {};
  Map _displayQuestionsMap = {};

  Map get questionnairesMap => _questionnairesMap;

  Map get displayQuestionsMap => _displayQuestionsMap;

  void setDisplayQuestionsMap({required Map maps}) {
    _displayQuestionsMap[maps.keys.elementAt(0)] = maps.values.elementAt(0);
    //  _displayQuestionsMap = maps;
    log("NewChat: $_displayQuestionsMap");
    notifyListeners();
  }

  void clearAllData() {
    _displayQuestionsMap.clear();
    _questionnairesMap.clear();
    notifyListeners();
  }

  void addDisplayQuestionsMap({required Map maps}) {
    log("NewChat Map: $maps \n\n");
    // _displayQuestionsMap[maps.keys.elementAt(0)] = maps.values.elementAt(0);
    _displayQuestionsMap.addAll({maps["question_id"]: maps});
    //  _displayQuestionsMap = maps;
    log("NewChat: ${json.encode(_displayQuestionsMap)}");
    notifyListeners();
  }

  Future<void> addSectionsData({required BuildContext context}) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/personal_history_json.json");
    Map<String, dynamic> sectionObject = json.decode(data);
    log("Json Object: ${sectionObject.length}");
    log("Json Object: ${sectionObject['personal_history']['questions']['do_you_have_past_history_of_cancer']['question']}");
    log("Json Object: ${sectionObject['personal_history']['section_name']}");

    List<String> sectionNames = [];
    List<String> sectionNamesKeys = [];
    List<String> sectionLanguage = [];
    List<String> sectionVersion = [];

    sectionObject.forEach((key, value) {
      // log('Section Name: $key');
      log('Section Name: ${sectionObject[key]["section_name"]}');
      log('Section Key: ${sectionObject[key]["section_key"]}');
      log('Section Language: ${sectionObject[key]["locale"]}');
      log('Section Version: ${sectionObject[key]["versionNumber"]}');
      List<QuestionnairesModelDB> questionnairesModelDBList = [];
      questionnairesModelDBList.clear();

      log('Section length: ${sectionObject[key].length}');
      if (sectionObject[key].length > 0) {
        Map<String, dynamic> questionMapObject = {};
        if (questionMapObject.isNotEmpty) {
          // questionMapObject will be clear,
          // if any data is there, then new data will be assigned.
          questionMapObject.clear();
        }
        questionMapObject = sectionObject[key]['questions'];
        //  log('Section data: ${sectionObject[key]['questions']}');
        questionMapObject.forEach((key, value) {
          log('Question ID: ${questionMapObject[key]['question_id']}');
          log('Question: ${questionMapObject[key]['question']}');
          log('Options: ${questionMapObject[key]['options']}');
          log('Option Keys: ${questionMapObject[key]['option_key']}');
          log('Is last question: ${questionMapObject[key]['type']}');
          log('Next Question: ${questionMapObject[key]['next_question_id']}');
          log('Type: ${questionMapObject[key]['last_question']}\n');
          // =========
          QuestionnairesModelDB questionnairesModelDB = QuestionnairesModelDB(
              question_id: questionMapObject[key]['question_id'],
              question: questionMapObject[key]['question'],
              options: List.from(questionMapObject[key]['options'] ?? []),
              option_key: List.from(questionMapObject[key]['option_key'] ?? []),
              next_question_id:
                  List.from(questionMapObject[key]['next_question_id'] ?? []),
              type: questionMapObject[key]['type'],
              last_question: questionMapObject[key]['last_question']);
          questionnairesModelDBList.add(questionnairesModelDB);
          // =========
        });
        // ==========  Section Model  ===========
        SectionsModelDB sectionsModelDB = SectionsModelDB(
            sectionName: sectionObject[key]["section_name"],
            sectionKey: sectionObject[key]["section_key"],
            locale: sectionObject[key]["locale"],
            versionNumber: sectionObject[key]["versionNumber"],
            questionnaires: questionnairesModelDBList);
        _questionsData.add(sectionsModelDB);
        // ==========  Section Model  ===========
      }
    });

    notifyListeners();
  }

  void setMapData({required List<QuestionnairesModelDB> questionsModelList}) {
    for (var element in questionsModelList) {
      Map questionObject = {};
      questionObject.addAll({
        "question_id": element.question_id,
        "question": element.question,
        "options": element.options,
        "option_key": element.option_key,
        "type": element.type,
        "next_question_id": element.next_question_id,
        "last_question": element.last_question
      });
      _questionnairesMap.addAll({element.question_id: questionObject});
    }
    //  log("Map Data: ${json.encode(_questionnairesMap)}");

    log("Map Data2: ${_questionnairesMap.keys.elementAt(0)}");

    // _questionnairesMap.forEach((key, value) {
    //   log("Map Data2: ${value["question"]}");
    // });
    log("Map Data2: ${_questionnairesMap.values.elementAt(0)["question"]}");
    log("Map Data2: ${_questionnairesMap.values.elementAt(0)}");
    notifyListeners();
  }
}
