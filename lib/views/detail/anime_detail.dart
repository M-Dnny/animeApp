import 'dart:developer';

import 'package:anime/provider/service_provider/info/info_provider.dart';
import 'package:anime/utils/extentions.dart';
import 'package:anime/utils/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palette_generator/palette_generator.dart';
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
      log(value.dominantColor!.color.toString());
      setState(() {
        imageColor = value.paletteColors.first.color;
        loading = false;
      });
    }).catchError((e) {
      log(e.toString());
      setState(() {
        loading = false;
        imageColor = Colors.deepOrange;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final infoData = ref.watch(animeInfoProvider);
    return Scaffold(
      body: SafeArea(
        child: infoData.when(
            data: (data) {
              if (loading) {
                getColorPallete(data.image.toString());
              }
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Stack(
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
                        ).animate().fadeIn(
                            duration: const Duration(milliseconds: 800)),
                        WidgetMask(
                          childSaveLayer: true,
                          blendMode: BlendMode.dstIn,
                          mask: SvgPicture.asset(
                            "assets/images/shape3.svg",
                            width: context.width,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: data.image,
                            fit: BoxFit.cover,
                            width: context.width,
                            height: 250,
                            errorWidget: (context, url, error) => Image.asset(
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
                        SvgPicture.asset(
                          "assets/images/outline2.svg",
                          width: context.width,
                          height: 250,
                          colorFilter: ColorFilter.mode(
                            imageColor,
                            BlendMode.srcIn,
                          ),
                        )
                            .animate()
                            .fade(duration: const Duration(milliseconds: 800)),
                        Positioned(
                          width: 98,
                          height: 96,
                          bottom: -11,
                          child: Container(
                            margin: const EdgeInsets.only(left: 2),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                            child: Image.network(
                              data.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
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
