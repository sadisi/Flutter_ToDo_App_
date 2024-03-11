import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';

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
          color: Colors.purple,
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
                // Handle back button press
              },
            ),
            elevation: 0,
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  // Handle save button press
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 500.0,
              width: double.infinity,
              child: Expanded(
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
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.purple,
              height: 270,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  buildContainer(),
                  buildContainer(),
                  buildContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer() {
    return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 45,
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.only(left: 300),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ));
  }
}
