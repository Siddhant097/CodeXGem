import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/chatbot_bloc.dart';
import 'package:flutter_application_1/models/chat_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatbotBloc chatbotBloc = ChatbotBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        toolbarHeight: 80, // Adjust this value as needed
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0), // Padding to lower the text
          child: const Text('CodeXGem'),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(),
        ),
      ),
        body: BlocConsumer<ChatbotBloc, ChatbotState>(
          bloc: chatbotBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case ChatSuccessState:
                List<ChatMessageModel> message =
                    (state as ChatSuccessState).messages;
                return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/code-2.jpg"),
                          fit: BoxFit.fill)),
                  child: Column(children: [
                    Container(
                      height: 120,
                      padding: EdgeInsets.only(left: 10.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: message.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color.fromARGB(255, 119, 2, 243).withOpacity(0.5)),
                                  child: Text(message[index].parts.first.text));
                            })),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 16),
                        // height: 120,
                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: textEditingController,
                              style: TextStyle(color: Colors.black),
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor))),
                            )),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {
                                if (textEditingController.text.isNotEmpty) {
                                  String text = textEditingController.text;
                                  textEditingController.clear();
                                  chatbotBloc.add(
                                      ChatGenerateNewTextMessageEvent(
                                          inputMessage: text));
                                }
                              },
                              child: CircleAvatar(
                                radius: 34,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: const Center(
                                    child:
                                        Icon(Icons.send, color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ]),
                );

              default:
                return SizedBox();
            }
          },
        ));
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
