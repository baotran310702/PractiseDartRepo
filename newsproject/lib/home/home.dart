import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsproject/home/news/news.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextNews(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed(),
            NewsFeed()
          ],
        ),
      ),
    );
  }
}

class TextNews extends StatelessWidget {
  const TextNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Text("News",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xff1D1A61),
          )),
    );
  }
}
