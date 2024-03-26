import 'package:anime/utils/components/loading.dart';
import 'package:anime/utils/extentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_scroll/text_scroll.dart';

class AnimeCard extends StatelessWidget {
  const AnimeCard({
    super.key,
    required this.poster,
    required this.title,
    required this.textScroll,
    this.shadow = false,
    this.shadowColor = Colors.grey,
  });

  final String poster;
  final String title;
  final bool? shadow;
  final bool textScroll;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 190,
          width: 150,
          margin:
              const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 3),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.5),
              boxShadow: shadow == true
                  ? [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                        spreadRadius: 2,
                      )
                    ]
                  : null),
          child: CachedNetworkImage(
            imageUrl: poster,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/errimage.png",
              fit: BoxFit.cover,
            ),
            progressIndicatorBuilder: (context, url, progress) => const Center(
              child: LoadingShimmer(
                height: 220,
                width: 150,
                radius: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Center(
            child: textScroll
                ? TextScroll(
                    title,
                    velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                    textAlign: TextAlign.center,
                    mode: TextScrollMode.endless,
                    pauseBetween: const Duration(seconds: 5),
                    fadedBorder: true,
                    fadedBorderWidth: 0.1,
                    fadeBorderSide: FadeBorderSide.right,
                    intervalSpaces: 20,
                    style: context.textTheme.titleSmall!.copyWith(
                        fontFamily: GoogleFonts.cinzelDecorative().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface),
                  )
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: context.textTheme.titleSmall!.copyWith(
                        fontFamily: GoogleFonts.cinzelDecorative().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface),
                  ),
          ),
        ),
      ],
    );
  }
}
