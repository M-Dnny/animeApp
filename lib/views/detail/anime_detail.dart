import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:anime/models/info_model/info_model.dart';
import 'package:anime/provider/service_provider/info/info_provider.dart';
import 'package:anime/utils/extentions.dart';
import 'package:anime/utils/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:widget_mask/widget_mask.dart';

class AnimeDetail extends ConsumerStatefulWidget {
  const AnimeDetail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimeDetailState();
}

class _AnimeDetailState extends ConsumerState<AnimeDetail> {
  Color imageColor = Colors.white;
  bool loading = true;
  String currentImg = "";

  Future<void> getColorPallete(image) async {
    await PaletteGenerator.fromImageProvider(
      NetworkImage(image),
      maximumColorCount: 1,
    ).then((value) {
      setState(() {
        imageColor = value.paletteColors.first.color;
        loading = false;
      });
    }).catchError((e) {
      setState(() {
        loading = false;
        imageColor = Colors.deepOrange;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // initVideo();
  }

  /* final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
    "https://vd2.biananset.net/_v7/2d78cde20ab313272f3ad8bd5be5c8a09e945a5cf051238957b55cf52e76180dc307a020fa794579877bff94ffd0f4173e4f09102830b73f590a89b04f2364172f04567b029f1530ccf948f7611a49f2e55a73da718b6a60471da343c0827aa189bf80ca740e2f2066f88ac4155b37939f34a2faee93a19e02730f0504a4b732/master.m3u8",
  ));
  late ChewieController chewieController;

  initVideo() async {
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
    );
  } */

  @override
  Widget build(BuildContext context) {
    final infoData = ref.watch(animeInfoProvider);
    return Scaffold(
      body: SafeArea(
        child: infoData.when(
            data: (item) {
              final data = item.info;
              if (loading) {
                getColorPallete(data.poster.toString());
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderCard(imageColor: imageColor, data: data),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: context.width * 0.7,
                          alignment: Alignment.center,
                          child: TextScroll(
                            data.name,
                            velocity:
                                const Velocity(pixelsPerSecond: Offset(50, 0)),
                            textAlign: TextAlign.center,
                            mode: TextScrollMode.endless,
                            pauseBetween: const Duration(seconds: 2),
                            intervalSpaces: 10,
                            style: context.textTheme.titleLarge!.copyWith(
                                fontFamily:
                                    GoogleFonts.cinzelDecorative().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: const ShapeDecoration(
                                color: Colors.amber,
                                shape: StarBorder(
                                  innerRadiusRatio: 0.5,
                                  pointRounding: 0.2,
                                  valleyRounding: 0.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.moreInfo.malscore == "?"
                                  ? "N/A"
                                  : item.moreInfo.malscore,
                              style: context.textTheme.titleMedium,
                            ),
                          ]),
                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconText(
                            title: item.moreInfo.premiered,
                            icon: Iconsax.calendar_25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: 1,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          IconText(
                            icon: Iconsax.video5,
                            title: data.stats.quality,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: 1,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          IconText(
                            title: item.moreInfo.duration,
                            icon: Iconsax.clock5,
                          ),
                        ],
                      ),

                      // GENRES

                      const SizedBox(height: 30),

                      Text("Genres", style: context.textTheme.titleMedium),
                      const SizedBox(height: 5),
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        children: item.moreInfo.genres
                            .map((genre) => Chip(
                                  padding: const EdgeInsets.all(0),
                                  label: Text(genre),
                                ))
                            .toList(),
                      ),

                      const SizedBox(height: 30),

                      // Description

                      Text("Description", style: context.textTheme.titleMedium),
                      const SizedBox(height: 5),
                      AnimatedReadMoreText(
                        data.description,
                        maxLines: 3,
                        animationCurve: Curves.linear,
                        textStyle: context.textTheme.labelMedium,
                      ),

                      // Seasons

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            },
            error: (error, stackTrace) => Center(
                  child: Text(infoData.error.toString()),
                ),
            loading: () => const Center(
                  child: LoadingScreen(),
                )),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 5),
        Text(
          title,
          style: context.textTheme.titleSmall,
        ),
      ],
    );
  }
}

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    super.key,
    required this.imageColor,
    required this.data,
  });

  final Color imageColor;
  final InfoModel data;

  @override
  Widget build(BuildContext context) {
    final poster = data.poster.replaceFirst('300x400', '1920x1080');
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 290,
          height: 190,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: imageColor,
              blurRadius: 50,
              offset: const Offset(0, 20),
              spreadRadius: 20,
            )
          ]),
        ).animate().fadeIn(duration: const Duration(milliseconds: 800)),
        WidgetMask(
          childSaveLayer: true,
          blendMode: BlendMode.dstIn,
          mask: SvgPicture.asset(
            "assets/images/shape3.svg",
            width: context.width,
          ),
          child: CachedNetworkImage(
            imageUrl: poster,
            fit: BoxFit.cover,
            width: context.width,
            height: 250,
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/errimage.png",
              fit: BoxFit.cover,
            ),
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
                color: context.colorScheme.tertiary,
              ),
            ),
          ),
        ),
        SvgPicture.asset(
          "assets/images/outline2.svg",
          width: context.width,
          height: 250,
          colorFilter: ColorFilter.mode(
            imageColor,
            BlendMode.srcIn,
          ),
        ).animate().fade(duration: const Duration(milliseconds: 800)),
        Positioned(
          width: 98,
          height: 96,
          bottom: -11,
          child: Hero(
            tag: data.poster,
            flightShuttleBuilder: (flightContext, animation, flightDirection,
                fromHeroContext, toHeroContext) {
              return fromHeroContext.widget;
            },
            child: Container(
              margin: const EdgeInsets.only(left: 2),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: CachedNetworkImage(
                imageUrl: poster,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/errimage.png",
                  fit: BoxFit.cover,
                ),
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: context.colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
