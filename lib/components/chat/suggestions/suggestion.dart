import 'package:flutter/material.dart';
import 'package:laboratorio/components/chat/suggestions/card.dart';
import 'package:laboratorio/dao/categories.dart';
import 'package:laboratorio/main.dart';
import 'package:laboratorio/styles/default.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({
    super.key,
  });

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  List<String> categories = [];
  List<Map<String, String>> categoriesSuggestions = [];

  getSuggestions() async {
    categories = await categoryDAO.getMostUsedSixCategories();
    categoriesSuggestions = await chatController.getSuggestions(categories);
    setState(() {
      categoriesSuggestions;
    });
  }

  @override
  void initState() {
    super.initState();
    getSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: categoriesSuggestions.length,
      itemBuilder: (context, index) {
        var color = index % 3 == 0 ? colorPrimary : index % 3 == 1 ? colorSecondary : colorTerdiary;
        var lightColor = index % 3 == 0 ? colorPrimaryLight : index % 3 == 1 ? colorSecondaryLight : colorTerdiaryLight;
        return CardSuggestion(
          title: categoriesSuggestions[index]['title'],
          text: categoriesSuggestions[index]['message'],
          color: color,
          lightColor: lightColor,
        );
      },
    );
  }
}