import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:karkinos_test/models/questionnaires_model_db.dart';
import 'package:karkinos_test/models/sections_model_db.dart';
import 'package:karkinos_test/providers/chat_bot_provider.dart';
import 'package:karkinos_test/utils/constants.dart';
import 'package:karkinos_test/widgets/chip_options.dart';
import 'package:karkinos_test/widgets/question_widget.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Box<SectionsModelDB> questionsData =
      Hive.box<SectionsModelDB>(sectionBoxName);

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    ChatBotProvider chatBotProvider =
        Provider.of<ChatBotProvider>(context, listen: false);
    await chatBotProvider.addSectionsData(context: context);

    List<QuestionnairesModelDB> map = [];
    map = questionsData.getAt(0)?.questionnaires as List<QuestionnairesModelDB>;
    chatBotProvider.setMapData(questionsModelList: map);

    chatBotProvider.setDisplayQuestionsMap(
        maps: chatBotProvider.questionnairesMap);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatBotProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            IconButton(
              onPressed: () async {
                await provider.addSectionsData(context: context);
              },
              icon: const Icon(
                Icons.create,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                provider.questionsData.deleteAll(provider.questionsData.keys);
                provider.clearAllData();
                log("User Data: ${questionsData.length.toString()}");
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                List<QuestionnairesModelDB> map = [];
                map = questionsData.getAt(0)?.questionnaires
                    as List<QuestionnairesModelDB>;
                provider.setMapData(questionsModelList: map);
              },
              icon: const Icon(
                Icons.read_more_sharp,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (provider.displayQuestionsMap.isNotEmpty)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      child: ListView.builder(
                        // shrinkWrap: true,
                        reverse: true,
                        //  physics: const NeverScrollableScrollPhysics(),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: provider.displayQuestionsMap.length,
                        itemBuilder: (_, questionIndex) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                QuestionWidget(
                                  question: provider.displayQuestionsMap.values
                                          .elementAt(
                                              questionIndex)["question"] ??
                                      "",
                                  time: DateTime.now(),
                                ),
                                ChipOptions(
                                    chipOptions: provider
                                            .displayQuestionsMap.values
                                            .elementAt(
                                                questionIndex)["options"] ??
                                        [],
                                    nextQuestionIds: provider
                                                .displayQuestionsMap.values
                                                .elementAt(questionIndex)[
                                            "next_question_id"] ??
                                        [],
                                    isLastQuestion: provider
                                                .displayQuestionsMap.values
                                                .elementAt(questionIndex)[
                                            "last_question"] ??
                                        false),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                if (provider.displayQuestionsMap.isEmpty)
                  Container(
                    child: Text(
                      "No Map Data",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
