import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

const loremIpsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet suscipit ligula, nec elementum lorem. Phasellus volutpat sollicitudin lacus, quis pulvinar lectus aliquet nec. Nam vulputate nulla quis imperdiet vulputate. Aenean consequat, risus sed pellentesque convallis, urna ipsum tincidunt nisi, sit amet sagittis magna justo in purus. Aliquam efficitur, nunc eget interdum tincidunt, justo erat fermentum felis, eget consequat orci nulla mattis purus. Cras mollis pellentesque vulputate. Etiam a ligula a turpis placerat pharetra suscipit vel quam. Duis volutpat ultrices libero. Nunc congue nisi id quam vehicula eleifend at ut est. Pellentesque laoreet justo vitae mi rhoncus, id eleifend ante consequat.';

class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey);

  final String _baseUrl = 'https://api.openai.com/v1';

  Future<Map<String, dynamic>> sendMessage(String prompt, {List<File?> files = const [], String model = 'gpt-4o-mini'}) async {
    // throw Exception('Internal test');
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
    // throw Exception('Internal test');
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

  Future<List<Map<String, String>>> getSuggestions(List<String> themes, {String model = 'gpt-4o-mini'}) async {
    // throw Exception('Internal test');
    final url = Uri.parse('$_baseUrl/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    List<dynamic> messages = [
      {
        'role': 'system',
        'content': 'Você é um assistente que sugere ideias para chats baseados em temas fornecidos.'
      },
      {
        'role': 'user',
        'content': 'Sugira chats baseados nos seguintes temas: ${themes.join(", ")}. A quantidade de sugestões deve ser igual a quantidade de temas.'
      },
    ];

    final body = jsonEncode({
      'model': model,
      'messages': messages,
      'temperature': 0.7,
      'response_format': {
        'type': 'json_schema',
        'json_schema': {
          'name': 'suggestions',
          'schema': {
            'type': 'object',
            'properties': {
              'suggestions': {
                'type': 'array',
                'items': {
                  'type': 'string'
                }
              },
            },
            'required': [
              'suggestions',
            ],
            'additionalProperties': false
          },
          'strict': true,
        }
      }
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.body.codeUnits));
        var content = responseData['choices'][0]['message']['content'];

        var tempJson = jsonDecode(content);
        List<dynamic> suggestions = tempJson?['suggestions'] ?? [];
        var index = 0;
        return themes.map((theme) {
          var suggestion = suggestions[index];
          index++;
          return {
            'title': theme,
            'message': suggestion is String ? suggestion : 'No message',
          };
        }).toList();
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to get suggestions');
      }
    } catch (e) {
      print('Exception occurred: $e');
      rethrow;
    }
  }

  // TODO: not implemented
  Future<File?> textToSpeach(String input, {String model = 'tts-1', String voice = 'alloy'}) async {
    return null;
  }
}
