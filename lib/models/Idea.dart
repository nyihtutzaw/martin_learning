// ignore: file_names
import 'package:optimize/models/PdfFile.dart';

import 'AudioFile.dart';
import 'Poster.dart';
import 'VideoFile.dart';

class Idea {
  int id;
  String title;
  String subtitle;
  String description;
  String thumbnail;
  List<PdfFile> pdfFiles;
  List<AudioFile> audioFiles;
  List<VideoFile> videoFiles;
  List<Poster> posters;
  String poster_image;
  bool isLiked;
  bool isTipped;
  bool isBooked;
  bool isSub;
  bool isUtube;
  String video;

  Idea(
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
        required this.posters,
      required this.isSub,
      required this.video,
      required this.isUtube,
      required this.isBooked});
}
