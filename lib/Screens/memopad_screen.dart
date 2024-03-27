import 'package:flutter/material.dart';

void main() {
  runApp(MemoPadScreen());
}

class MemoPadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesPage(title: 'Memo Pad'),
    );
  }
}

class NotesPage extends StatefulWidget {
  NotesPage({required this.title});

  final String title;

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> todoItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3FF),
      appBar: AppBar(
        backgroundColor: Color(0xFF674AEF),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.black,
            fontFamily: 'Roboto-Regular',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: TextField(
                controller: _textEditingController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Enter your text here...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.white60,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: todoItems.length,
              itemBuilder: (context, index) {
                return buildContainer(todoItems[index]);
              },
            ),
          ),
          // buildSaveButton(),
        ],
      ),
    );
  }

  Widget buildContainer(String text) {
    final String cleanedText = text.replaceAll(RegExp(r'<[^>]*>'), '');
    final String limitedText = cleanedText.split(' ').take(12).join(' ');

    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 45,
      width: double.infinity,
      child: InkWell(
        onTap: () => null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                limitedText,
                style: TextStyle(fontSize: 15),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: () => setState(() => todoItems.remove(text)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }

