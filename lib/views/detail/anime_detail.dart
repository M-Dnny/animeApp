import 'dart:async';
import 'dart:math';

import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:anime/models/info_model/info_model.dart';
import 'package:anime/provider/service_provider/info/info_provider.dart';
import 'package:anime/utils/components/anime_card.dart';
import 'package:anime/utils/components/loading.dart';
import 'package:anime/utils/components/outline_shape.dart';
import 'package:anime/utils/extentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:text_scroll/text_scroll.dart';

class AnimeDetail extends ConsumerStatefulWidget {
  const AnimeDetail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimeDetailState();
}

final currentSeasonIndexProvider = StateProvider<int>((ref) => 0);
final currentSeasonImgProvider = StateProvider<String>((ref) {
  return "";
});

final episodeLengthProvider = StateProvider<int>((ref) {
  return 0;
});

final containerWidthProvider = StateProvider<double>((ref) {
  return 50;
});

class _AnimeDetailState extends ConsumerState<AnimeDetail> {
  // late ChewieController chewieController;
  ScrollController scrollController = ScrollController();

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

  /* final videoPlayerController = VideoPlayerController.networkUrl(
    Uri.parse(
      "https://vd2.biananset.net/_v7/2d78cde20ab313272f3ad8bd5be5c8a09e945a5cf051238957b55cf52e76180dc307a020fa794579877bff94ffd0f4173e4f09102830b73f590a89b04f2364172f04567b029f1530ccf948f7611a49f2e55a73da718b6a60471da343c0827aa189bf80ca740e2f2066f88ac4155b37939f34a2faee93a19e02730f0504a4b732/master.m3u8",
    ),
  );

  initVideo() async {
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
      autoInitialize: false,
      showOptions: false,
    );
  } */

