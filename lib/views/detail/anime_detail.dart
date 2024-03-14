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
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    HeaderCard(imageColor: imageColor, data: data),
                    const SizedBox(height: 20),
                    Container(
                      width: context.width * 0.7,
                      alignment: Alignment.center,
                      child: TextScroll(
                        data.name,
                        textAlign: TextAlign.center,
                        mode: TextScrollMode.endless,
                        delayBefore: const Duration(seconds: 2),
                        pauseBetween: const Duration(seconds: 2),
                        intervalSpaces: 10,
                        style: context.textTheme.titleLarge!.copyWith(
                            fontFamily:
                                GoogleFonts.cinzelDecorative().fontFamily,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
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
            imageUrl: data.poster,
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
                imageUrl: data.poster,
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
