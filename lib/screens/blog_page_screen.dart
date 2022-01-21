import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:optimize/constants/active_constants.dart';
import 'package:optimize/providers/blog_provider.dart';
import 'package:optimize/providers/one_z_one_provider.dart';
import 'package:optimize/providers/sort_provider.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'blog_detail_screen.dart';

class BlogPageScreen extends StatefulWidget {
  const BlogPageScreen({Key? key}) : super(key: key);

  @override
  _BlogPageScreenState createState() => _BlogPageScreenState();
}

class _BlogPageScreenState extends State<BlogPageScreen> {
  bool _isInit = false;
  bool _isPreloading = false;

  void loadData() async {
    setState(() {
      _isPreloading = true;
    });

    bool sorted = Provider.of<SortProvider>(context, listen: true).sort;
    await Provider.of<BlogProvider>(context, listen: false).getAll(sorted);

    setState(() {
      _isPreloading = false;
    });
  }

  void didChangeDependencies() {
    if (!_isInit) {
      loadData();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isPreloading
            ? FullScreenPreloader()
            : Consumer<BlogProvider>(builder: (context, blogState, child) {
                return ListView.builder(
                  itemCount: blogState.blogs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlogDetailScreen(
                                      blog: blogState.blogs[index]),
                                ),
                              );
                            },
                            child: Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: blogState.blogs[index].image),
                                    Html(data: blogState.blogs[index].title),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Divider(
                            height: 2.0,
                            thickness: 1.0,
                            color: activeColors.grey,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }));
  }
}
