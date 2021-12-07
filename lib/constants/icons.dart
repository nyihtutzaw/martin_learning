import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'active_constants.dart';

class KIcons {
  final IconData doc;
  final IconData volume;
  final IconData playFill;
  final IconData home;
  final IconData diam;
  final IconData noti;
  final IconData cloud;
  final IconData profile;
  final IconData walker;
  final IconData podcast;
  final Widget search;
  final Widget diamond;
  final Widget calendar;
  final Widget file;
  final Widget player;
  final Widget playerFill;
  final Widget playerCircleFill;
  final Widget heart;
  final Widget download;
  final Widget filter;

  const KIcons({
    required this.doc,
    required this.volume,
    required this.playFill,
    required this.home,
    required this.diam,
    required this.noti,
    required this.cloud,
    required this.profile,
    required this.walker,
    required this.podcast,
    required this.search,
    required this.diamond,
    required this.calendar,
    required this.file,
    required this.player,
    required this.playerFill,
    required this.playerCircleFill,
    required this.heart,
    required this.download,
    required this.filter,
  });
}

KIcons icon1 = KIcons(
  doc: CupertinoIcons.doc_text,
  volume: CupertinoIcons.volume_up,
  playFill: CupertinoIcons.play_rectangle_fill,
  home: CupertinoIcons.home,
  diam: CupertinoIcons.suit_diamond,
  noti: Icons.notifications,
  cloud: CupertinoIcons.cloud,
  profile: CupertinoIcons.profile_circled,
  walker: Icons.directions_walk_rounded,
  podcast: Icons.podcasts_rounded,
  search: const Icon(
    CupertinoIcons.search,
    color: Colors.white,
    size: 24.0,
  ),
  diamond: const Icon(CupertinoIcons.suit_diamond),
  calendar: const Icon(Icons.calendar_today_outlined),
  file: const Icon(CupertinoIcons.doc_text),
  player: const Icon(CupertinoIcons.play_rectangle),
  playerFill: const Icon(CupertinoIcons.play_rectangle_fill),
  // playerCircleFill: Icon(
  //   Icons.play_circle_rounded,
  //   size: 39.0,
  //   color: activeColors.primary,
  // ),
  playerCircleFill: Align(
    alignment: Alignment.center,
    child: Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: activeColors.primary,
      ),
      child: Icon(
        Icons.play_arrow_rounded,
        color: activeColors.white,
      ),
    ),
  ),
  heart: const Icon(CupertinoIcons.suit_heart_fill),
  download: Container(
    decoration: BoxDecoration(
      border: Border.all(
        width: 2.0,
        color: activeColors.grey,
      ),
      shape: BoxShape.circle,
    ),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Icon(
        CupertinoIcons.cloud_download,
        color: activeColors.primary,
        size: 16.0,
      ),
    ),
  ),
  filter: Container(
    decoration: BoxDecoration(
      border: Border.all(
        width: 2.0,
        color: activeColors.white,
      ),
      shape: BoxShape.circle,
    ),
    child: const Icon(
      Icons.filter_list,
      size: 14.0,
    ),
  ),
);
