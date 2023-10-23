import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 16),
      child: const Row(
        children: [ImageBox(), NewsContent()],
      ),
    );
  }
}

class NewsContent extends StatelessWidget {
  const NewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final String title =
        "Dhaka Division make it two in two; Khulna beat Chattogram by one wicket";
    final String content =
        "Rangpur open their account but Barisal remain winless after their nine-run loss to Rajshahi";
    final String modified = "023-10-23T02:17:20.000Z";
    final String formattedDate = DateFormat('MMM d, yyyy', 'en_US').format(
        DateTime.parse("20" + modified.substring(1, modified.length - 1)));

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 185,
              child: Text(
                title,
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
                title,
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
  const ImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetPath = "assets/news.svg";
    final Widget newsSvg = SvgPicture.asset(assetPath, semanticsLabel: 'bars');
    const networkURL =
        "https://img1.hscicdn.com/image/upload/f_auto,t_ds_wide_w_640,q_50/lsci/db/PICTURES/CMS/348400/348486.5.png";

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          Container(
            width: 160.52,
            height: 101.54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                  image: NetworkImage(networkURL), fit: BoxFit.cover),
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
