// ignore: file_names
import 'package:optimize/models/AudioFile.dart';
import 'package:optimize/models/Category.dart';
import 'package:optimize/models/PdfFile.dart';
import 'package:optimize/models/VideoFile.dart';

class Pn {
  int id;
  String title;
  String authorName;

  String subtitle;
  String description;
  String coverImage;

  String introVideo;
  String introThumbnail;
  String introDescription;
  bool isLiked;
  bool isTipped;
  bool isBooked;
  bool isSub;
  List<Category> categories;
  List<PdfFile> pdfFiles;
  List<AudioFile> audioFiles;
  List<VideoFile> videoFiles;

  Pn({
    required this.id,
    required this.title,
    required this.authorName,
    required this.subtitle,
    required this.description,
    required this.coverImage,
    required this.introVideo,
    required this.introDescription,
    required this.introThumbnail,
    required this.isBooked,
    required this.isTipped,
    required this.isLiked,
    required this.categories,
    required this.pdfFiles,
    required this.audioFiles,
    required this.videoFiles,
    required this.isSub,
  });
}
