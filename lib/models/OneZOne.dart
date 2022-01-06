// ignore: file_names
import 'package:optimize/models/PdfFile.dart';

import 'AudioFile.dart';
import 'VideoFile.dart';

class OneZOne {
  int id;
  String title;
  String subtitle;
  String description;
  String thumbnail;
  List<PdfFile> pdfFiles;
  List<AudioFile> audioFiles;
  List<VideoFile> videoFiles;
  String poster_image;
  bool isLiked;
  bool isTipped;
  bool isBooked;
  bool isSub;

  OneZOne(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.thumbnail,
      required this.poster_image,
      required this.isTipped,
      required this.isLiked,
      required this.pdfFiles,
      required this.audioFiles,
      required this.videoFiles,
      required this.isSub,
      required this.isBooked});
}
