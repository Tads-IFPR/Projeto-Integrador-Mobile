import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

const loremIpsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet suscipit ligula, nec elementum lorem. Phasellus volutpat sollicitudin lacus, quis pulvinar lectus aliquet nec. Nam vulputate nulla quis imperdiet vulputate. Aenean consequat, risus sed pellentesque convallis, urna ipsum tincidunt nisi, sit amet sagittis magna justo in purus. Aliquam efficitur, nunc eget interdum tincidunt, justo erat fermentum felis, eget consequat orci nulla mattis purus. Cras mollis pellentesque vulputate. Etiam a ligula a turpis placerat pharetra suscipit vel quam. Duis volutpat ultrices libero. Nunc congue nisi id quam vehicula eleifend at ut est. Pellentesque laoreet justo vitae mi rhoncus, id eleifend ante consequat.';

class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey);

  final String _baseUrl = 'https://api.openai.com/v1';

  Future<String?> sendMessage(String prompt, {String model = 'gpt-4o-mini'}) async {
    final url = Uri.parse('$_baseUrl/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'system', 'content': 'Você é um professor de programação.'},
        {'role': 'user', 'content': prompt}
      ],
      'temperature': 0.7,
      'max_tokens': 150,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return utf8.decode(responseData['choices'][0]['message']['content']?.trim().codeUnits);
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  Future<String?> transcribeAudio(File audioFile) async {
    final url = Uri.parse('$_baseUrl/audio/transcriptions');
    final headers = {
      'Authorization': 'Bearer $apiKey',
    };

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    request.files.add(
      http.MultipartFile(
        'file',
        audioFile.readAsBytes().asStream(),
        audioFile.lengthSync(),
        filename: audioFile.path.split('/').last,
      ),
    );
    request.fields['model'] = 'whisper-1';

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['text']?.trim();
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  Future<File?> textToSpeach(String input, {String model = 'tts-1', String voice = 'alloy'}) async {
   final url = Uri.parse('$_baseUrl/audio/speech');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      'model': model,
      'input': input,
      'voice': voice,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final audioData = jsonDecode(response.body)?.trim();
        if (audioData == null) return null;

        final audioBytes = base64Decode(audioData);
        final directory = await getApplicationDocumentsDirectory();
        final fileName = 'audio-${DateTime.now().millisecondsSinceEpoch}.mp3';
        final filePath = '${directory.path}/$fileName';

        await File(filePath).writeAsBytes(audioBytes);

        return File(filePath);
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }
}
