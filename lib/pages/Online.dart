import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Friends',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Online(),
    );
  }
}

class Online extends StatelessWidget {
  const Online({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,  // Adjust this value as needed
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),  // Padding to lower the text
          child: const Text('Online Friends',style:TextStyle(fontSize: 16),),
          
        ),
      ),  // Removed flexibleSpace here
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/design-2.jpg'),  // Replace with your image path
                fit: BoxFit.cover,  // Adjust as needed (cover, fill, etc.)
              ),
            ),
          ),
          Center(
            child: Text('No Friends Data To Show'),
          ),
        ],
      ),
    );
  }
}
