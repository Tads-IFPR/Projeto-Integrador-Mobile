import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

const loremIpsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet suscipit ligula, nec elementum lorem. Phasellus volutpat sollicitudin lacus, quis pulvinar lectus aliquet nec. Nam vulputate nulla quis imperdiet vulputate. Aenean consequat, risus sed pellentesque convallis, urna ipsum tincidunt nisi, sit amet sagittis magna justo in purus. Aliquam efficitur, nunc eget interdum tincidunt, justo erat fermentum felis, eget consequat orci nulla mattis purus. Cras mollis pellentesque vulputate. Etiam a ligula a turpis placerat pharetra suscipit vel quam. Duis volutpat ultrices libero. Nunc congue nisi id quam vehicula eleifend at ut est. Pellentesque laoreet justo vitae mi rhoncus, id eleifend ante consequat.';

class Geminiservice {
  final String apiKey;

  Geminiservice(this.apiKey);

  final String _baseUrl = 'https://generativelanguage.googleapis.com';

  Future<Map<String, dynamic>> sendMessage(String? prompt, {List<File?> files = const [], String model = 'gemini-1.5-flash', String? fileUrl}) async {
    final url = Uri.parse('$_baseUrl/v1beta/models/$model:generateContent?key=$apiKey');
    final headers = {
      'Content-Type': 'application/json',
    };

    List<dynamic> messages = [];

    if (prompt != null) {
      messages.add({'text': prompt});
    }
    if (files.isNotEmpty) {

      for (final file in files) {
        if (file == null) continue;
        Uint8List? imageBytes = file.readAsBytesSync();

        final base64 = base64Encode(imageBytes.toList());
        messages.add({
          'inline_data': {
            "mime_type":"image/jpeg",
             "data": "data:image/jpeg;base64,$base64"
          }
        });
      }
    }

    if (fileUrl != null) {
      messages.add({
        "file_data":{
          "mime_type": "audio/mp3",
          "file_uri": fileUrl
        }
      });
    }

    final body = jsonEncode({
      "system_instruction": {
        "parts": [
          {
            "text": "Você é um professor de programação."
          },
          {
            "text": "Não responda com caracteres específicos de markdown"
          },
          {
            "text": "As categorias da conversa devem ser relacionadas a tecnologia, exemplo: CSS, JS, HTML, PHP, POO, etc."
          },
        ]
      },
      'contents': {
        'parts': messages,
      },
      "generationConfig": {
        "response_mime_type": "application/json",
        "response_schema": {
          "type": "OBJECT",
          "properties": {
            "title": {
              "type": "STRING"
            },
            "categories": {
              "type": "ARRAY",
              "items": {
                "type": "STRING"
              }
            },
            "message": {
              "type": "STRING"
            }
          },
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
        var content = responseData['candidates'][0]['content']['parts'][0]['text'];

        final aiResp = jsonDecode(content);
        
        return {
          'title': aiResp?['title'],
          'message': aiResp?['message'],
          'categories': aiResp?['categories'],
        };
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to get response');
      }
    } catch (e) {
      print('Exception occurred: $e');
      rethrow;
    }
  }

  Future<String> transcribeAudio(File file, String mimeType) async {
    final url = Uri.parse('$_baseUrl/upload/v1beta/files?key=$apiKey');
    final headers = {
      'X-Goog-Upload-Protocol': 'resumable',
      'X-Goog-Upload-Command': 'start',
      'X-Goog-Upload-Header-Content-Length': '${file.lengthSync()}',
      'X-Goog-Upload-Header-Content-Type': mimeType,
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({'file': {'display_name': file.path.split('/').last}});

    // return 'http:/localhost/teste.png';

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final uploadUrl = response.headers['x-goog-upload-url'];
        if (uploadUrl == null) {
          print('Error: No upload URL returned');
          throw Exception('Failed to get upload URL');
        }

        final fileBytes = file.readAsBytesSync();
        final uploadResponse = await http.post(
          Uri.parse(uploadUrl),
          headers: {
            'Content-Length': '${fileBytes.length}',
            'X-Goog-Upload-Offset': '0',
            'X-Goog-Upload-Command': 'upload, finalize',
          },
          body: fileBytes,
        );

        if (uploadResponse.statusCode == 200) {
          final fileInfo = jsonDecode(uploadResponse.body);
          return fileInfo['file']['uri'];
        } else {
          print('Error during file upload: ${uploadResponse.statusCode}');
          throw Exception('Failed to upload file');
        }
      } else {
        print('Error initializing upload: ${response.statusCode}');
        throw Exception('Failed to initialize upload');
      }
    } catch (e) {
      print('Exception during file upload: $e');
      rethrow;
    }
  }

  // not implemented
  Future<File?> textToSpeach(String input, {String model = 'tts-1', String voice = 'alloy'}) async {
    return null;
  }
}