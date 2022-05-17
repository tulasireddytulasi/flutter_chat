import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karkinos_test/utils/colors.dart';
import 'package:karkinos_test/utils/constants.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final DateTime time;
  const QuestionWidget({Key? key, required this.question, required this.time})
      : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: Bubble(
        radius: const Radius.circular(10),
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                      child: Container(
                          alignment: Alignment.topLeft,
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          child: Text(
                            widget.question,
                            softWrap: true,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: BLACK_6,
                                fontFamily: MONTSERRAT_REGULAR,
                                fontSize: 14),
                          )))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(top: 5),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      child: Text(
                        DateFormat("hh:mm a").format(widget.time),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            color: LIGHT_GRAY,
                            fontFamily: MONTSERRAT_REGULAR,
                            fontSize: 10),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
