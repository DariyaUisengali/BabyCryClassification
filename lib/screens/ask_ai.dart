import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AskAIPage extends StatefulWidget {
  @override
  _AskAIPageState createState() => _AskAIPageState();
}

class _AskAIPageState extends State<AskAIPage> {
  TextEditingController _textEditingController = TextEditingController();
  List<Map<String, String>> _messages = [];
  final String openAiKey = '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';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF32343E),
      appBar: AppBar(
        title: Text(
          'Ask AI',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = _messages.length - 1 - index;
                final message = _messages[reversedIndex];

                return Align(
                  alignment: message['role'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: message['role'] == 'user'
                          ? Color(0xFF98FB98)
                          : Color(0xFF787D96),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      message['content'] ?? '',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Color(0xFF494E64),
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF494E64),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormField(
                      controller: _textEditingController,
                      onFieldSubmitted: (_) {
                        _sendMessage();
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 14.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF98FB98)),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    String message = _textEditingController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({
          'role': 'user',
          'content': message,
        });
        _textEditingController.clear();
        _messages.add({
          'role': 'assistant',
          'content': 'Typing...',
        });
      });

      // Make API request to OpenAI
      String botResponse = await chatGPTAPI(message);

      setState(() {
        _messages.removeLast();
        _messages.add({
          'role': 'assistant',
          'content': botResponse,
        });
      });
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': 'Hello! How can I assist you today?'},
            {'role': 'user', 'content': prompt},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['choices'][0]['message']['content'];
      } else {
        return 'Error fetching bot response: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error fetching bot response: $e';
    }
  }
}
