import 'package:flutter/material.dart';
import 'package:iitd_app/utils/colors.dart';

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
            const SizedBox(height: 8.0,),
            NormalText500(
                title: emptytext, size: 16, textcolor: AppColors.textColor)
          ],
        ),
      ),
    );
  }
}
