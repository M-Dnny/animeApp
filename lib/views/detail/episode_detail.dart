import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EpisodeDetail extends ConsumerStatefulWidget {
  const EpisodeDetail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EpisodeDetailState();
}

class _EpisodeDetailState extends ConsumerState<EpisodeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episode Detail'),
      ),
    );
  }
}
