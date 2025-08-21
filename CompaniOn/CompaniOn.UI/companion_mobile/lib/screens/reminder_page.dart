import 'package:companion_mobile/core/routes/app_routes.dart';
import 'package:companion_mobile/screens/add_reminder.screen.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:companion_mobile/models/reminder.dart';
import 'package:companion_mobile/providers/reminder_provider.dart';

class ReminderPage extends StatefulWidget {
  final int userId;

  const ReminderPage({super.key, required this.userId}); 

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  late ReminderProvider _reminderProvider;
  List<Reminder> _reminders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _reminderProvider = context.read<ReminderProvider>();
    _fetchReminders();
  }

  Future<void> _fetchReminders() async {
    try {
      var result = await _reminderProvider.getPaged(
        filter:
        {'PageSize': 1000},
      );
      setState(() {
        _reminders = result.items
            .where((reminder) => reminder.userId == widget.userId)
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading reminders: $e')),
      );
    }
  }

  Future<void> _deleteReminder(int id) async {
    try {
      await _reminderProvider.delete(id);
      setState(() {
        _reminders.removeWhere((reminder) => reminder.id == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reminder deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting reminder: $e')),
      );
    }
  }

  void _navigateToAddReminder() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReminderPage(userId: widget.userId),
      ),
    );

    // Check if reminder was successfully added
    if (result == true) {
      _fetchReminders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
         iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _reminders.isEmpty
              ? const Center(child: Text('No reminders found.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: _reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = _reminders[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Row(
                            children: [
                              Icon(Icons.access_alarm, color: Colors.green), // Icon added here
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  reminder.message,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Colors.green), // Icon for time
                                  const SizedBox(width: 10),
                                  Text(
                                    'Time: ${reminder.time.toLocal().toString().split('.')[0]}',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5), // Add some space between time and type
                              Row(
                                children: [
                                  Icon(Icons.category, color: Colors.green), // Icon for type
                                  const SizedBox(width: 10),
                                  Text(
                                    'Type: ${reminder.type}',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteReminder(reminder.id),
                          ),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddReminder,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Reminder',
      ),
    );
  }
}
