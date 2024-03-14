import 'dart:math';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:anime/provider/service_provider/info/info_provider.dart';
import 'package:anime/provider/service_provider/popular/popular_provider.dart';
import 'package:anime/provider/service_provider/top/top_airing_provider.dart';
import 'package:anime/provider/service_provider/upcoming/upcoming_provider.dart';
import 'package:anime/provider/theme_provider/theme_provider.dart';
import 'package:anime/utils/extentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: const Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Most Popular Anime Episodes
              Header(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(children: [
                  // Upcoming Anime

                  UpcomingRender(),

                  SizedBox(height: 20),

                  // Top Airing Anime
                  TopAiring(),
                ]),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class TopAiring extends ConsumerWidget {
  const TopAiring({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topAiring = ref.watch(topAiringProvider);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Top Airing",
            style: context.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 20),
        topAiring.when(
            data: (data) {
              return SizedBox(
                height: 220,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final double leftPadding =
                          index == 0 ? 30.0 : (index < 9 ? 40.0 : 100.0);
                      return GestureDetector(
                        onTap: () {
                          ref.watch(animeInfoIdProvider.notifier).state =
                              data[index].id.toString();
                          context.pushNamed('animeDetail');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: SizedBox(
                            width: 220,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: -20,
                                  left: index == 0
                                      ? -20
                                      : (index < 9 ? -40.0 : -110.0),
                                  child: Text(
                                    "${index + 1}",
                                    textHeightBehavior:
                                        const TextHeightBehavior(
                                      applyHeightToFirstAscent: false,
                                    ),
                                    style: context.textTheme.headlineLarge!
                                        .copyWith(
                                      fontSize: 180,
                                      fontFamily:
                                          GoogleFonts.concertOne().fontFamily,
                                      foreground: Paint()
                                        ..strokeWidth = 3
                                        ..style = PaintingStyle.stroke
                                        ..color =
                                            context.colorScheme.onBackground,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 190,
                                      width: 150,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(18.5),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: data[index].image,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          "assets/images/errimage.png",
                                          fit: BoxFit.cover,
                                        ),
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                            color: context.colorScheme.tertiary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: SizedBox(
                                          width: 150,
                                          child: Text(
                                            data[index].title,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: context.textTheme.titleSmall!
                                                .copyWith(
                                                    fontFamily: GoogleFonts
                                                            .cinzelDecorative()
                                                        .fontFamily,
                                                    fontWeight: FontWeight.bold,
                                                    color: context
                                                        .colorScheme.onSurface),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => Center(
                  child: CircularProgressIndicator(
                    color: context.colorScheme.tertiary,
                  ),
                )),
      ],
    );
  }
}

class UpcomingRender extends ConsumerWidget {
  const UpcomingRender({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcoming = ref.watch(upcomingProvider);
    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Upcoming",
              style: context.textTheme.titleLarge,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 5)),
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_left_rounded, size: 20),
                  label: Text(
                    "See All",
                    style: context.textTheme.bodyLarge,
                  )),
            )
          ],
        ),

        // body

        const SizedBox(height: 20),

        upcoming.when(
            data: (data) {
              return SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: min(data.length, 10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                              height: 190,
                              width: 150,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.5),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: data[index].image,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/errimage.png",
                                  fit: BoxFit.cover,
                                ),
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                    value: progress.progress,
                                    color: context.colorScheme.tertiary,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: SizedBox(
                                  width: 150,
                                  child: Text(
                                    data[index].title,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: context.textTheme.titleSmall!
                                        .copyWith(
                                            fontFamily:
                                                GoogleFonts.cinzelDecorative()
                                                    .fontFamily,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                context.colorScheme.onSurface),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => Center(
                  child: CircularProgressIndicator(
                    color: context.colorScheme.tertiary,
                  ),
                ))
      ],
    );
  }
}

class Header extends ConsumerWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeMode = ref.watch(themeStateProvider);
    const lightMode = ThemeMode.light;
    const darkMode = ThemeMode.dark;

    onChange(switcher) {
      ref.watch(themeStateProvider.notifier).state =
          themeMode == lightMode ? darkMode : lightMode;
      switcher.changeTheme(
        isReversed: themeMode == darkMode ? true : false,
        theme: themeMode == lightMode
            ? darkThemeData(context.textTheme)
            : lightThemeData(context.textTheme),
      );
    }

    return Stack(
      children: [
        const ImageContainer(),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                gradient: themeMode == darkMode
                    ? const LinearGradient(
                        colors: [
                          Colors.black54,
                          Colors.black45,
                          Colors.black38,
                          Colors.black26,
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null),
            width: context.width,
            child: ThemeSwitcher.switcher(builder: (_, switcher) {
              return GestureDetector(
                onTap: () => onChange(switcher),
                child: Image.asset(
                  "assets/images/logo.png",
                  color: context.colorScheme.onBackground,
                  width: 60,
                  height: 60,
                ),
              );
            })),
      ],
    );
  }
}

class ImageContainer extends ConsumerWidget {
  const ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularImages = ref.watch(popularProvider);

    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(30),
            bottomEnd: Radius.circular(30),
          ),
        ),
        child: popularImages.when(
            data: (data) {
              return CarouselSlider(
                options: CarouselOptions(
                  // autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  height: context.heigth * 0.55,
                  enlargeFactor: 0.3,
                ),
                items: data
                    .map((e) => Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              foregroundDecoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.9),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: CachedNetworkImage(
                                  imageUrl: e.image,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        "assets/images/notFound1.gif",
                                        fit: BoxFit.cover,
                                      ),
                                  progressIndicatorBuilder: (context, url,
                                          progress) =>
                                      Center(
                                        child: CircularProgressIndicator(
                                          value: progress.progress,
                                          color: context.colorScheme.tertiary,
                                        ),
                                      ),
                                  width: context.width),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: SizedBox(
                                width: context.width * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.title,
                                      style: context.textTheme.displaySmall!
                                          .copyWith(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontFamily:
                                            GoogleFonts.cinzelDecorative()
                                                .fontFamily,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Popular Episode ${e.episodes}",
                                      style: context.textTheme.titleMedium!
                                          .copyWith(
                                              fontFamily: GoogleFonts.cinzel()
                                                  .fontFamily,
                                              color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              );
            },
            error: (error, stackTrace) => SizedBox(
                  height: context.heigth * 0.55,
                  child: Center(child: Text(error.toString())),
                ),
            loading: () => SizedBox(
                  height: context.heigth * 0.55,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                )));
  }
}
