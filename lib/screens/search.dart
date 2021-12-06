import 'package:flutter/material.dart';
import '../constants/active_constants.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: activeColors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Column(
          children: [
            const SizedBox(height: 18.0),
            const Text(
              'Search',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              width: 63.0,
              child: Divider(
                thickness: 2.0,
                color: activeColors.primary,
              ),
            )
          ],
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Card(
        elevation: 1.0,
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.black,
              size: 25.0,
            ),
            const SizedBox(width: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              child: SizedBox(
                height: 30.0,
                width: 250.0,
                child: TextField(
                  cursorColor: activeColors.primary,
                  cursorHeight: 30.0,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (String typedText) {
                    print(typedText);
                    // if (typedText.isNotEmpty) {
                    //   searchProvider.getSearchData(typedText);
                    // }
                  },
                  autofocus: true,
                  decoration: const InputDecoration(
                    // contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Search here!',
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    hintStyle: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
