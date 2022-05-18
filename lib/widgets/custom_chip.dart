import 'package:flutter/material.dart';
import 'package:karkinos_test/utils/colors.dart';
import 'package:karkinos_test/utils/constants.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({Key? key, required this.answer}) : super(key: key);

  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 2,
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      margin: const EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 5),
      decoration: BoxDecoration(
        color: DARKPINK,
        border: Border.all(width: 1, color: DARKPINK),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Text(
        answer,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
        style: const TextStyle(
            fontSize: 14, color: WHITE, fontFamily: MONTSERRAT_REGULAR),
      ),
    );
  }
}
