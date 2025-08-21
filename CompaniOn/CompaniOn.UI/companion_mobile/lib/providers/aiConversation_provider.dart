import 'package:companion_mobile/models/aiConversation.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class AiConversationProvider extends BaseProvider<AiConversation>{
AiConversationProvider(): super("AIConversation");

  @override
  AiConversation fromJson(data) {
    return AiConversation.fromJson(data);
  }
}