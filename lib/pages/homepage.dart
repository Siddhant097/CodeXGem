import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final String apiKey =
      "0b2fa05bc5c69948b6ca0cdfeba043ed18f48b1a"; // Replace with your API key
  late Future<Map<String, dynamic>> _userData;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _userData = _fetchUserData("siddhant"); // Example username (fetch on init)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack( // Use Stack to position the background image
        children: [
          // Background image container
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/design-2.jpg'), // Replace with your image path
                fit: BoxFit.cover,
                // Adjust as needed (cover, fill, etc.)
              ),
            ),
          ),
          Center( // Center content on top of the background
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String username = _usernameController.text.trim();
                    if (username.isNotEmpty) {
                      setState(() {
                        _userData = _fetchUserData(username);
                      });
                    }
                  },
                  child: const Text('Fetch Data'),
                ),
                // ... other buttons and widgets
                 ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/problemset');
              },
              child: const Text('ProblemSet data'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/conteststanding');
              },
              child: const Text('Contest Standing'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/online');
              },
              child: const Text('Online Data'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home_page');
              },
              child: const Text('CodeXGem'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        100.0), // Adjust corner radius as desired
                    side: BorderSide(
                        color: Color.fromARGB(255, 243, 227, 3),
                        width: 2.0), // White border
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.transparent), // Transparent background
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.deepPurple), // Text color (optional)
              ),
            ),
                const SizedBox(height: 20),
                FutureBuilder<Map<String, dynamic>>(
                  future: _userData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return Text(
                        "Rating: ${snapshot.data!['result'][0]['rating']}",
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return const Text("No data available");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserData(String username) async {
    final String url = "https://codeforces.com/api/user.info?handles=$username";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('status') &&
            responseData['status'] == 'OK') {
          List<dynamic> userList = responseData['result'];
          if (userList.isNotEmpty) {
            return responseData;
          } else {
            throw Exception('User not found');
          }
        } else {
          throw Exception('Failed to load user data');
        }
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