  @override
  Widget build(BuildContext context) {
    final infoData = ref.watch(animeInfoProvider);

    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          ref.read(containerWidthProvider.notifier).state = 50;
          ref.read(episodeLengthProvider.notifier).state = 0;
          Navigator.pop(context);
        },
        child: SafeArea(
          child: infoData.when(
              data: (item) {
                final data = item.info;

                if (loading) {
                  getColorPallete(data.poster.toString());
                  Future.delayed(const Duration(milliseconds: 5), () {
                    ref.watch(currentSeasonImgProvider.notifier).state =
                        data.poster;
                  });
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
                              velocity: const Velocity(
                                  pixelsPerSecond: Offset(50, 0)),
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
                                item.moreInfo.malscore.contains("?")
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                            if (!item.moreInfo.duration.contains("?"))
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 1,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            if (!item.moreInfo.duration.contains("?"))
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

                        Text("Description",
                            style: context.textTheme.titleMedium),
                        const SizedBox(height: 5),
                        if (data.description.isNotEmpty)
                          AnimatedReadMoreText(
                            data.description,
                            maxLines: 3,
                            animationCurve: Curves.linear,
                            textStyle: context.textTheme.labelMedium,
                          ),

                        if (data.description.isEmpty)
                          const Text(
                            "No description available",
                          ),

                        // Seasons

                        const SizedBox(height: 30),

                        item.seasonModel.isEmpty
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Seasons",
                                      style: context.textTheme.titleMedium),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    height: 250,
                                    child: ListView.builder(
                                      itemCount: item.seasonModel.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final seasonItem =
                                            item.seasonModel[index];

                                        if (seasonItem.isCurrent) {
                                          Future.delayed(
                                              const Duration(milliseconds: 100),
                                              () {
                                            ref
                                                .watch(
                                                    currentSeasonIndexProvider
                                                        .notifier)
                                                .state = index;
                                          });
                                        }

                                        return SeasonCard(
                                          seasonItem: seasonItem,
                                          shadowColor: imageColor,
                                          index: index,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                        const SizedBox(height: 10),

                        // Episodes

                        Text("Episodes", style: context.textTheme.titleMedium),
                        const SizedBox(height: 15),

                        SizedBox(
                          height: 250,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: scrollController,
                            child: Row(
                              children: [
                                ref.watch(episodeListProvider).when(
                                    data: (data) {
                                      Future.delayed(
                                          const Duration(milliseconds: 10), () {
                                        ref
                                            .watch(
                                                episodeLengthProvider.notifier)
                                            .state = data.episodes.length;
                                      });
                                      return GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 2 / 3,
                                          crossAxisSpacing: 2,
                                          mainAxisSpacing: 2,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount:
                                            min(data.episodes.length, 10),
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Container(
                                                clipBehavior: Clip.hardEdge,
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                foregroundDecoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black
                                                          .withOpacity(0.1),
                                                      Colors.black
                                                          .withOpacity(0.8),
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: ref.watch(
                                                      currentSeasonImgProvider),
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    "assets/images/errimage.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          const Center(
                                                    child: LoadingShimmer(
                                                      height: 220,
                                                      width: 150,
                                                      radius: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                left: 15,
                                                child: Text(
                                                  "Episode ${data.episodes[index].number}",
                                                  style: context
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    error: (error, stackTrace) =>
                                        Text(error.toString()),
                                    loading: () => SizedBox(
                                          width: context.width - 100,
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )),
                                const SizedBox(width: 10),
                                if (ref.watch(episodeLengthProvider) >= 10)
                                  InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      final width =
                                          ref.watch(containerWidthProvider);
                                      if (width == 50) {
                                        ref
                                            .watch(
                                                containerWidthProvider.notifier)
                                            .state = 100;
                                        Timer(const Duration(milliseconds: 205),
                                            () {
                                          scrollController.animateTo(
                                              scrollController
                                                  .position.maxScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              curve: Curves.easeIn);
                                        });
                                      } else {
                                        debugPrint("Go to View All");
                                      }
                                    },
                                    child: AnimatedContainer(
                                      alignment: Alignment.centerRight,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      margin: const EdgeInsets.only(right: 5),
                                      height: 240,
                                      width: ref.watch(containerWidthProvider),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 5),
                                            if (ref.watch(
                                                    containerWidthProvider) ==
                                                100)
                                              Text(
                                                "View All",
                                                style:
                                                    context.textTheme.bodyLarge,
                                              ).animate().fadeIn(
                                                    duration: const Duration(
                                                        seconds: 1),
                                                  ),
                                            const Icon(
                                                Icons.chevron_right_rounded,
                                                size: 30),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              error: (error, stackTrace) => Center(
                    child: SizedBox(
                      width: context.width - 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/sleep.png", height: 250),
                          const SizedBox(height: 20),
                          Text(
                            "A glitch?${"\n"}Await the dawn for my 'Wake-Up Repair Jutsu' unleash!",
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
              loading: () => const Center(
                    child: LoadingScreen(),
                  )),
        ),
      ),
    );
  }
}

class SeasonCard extends ConsumerWidget {
  final SeasonModel seasonItem;
  final int index;
  final Color shadowColor;

  const SeasonCard({
    super.key,
    required this.seasonItem,
    required this.index,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCurrent = ref.watch(currentSeasonIndexProvider) == index;
    final poster = seasonItem.poster.replaceFirst('100x200', '1920x1080');

    return GestureDetector(
      onTap: () => {
        ref.read(currentSeasonIndexProvider.notifier).state = index,
      },
      child: AnimeCard(
        title: seasonItem.name,
        poster: poster,
        shadow: isCurrent,
        shadowColor: shadowColor,
        textScroll: true,
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
        SizedBox(
          width: context.width,
          height: context.width * 0.6450617283950617,
          child: ClipPath(
            clipper: RPSCustomClipper(),
            child: Container(
              height: context.width * 0.6450617283950617,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(poster),
                    fit: BoxFit.cover),
              ),
              child: CustomPaint(
                size: Size(context.width, context.width * 0.6450617283950617),
                painter: RPSCustomPainter(strokeColor: imageColor),
              ).animate().fade(duration: const Duration(milliseconds: 800)),
            ),
          ),
        ),
        Positioned(
          width: context.width * 0.260,
          height: context.width * 0.238,
          bottom: context.heigth * -0.013,
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
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(
                      child: LoadingShimmer(height: 96, width: 98, radius: 18)),
            ),
          ),
        ),
      ],
    );
  }
}
