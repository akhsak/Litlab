import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> videos = [
    {
      "title": "Introduction to UI/UX Design",
      "duration": "10 Min 13 Sec",
      "url": "https://www.youtube.com/watch?v=9gTw2EDkaDQ",
      "unlocked": true,
    },
    {
      "title": "What is UI/UX Design?",
      "duration": "7 Min 29 Sec",
      "url": "https://www.youtube.com/watch?v=T6TjmKA6Axk",
      "unlocked": false,
    },
    {
      "title": "How to Make Wireframes",
      "duration": "12 Min 48 Sec",
      "url": "https://www.youtube.com/watch?v=oL3Jm1RWOTM",
      "unlocked": false,
    },
    {
      "title": "Your First Design",
      "duration": "18 Min 32 Sec",
      "url": "https://www.youtube.com/watch?v=Z8_HvF6bmi4",
      "unlocked": false,
    },
  ];

  late YoutubePlayerController _controller;
  Map<String, dynamic>? _selectedVideo;

  VideoProvider() {
    _selectedVideo = videos[0];
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(_selectedVideo!['url'])!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.metaData.duration) {
        _unlockNextVideo();
      }
    });
  }

  YoutubePlayerController get controller => _controller;
  Map<String, dynamic>? get selectedVideo => _selectedVideo;

  void playVideo(Map<String, dynamic> video) {
    _selectedVideo = video;
    _controller.load(YoutubePlayer.convertUrlToId(video['url'])!);
    notifyListeners();
  }

  void _unlockNextVideo() {
    final currentIndex = videos.indexOf(_selectedVideo!);
    if (currentIndex + 1 < videos.length &&
        !videos[currentIndex + 1]['unlocked']) {
      videos[currentIndex + 1]['unlocked'] = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
