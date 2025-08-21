import 'package:companion_mobile/models/reminderInsert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:companion_mobile/providers/reminder_provider.dart';

class AddReminderPage extends StatefulWidget {
  final int userId;

  const AddReminderPage({super.key, required this.userId});

  @override
  _AddReminderPageState createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final _formKey = GlobalKey<FormState>();
  String _message = '';
  String _type = 'Medicine';
  DateTime _time = DateTime.now();
  bool _repeatAlarm = false;

  late ReminderProvider _reminderProvider;

  @override
  void initState() {
    super.initState();
    _reminderProvider = context.read<ReminderProvider>();
  }

  Future<void> _saveReminder() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final newReminder = ReminderInsert(
      id: 0,
      userId: widget.userId,
      type: _type,
      message: _message,
      time: _time,
      repeat: _repeatAlarm,
      isAcknowledged: false,
    );

    try {
      await _reminderProvider.insert(newReminder.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reminder added successfully!')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding reminder: $e')),
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _time,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = DateTime(picked.year, picked.month, picked.day, _time.hour, _time.minute);
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_time),
    );
    if (picked != null) {
      setState(() {
        _time = DateTime(_time.year, _time.month, _time.day, picked.hour, picked.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Add Reminder', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  label: 'Message',
                  onSaved: (value) {
                    _message = value!;
                  },
                  validator: (value) => value!.isEmpty ? 'Please enter a message' : null,
                ),
                const SizedBox(height: 20),
                _buildDropdown(),
                const SizedBox(height: 20),
                _buildDateTimePicker(),
                const SizedBox(height: 20),
                _buildRepeatSwitch(),
                const SizedBox(height: 30),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
      onSaved: onSaved,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _type,
      decoration: InputDecoration(
        labelText: 'Type',
        labelStyle: TextStyle(color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
      items: const [
        DropdownMenuItem(value: 'Medicine', child: Text('Medicine')),
        DropdownMenuItem(value: 'Other', child: Text('Other')),
      ],
      onChanged: (value) {
        setState(() {
          _type = value!;
        });
      },
      onSaved: (value) {
        _type = value!;
      },
    );
  }

  Widget _buildDateTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Reminder Date'),
          subtitle: Text(
            '${_time.year}-${_time.month.toString().padLeft(2, '0')}-${_time.day.toString().padLeft(2, '0')}',
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: _selectDate,
          contentPadding: EdgeInsets.zero,
        ),
        const Divider(color: Colors.green),
        ListTile(
          title: const Text('Reminder Time'),
          subtitle: Text(
            '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}',
          ),
          trailing: const Icon(Icons.access_time),
          onTap: _selectTime,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildRepeatSwitch() {
    return SwitchListTile(
      title: const Text('Repeat every day'),
      value: _repeatAlarm,
      onChanged: (value) {
        setState(() {
          _repeatAlarm = value;
        });
      },
      activeColor: Colors.green,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity, // Button spans the entire width
      child: ElevatedButton(
        onPressed: _saveReminder,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(vertical: 18.0),
        ),
        child: const Text(
          'Save Reminder',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
