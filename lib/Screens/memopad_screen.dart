import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:flutter_todo_app/main.dart';
import 'home_screen.dart';

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

  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            width: double.infinity,
            color: Colors.red,
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontFamily: 'Roboto-Black',
                  ),
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage()), // Navigate to HomeScreen
                  );
                },
              ),
              elevation: 0,
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    final value = (await _keyEditor.currentState?.getText());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text(
                        value ?? 'Success',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ));
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ), // Corrected this line
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: FlutterSummernote(
                hint: 'Your text here...',
                key: _keyEditor,
                customToolbar: """
          [
            ['style', ['bold', 'italic', 'underline', 'clear']],
            ['font', ['strikethrough', 'superscript', 'subscript']],
            ['insert', ['link', 'table', 'hr']]
          ]
        """,
              ),
            ),
            Expanded(child: Container(
              color: Colors.red,
              width: double.infinity,
              height: 400,



            ),),
          ],
        ));
  }
}
