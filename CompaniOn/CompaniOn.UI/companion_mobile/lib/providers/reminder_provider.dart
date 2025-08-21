import 'package:companion_mobile/models/reminder.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class ReminderProvider extends BaseProvider<Reminder>{
ReminderProvider(): super("Reminder");

  @override
  Reminder fromJson(data) {
    return Reminder.fromJson(data);
  }
}