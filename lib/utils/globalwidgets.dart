import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BoldText extends StatelessWidget {
  const BoldText({
    super.key,
    required this.title,
    required this.size,
    required this.textcolor,
  });

  final String title;
  final double size;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: textcolor,
          fontSize: size,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class NormalText500 extends StatelessWidget {
  const NormalText500({
    super.key,
    required this.title,
    required this.size,
    required this.textcolor,
  });

  final String title;
  final double size;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: size,
          color: textcolor,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class NormalText200 extends StatelessWidget {
  const NormalText200({
    super.key,
    required this.title,
    required this.size,
    required this.textcolor,
  });

  final String title;
  final double size;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: size,
          color: textcolor,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class NormalText400 extends StatelessWidget {
  const NormalText400({
    super.key,
    required this.title,
    required this.size,
    required this.textcolor,
  });

  final String title;
  final double size;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: size,
          color: textcolor,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({super.key, required this.emptytext});

  final String emptytext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColorLight.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Column(
          children: [
            Image.asset('assets/gifs/teacup.gif'),
            const SizedBox(
              height: 8.0,
            ),
            NormalText500(
                title: emptytext, size: 16, textcolor: AppColors.textColor)
          ],
        ),
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  final String text;

  const LinkText({super.key, required this.text});

  static final RegExp _urlRegExp = RegExp(r'http(s)?://\S+');

  Widget _extractAndDisplayLinks() {
    final List<TextSpan> textSpans = [];
    int startIndex = 0;

    for (final match in _urlRegExp.allMatches(text)) {
      textSpans.add(TextSpan(
        text: text.substring(startIndex, match.start),
        style: TextStyle(
            color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      ));
      startIndex = match.end;

      final link = text.substring(match.start, match.end);
      textSpans.add(
        TextSpan(
            text: link,
            style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                fontFamily: GoogleFonts.poppins().fontFamily),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(Uri.parse(link))),
      );
    }

    textSpans.add(TextSpan(
      text: text.substring(startIndex),
      style: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
    ));

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _extractAndDisplayLinks();
  }
}
