import 'package:flutter/material.dart';
import 'package:laboratorio/components/chat/suggestions/card.dart';
import 'package:laboratorio/dao/categories.dart';
import 'package:laboratorio/main.dart';

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
    categories = categoryDAO.getAllCategories();
    categoriesSuggestions = await chatController.getSuggestions(categories);
    setState(() {
      categoriesSuggestions;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: categoriesSuggestions.length,
        reverse: false,
        itemBuilder: (context, index) {
          return CardSuggestion(
            title: categoriesSuggestions[index]['title'] ?? "",
            text: categoriesSuggestions[index]['text'] ?? "",
          );
        },
      )
    );
  }
}