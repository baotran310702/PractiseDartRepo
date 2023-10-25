import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsproject/bloc/news_bloc.dart';
import 'dart:developer' as developer;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Start Home Page");
    developer.log('log me', name: 'my.app.category');
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
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
            color: const Color(0xff1D1A61),
          )),
    );
  }
}
