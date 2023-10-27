import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsFeed extends StatelessWidget {
  final String? title;
  final String? summary;
  final String? modifiedAt;
  final String? image;

  const NewsFeed(
      {super.key, this.title, this.summary, this.modifiedAt, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ImageBox(
            img: image,
          ),
          NewsContent(
            title: title,
            content: summary,
            modified: modifiedAt,
          )
        ],
      ),
    );
  }
}

class NewsContent extends StatelessWidget {
  final String? title;
  final String? content;
  final String? modified;

  const NewsContent({super.key, this.title, this.content, this.modified});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMM d, yyyy', 'en_US').format(
        DateTime.parse("20" + modified!.substring(1, modified!.length - 1)));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 185,
              child: Text(
                title!,
                style: GoogleFonts.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1D1A61)),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 3,
              ),
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 185,
              child: Text(
                title!,
                style: GoogleFonts.openSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1D1A61)),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 185,
              alignment: Alignment.centerRight,
              child: Text(
                formattedDate,
                style: GoogleFonts.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1D1A61),
                    fontStyle: FontStyle.italic),
                overflow: TextOverflow.clip,
                softWrap: true,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class ImageBox extends StatelessWidget {
  final String? img;
  const ImageBox({super.key, this.img});

  @override
  Widget build(BuildContext context) {
    const String assetPath = "assets/news.svg";
    final Widget newsSvg = SvgPicture.asset(assetPath, semanticsLabel: 'bars');

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          Container(
            width: 160.52,
            height: 101.54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image:
                  DecorationImage(image: NetworkImage(img!), fit: BoxFit.cover),
            ),
            child: null,
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFE9A0C),
              ),
              child: SizedBox(
                width: 10,
                height: 10,
                child: newsSvg,
              ),
            ),
          )
        ],
      ),
    );
  }
}
