import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProblemSet extends StatefulWidget {
  const ProblemSet({Key? key}) : super(key: key);

  @override
  _ProblemSetState createState() => _ProblemSetState();
}

class _ProblemSetState extends State<ProblemSet> {
  late List<dynamic> _problems;
  TextEditingController _tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProblems();
  }

  Future<void> _fetchProblems() async {
    String? tags = _tagController.text;
    // ignore: unnecessary_null_comparison
    if (tags == null || tags.isEmpty) {
      setState(() {
        _problems = [];
      });
      return;
    }

    const String apiUrl = 'https://codeforces.com/api/problemset.problems?tags=';

    try {
      final response = await http.get(Uri.parse(apiUrl + tags));
      final jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _problems = jsonData['result']['problems'];
        });
      } else {
        throw Exception('Failed to load problems');
      }
    } catch (error) {
      print('Error fetching problems: $error');
      setState(() {
        _problems = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,  // Adjust this value as needed
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),  // Padding to lower the text
          child: const Text('Problem Set'),
        ),
      ),
      body: Stack(
        children: [
          // Background image container
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/design-2.jpg'),  // Replace with your image path
                fit: BoxFit.cover,  // Adjust as needed (cover, fill, etc.)
              ),
            ),
          ),
          // Column containing content
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Tags(Example:dp)',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _fetchProblems(),
                ),
              ),
              Expanded(
                child: _problems.isEmpty
                    ? const Center(child: Text('No problems found'))
                    : ListView.builder(
                        itemCount: _problems.length,
                        itemBuilder: (context, index) {
                          final problem = _problems[index];
                          return ListTile(
                            title: Text(problem['name']),
                            subtitle: Text(problem['index']),
                            onTap: () {
                              // Handle onTap event if needed
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProblemSet(),
  ));
}
