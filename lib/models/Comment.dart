import 'package:optimize/models/User.dart';

class CommentModel {
  final int id;
  final User user;
  final String body;
  final String reply;

  CommentModel({
    required this.id,
    required this.user,
    required this.body,
    required this.reply,
  });
}
