import 'package:get/get.dart';
import '../models/message_model.dart';

class ChatController extends GetxController {
  RxList messages = <MessageModel>[].obs;
}
