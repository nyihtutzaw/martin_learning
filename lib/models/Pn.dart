// ignore: file_names
import 'package:optimize/models/Category.dart';

class Pn {
  int id;
  String title;
  String authorName;
  String pdf;
  String subtitle;
  String description;
  String coverImage;
  String video;
  String audio;
  String introVideo;
  String introThumbnail;
  String introDescription;
  bool isLiked;
  bool isTipped;
  bool isBooked;
  List<Category> categories;

  Pn({
    required this.id,
    required this.title,
    required this.authorName,
    required this.pdf,
    required this.subtitle,
    required this.description,
    required this.coverImage,
    required this.video,
    required this.audio,
    required this.introVideo,
    required this.introDescription,
    required this.introThumbnail,
    required this.isBooked,
    required this.isTipped,
    required this.isLiked,
    required this.categories,
  });
}
