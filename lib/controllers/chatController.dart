import 'dart:io';
import 'package:JAJA/dao/chat.dart';
import 'package:JAJA/services/geminiService.dart';
import 'package:JAJA/services/openAIService.dart';

const loremIpsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet suscipit ligula, nec elementum lorem. Phasellus volutpat sollicitudin lacus, quis pulvinar lectus aliquet nec. Nam vulputate nulla quis imperdiet vulputate. Aenean consequat, risus sed pellentesque convallis, urna ipsum tincidunt nisi, sit amet sagittis magna justo in purus. Aliquam efficitur, nunc eget interdum tincidunt, justo erat fermentum felis, eget consequat orci nulla mattis purus. Cras mollis pellentesque vulputate. Etiam a ligula a turpis placerat pharetra suscipit vel quam. Duis volutpat ultrices libero. Nunc congue nisi id quam vehicula eleifend at ut est. Pellentesque laoreet justo vitae mi rhoncus, id eleifend ante consequat.';

class ChatController {
  final Geminiservice geminiService;
  final OpenAIService openAIService;

  ChatController(this.geminiService, this.openAIService);

  Future<String?> sendMessage(String prompt, {List<File>? images = const []}) async {
    try {
      final result = await openAIService.sendMessage(prompt, files: images ?? []);
      result?['message'] = result['message'] ?? 'Failed to get a response.';

      await saveMessage(result?['title'] ?? 'User message', prompt,  result?['message'], categories: result?['categories'] ?? [], images: images);
      return result?['message'];
    } catch (e) {
      try {
        final result = await geminiService.sendMessage(prompt, files: images ?? []);
        result?['message'] = result['message'] ?? 'Failed to get a response.';

        await saveMessage(result?['title'] ?? 'User message', prompt,  result?['message'], categories: result?['categories'] ?? [], images: images);
        return result?['message'];
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<String> transcribeAudio(File audioFile) async {
    try {
      final resultAudio = await openAIService.transcribeAudio(audioFile);

      final result = await openAIService.sendMessage(resultAudio);
      result?['message'] = result['message'] ?? 'Failed to get a response.';

      await saveMessage(result?['title'] ?? 'User message', resultAudio,  result?['message'], categories: result?['categories'] ?? []);
      return result?['message'];
    } catch (e) {
      try {
        final audioUrl = await geminiService.transcribeAudio(audioFile, 'audio/mp3');
        final result = await geminiService.sendMessage(null, fileUrl: audioUrl);
        result?['message'] = result['message'] ?? 'Failed to get a response.';

        await saveMessage(result?['title'] ?? 'User message', audioUrl,  result?['message'], categories: result?['categories'] ?? []);
        return result?['message'];
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<List<Map<String, String>>> getSuggestions(List<String> themes) async {
    try {
      return await openAIService.getSuggestions(themes);
    } catch (e) {
      try {
        return await geminiService.getSuggestions(themes);
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> saveMessage(String title, String input, String response, {List<dynamic>? categories = const [], List<File>? images = const []}) async {
    await chatDAO.addMessage(title, input, false, false, categories: categories, files: images);
    await chatDAO.addMessage(title, response, true, false);
  }
}