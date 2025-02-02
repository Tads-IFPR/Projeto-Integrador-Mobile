import 'package:flutter/material.dart';
import 'package:JAJA/components/chat/suggestions/card.dart';
import 'package:JAJA/dao/categories.dart';
import 'package:JAJA/main.dart';
import 'package:JAJA/styles/default.dart';

class Suggestion extends StatefulWidget {
  final Function(String?) sendMessage;
  const Suggestion({
    super.key,
    required this.sendMessage,
  });

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  bool isLoading = false;
  List<String> categories = [];
  List<Map<String, String>> categoriesSuggestions = [];

  getSuggestions() async {
    categories = await categoryDAO.getMostUsedSixCategories();
    categoriesSuggestions = await chatController.getSuggestions(categories);
    setState(() {
      categoriesSuggestions;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading ? GridView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: categoriesSuggestions.length,
      itemBuilder: (context, index) {
        var color = index % 3 == 0 ? colorPrimary : index % 3 == 1 ? colorSecondary : colorTerdiary;
        var lightColor = index % 3 == 0 ? colorPrimaryLight : index % 3 == 1 ? colorSecondaryLight : colorTerdiaryLight;
        return GestureDetector(
          onTap: () => widget.sendMessage(categoriesSuggestions[index]['message']),
          child: CardSuggestion(
            title: categoriesSuggestions[index]['title'],
            text: categoriesSuggestions[index]['message'],
            color: color,
            lightColor: lightColor,
          ),
        );
      },
    ) : const CircularProgressIndicator(
      color: colorPrimary,
    );
  }
}