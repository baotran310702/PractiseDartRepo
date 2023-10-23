import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final String assetName = "assets/menu.svg";
    final Widget svg = SvgPicture.asset(assetName, semanticsLabel: 'bars');

    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 107,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF1D1A61), Color(0xFF18DAB8)])),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: svg,
                ),
                Text("My News",
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                Container(
                  child: null,
                )
              ],
            )),
      ),
    );
  }
}
