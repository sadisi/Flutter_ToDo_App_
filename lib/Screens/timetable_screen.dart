import 'package:flutter/material.dart';

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
      body: ListView.builder(
        itemCount: timeTableEntries.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                timeTableEntries[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    'Date: ${timeTableEntries[index].date}, ${timeTableEntries[index].month} ${timeTableEntries[index].year}',
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Time: ${timeTableEntries[index].startTime} - ${timeTableEntries[index].endTime}',
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addSchedule(context);
        },
        child: Icon(Icons.add),
      ),
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
}

class AddScheduleScreen extends StatefulWidget {
  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _titleController = TextEditingController();
  String _selectedMonth = 'January';
  String _selectedDate = '1';
  final _yearController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> _dates = List.generate(31, (index) => (index + 1).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Month'),
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
                      decoration: InputDecoration(labelText: 'Date'),
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
              TextField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _startTimeController,
                      decoration: InputDecoration(labelText: 'Start Time'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _endTimeController,
                      decoration: InputDecoration(labelText: 'End Time'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  _saveSchedule(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
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
