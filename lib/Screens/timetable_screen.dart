import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TimeTableScreen(),
  ));
}

class TimeTableScreen extends StatefulWidget {
  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  List<TimeTableEntry> timeTableEntries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Table'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildTimeTable()),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _addSchedule(context);
            },
            child: Text('Add Schedule'),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeTable() {
    return ListView.builder(
      itemCount: timeTableEntries.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(timeTableEntries[index].title), // Unique key for each entry
          onDismissed: (direction) {
            setState(() {
              timeTableEntries.removeAt(index); // Remove the entry from the list
            });
          },
          background: Container(
            color: Colors.blue, // Background color when swiping to delete
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  timeTableEntries[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      'Date: ${timeTableEntries[index].date}, ${timeTableEntries[index].month} ${timeTableEntries[index].year}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Time: ${timeTableEntries[index].startTime} - ${timeTableEntries[index].endTime}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: () {
                  _editSchedule(context, index);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _addSchedule(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddScheduleScreen()),
    );
    if (result != null) {
      setState(() {
        timeTableEntries.add(result);
      });
    }
  }

  void _editSchedule(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddScheduleScreen(
          existingEntry: timeTableEntries[index],
        ),
      ),
    );
    if (result != null) {
      setState(() {
        timeTableEntries[index] = result;
      });
    }
  }
}

class AddScheduleScreen extends StatefulWidget {
  final TimeTableEntry? existingEntry;

  AddScheduleScreen({this.existingEntry});

  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  late TextEditingController _titleController;
  late String _selectedMonth;
  late String _selectedDate;
  late TextEditingController _yearController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> _dates = List.generate(31, (index) => (index + 1).toString());

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingEntry?.title ?? '');
    _selectedMonth = widget.existingEntry?.month ?? 'January';
    _selectedDate = widget.existingEntry?.date ?? '1';
    _yearController = TextEditingController(text: widget.existingEntry?.year ?? '');
    _startTimeController = TextEditingController(text: widget.existingEntry?.startTime ?? '');
    _endTimeController = TextEditingController(text: widget.existingEntry?.endTime ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingEntry != null ? 'Edit Schedule' : 'Add Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Month',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    value: _selectedMonth,
                    items: _months.map((month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMonth = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    value: _selectedDate,
                    items: _dates.map((date) {
                      return DropdownMenuItem<String>(
                        value: date,
                        child: Text(date),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDate = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _yearController,
              decoration: InputDecoration(
                labelText: 'Year',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _startTimeController,
                    decoration: InputDecoration(
                      labelText: 'Start Time',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _endTimeController,
                    decoration: InputDecoration(
                      labelText: 'End Time',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _saveSchedule(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Save', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSchedule(BuildContext context) {
    final title = _titleController.text;
    final year = _yearController.text;
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;

    if (title.isNotEmpty &&
        year.isNotEmpty &&
        startTime.isNotEmpty &&
        endTime.isNotEmpty) {
      final newEntry = TimeTableEntry(
        title: title,
        year: year,
        month: _selectedMonth,
        date: _selectedDate,
        startTime: startTime,
        endTime: endTime,
      );
      Navigator.pop(context, newEntry);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill all fields'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class TimeTableEntry {
  final String title;
  final String year;
  final String month;
  final String date;
  final String startTime;
  final String endTime;

  TimeTableEntry({
    required this.title,
    required this.year,
    required this.month,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}
