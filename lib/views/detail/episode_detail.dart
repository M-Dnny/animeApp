import 'dart:developer';

import 'package:anime/services/episodes/episodes_service.dart';
import 'package:anime/utils/components/loading.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class EpisodeDetail extends ConsumerStatefulWidget {
  const EpisodeDetail({super.key, required this.episodeId});
  final String episodeId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EpisodeDetailState();
}

class _EpisodeDetailState extends ConsumerState<EpisodeDetail> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool isLoading = true;
  bool isInit = true;

  initVideo() async {
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
      autoInitialize: true,
      showOptions: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      zoomAndPan: true,
      customControls: const CupertinoControls(
        backgroundColor: Colors.grey,
        iconColor: Colors.white,
      ),
    );

    setState(() {
      isLoading = false;
    });
  }

  // get video link

  getLink() async {
    EpisodesService()
        .getEpisodesSrc(id: widget.episodeId, category: "sub")
        .then((value) => {
              log("Link: ${value.sources[0].url}"),
              videoPlayerController = VideoPlayerController.networkUrl(
                Uri.parse(value.sources[0].url),
              ),
              initVideo(),
            });
  }

  @override
  void initState() {
    super.initState();

    getLink();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Visibility(
          visible: !isLoading,
          replacement: const Center(child: LoadingScreen()),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Video Player

                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AspectRatio(
                        aspectRatio: chewieController.aspectRatio!.toDouble(),
                        child: Chewie(controller: chewieController)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
