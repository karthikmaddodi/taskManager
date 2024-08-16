import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  DateTime _startDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  // Track selected priority
  String _selectedPriority = '';

  void _previousWeek() {
    setState(() {
      _startDate = _startDate.subtract(const Duration(days: 7));
      _selectedDate = _startDate;
    });
  }

  void _nextWeek() {
    setState(() {
      _startDate = _startDate.add(const Duration(days: 7));
      _selectedDate = _startDate;
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  List<DateTime> get _weekDates {
    return List.generate(7, (index) => _startDate.add(Duration(days: index)));
  }

  String get _formattedDateRange {
    return '${DateFormat('dd MMM').format(_startDate)} - ${DateFormat('dd MMM').format(_startDate.add(const Duration(days: 6)))}';
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDarkTheme ? Colors.white : Colors.black;
    final buttonBorderColor = isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_left),
                    onPressed: _previousWeek,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        _formattedDateRange,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: _nextWeek,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _weekDates.map((date) {
                  bool isSelected = date == _selectedDate;
                  return GestureDetector(
                    onTap: () => _onDateSelected(date),
                    child: SizedBox(
                      width: 50, // Fixed width for each date container
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(color: Colors.purple, width: 2)
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              DateFormat('EEE').format(date),
                              style: TextStyle(
                                color: isSelected ? Colors.purple : primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat('dd').format(date),
                              style: TextStyle(
                                color: isSelected ? Colors.purple : primaryTextColor,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            if (isSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                height: 4,
                                width: 4,
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Schedule',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.access_time),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.access_time),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Priority',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedPriority = 'High';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedPriority == 'High' ? Colors.purple : Colors.transparent,
                      foregroundColor: _selectedPriority == 'High' ? Colors.white : primaryTextColor,
                      side: BorderSide(color: buttonBorderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('High'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedPriority = 'Medium';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedPriority == 'Medium' ? Colors.purple : Colors.transparent,
                      foregroundColor: _selectedPriority == 'Medium' ? Colors.white : primaryTextColor,
                      side: BorderSide(color: buttonBorderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Medium'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedPriority = 'Low';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedPriority == 'Low' ? Colors.purple : Colors.transparent,
                      foregroundColor: _selectedPriority == 'Low' ? Colors.white : primaryTextColor,
                      side: BorderSide(color: buttonBorderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Low'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DropdownButtonHideUnderline(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black, // Background color of the button
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    border: Border.all(
                      color: Colors.purple, // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text(
                      'Assign to',
                      style: TextStyle(color: Colors.white), // Text color for hint
                    ),
                    items: <String>['Person 1', 'Person 2', 'Person 3'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {
                      // Handle dropdown selection
                    },
                    style: const TextStyle(
                      color: Colors.white, // Text color inside the dropdown
                    ),
                    dropdownColor: Colors.purple, // Background color of the dropdown menu
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    iconSize: 24,
                    underline: Container(), // Hides the underline
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle create task action
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Create Task',
                    style: TextStyle(
                      color: Colors.white,// Text color inside the dropdown
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
