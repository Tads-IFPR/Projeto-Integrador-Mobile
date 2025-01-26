import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

const loremIpsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet suscipit ligula, nec elementum lorem. Phasellus volutpat sollicitudin lacus, quis pulvinar lectus aliquet nec. Nam vulputate nulla quis imperdiet vulputate. Aenean consequat, risus sed pellentesque convallis, urna ipsum tincidunt nisi, sit amet sagittis magna justo in purus. Aliquam efficitur, nunc eget interdum tincidunt, justo erat fermentum felis, eget consequat orci nulla mattis purus. Cras mollis pellentesque vulputate. Etiam a ligula a turpis placerat pharetra suscipit vel quam. Duis volutpat ultrices libero. Nunc congue nisi id quam vehicula eleifend at ut est. Pellentesque laoreet justo vitae mi rhoncus, id eleifend ante consequat.';

class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey);

  final String _baseUrl = 'https://api.openai.com/v1';

  Future<Map<String, dynamic>> sendMessage(String prompt, {List<File?> files = const [], String model = 'gpt-4o-mini'}) async {
    final url = Uri.parse('$_baseUrl/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    List<dynamic> messages = [
      {'role': 'system', 'content': 'Você é um professor de programação.'},
      {'role': 'system', 'content': 'Não responda com caracteres específicos de markdown'},
      {'role': 'system', 'content': 'As categorias da conversa devem ser relacionadas a tecnologia, exemplo: CSS, JS, HTML, PHP, POO, etc.'},
    ];

    if (files.isNotEmpty) {
      List<Map<String, dynamic>> content = [
        {
          'type': 'text',
          'text': prompt
        }
      ];

      for (final file in files) {
        if (file == null) continue;
        Uint8List? imageBytes = file.readAsBytesSync();

        final base64 = base64Encode(imageBytes.toList());
        content.add({
          'type': 'image_url',
          'image_url': {
            "url": "data:image/jpeg;base64,$base64"
          }
        });
      }

      messages.add({'role': 'user', 'content': content});
    } else {
      messages.add({'role': 'user', 'content': prompt});
    }

    final body = jsonEncode({
      'model': model,
      'messages': messages,
      'temperature': 0.7,
      'response_format': {
        'type': 'json_schema',
        'json_schema': {
          'name': 'doubt',
          'schema': {
            'type': 'object',
            'properties': {
              'title': {
                'type': 'string',
              },
              'categories': {
                'type': 'array',
                'items': {
                  'type': 'string'
                }
              },
              'message': {
                'type': 'string',
              },
            },
            'required': [
              'title',
              'message',
              'categories'
            ],
            'additionalProperties': false
          },
          'strict': true,
        }
      } 
    });

    // return {
    //   'title': 'Test',
    //   'message': loremIpsum,
    //   'categories': ['CSS', 'HTML', 'JavaScript'],
    // };

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.body.codeUnits));
        var content = responseData['choices'][0]['message']['content'];

        final aiResp = jsonDecode(content);
        
        return {
          'title': aiResp?['title'],
          'message': aiResp?['message'],
          'categories': aiResp?['categories'],
        };
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to get a response');
      }
    } catch (e) {
      print('Exception occurred: $e');
      rethrow;
    }
  }

  Future<String> transcribeAudio(File audioFile) async {
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

    // return loremIpsum;
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['text']?.trim();
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to get a response');
      }
    } catch (e) {
      print('Exception occurred: $e');
      rethrow;
    }
  }

  // not implemented
  Future<File?> textToSpeach(String input, {String model = 'tts-1', String voice = 'alloy'}) async {
    return null;
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
