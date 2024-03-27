import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContestStanding extends StatefulWidget {
  const ContestStanding({Key? key}) : super(key: key);

  @override
  State<ContestStanding> createState() => _ContestStandingState();
}

class _ContestStandingState extends State<ContestStanding> {
  List<dynamic> standing = [];
  TextEditingController _contestController = TextEditingController();
  String? contestIdUserInput;
  bool isLoading = false;
  String? errorText;

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchStanding() async {
    
    if (contestIdUserInput == null || contestIdUserInput!.isEmpty) {
      setState(() {
        errorText = 'Please enter a contest ID.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorText = null;
    });

    final url = Uri.parse(
      'https://codeforces.com/api/contest.standings?contestId=$contestIdUserInput&from=1&count=500&showUnofficial=true',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          standing = json.decode(response.body)['result']['rows'];
        });
      } else {
        throw Exception(
            'Failed to load standing (status code: ${response.statusCode})');
      }
    } catch (error) {
      setState(() {
        errorText = 'Error fetching standing: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Use Stack to position the background image
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/design-2.jpg'), // Replace with your image path
                fit: BoxFit.cover, // Adjust as needed (cover, fill, etc.)
              ),
            ),
          ),
          SingleChildScrollView(
            // Wrap body in SingleChildScrollView
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _contestController,
                    decoration: InputDecoration(
                      labelText: 'Enter Contest ID',
                      errorText: errorText,
                    ),
                    onSubmitted: (value) {
                      contestIdUserInput = value;
                      fetchStanding();
                    },
                  ),
                ),
                errorText != null
                    ? Text(errorText!)
                    : isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            controller: ScrollController(),
                            shrinkWrap:
                                true, // Prevent list view from expanding
                            itemCount: standing.length,
                            itemBuilder: (BuildContext context, int index) {
                              final contestant = standing[index];
                              return ListTile(
                                title: Text(contestant['party']['members'][0]
                                    ['handle']),
                                subtitle:
                                    Text('Points: ${contestant['points']}'),
                              );
                            },
                          ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 80, // Adjust this value as needed
        title: Padding(
          padding:
              const EdgeInsets.only(top: 20.0), // Padding to lower the text
          child: const Text(
            'Contest Standings',
            style: TextStyle(fontSize: 16),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContestStanding(),
  ));
}
