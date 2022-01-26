class VideoFile {
  int id;
  String name;
  String url;
  String subTitle;
  String thumbnail;
  bool isYouTube;
  VideoFile(
      {required this.id,
      required this.name,
      required this.url,
      required this.subTitle,
      required this.isYouTube,
      required this.thumbnail});
}
