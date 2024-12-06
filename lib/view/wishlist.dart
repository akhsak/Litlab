import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoLearningPage extends StatefulWidget {
  @override
  _VideoLearningPageState createState() => _VideoLearningPageState();
}

class _VideoLearningPageState extends State<VideoLearningPage> {
  final List<Map<String, dynamic>> videos = [
    {
      "title": "Introduction to UI/UX Design",
      "duration": "2 Min 18 Sec",
      "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      "unlocked": true,
    },
    {
      "title": "What is UI/UX Design?",
      "duration": "18 Min 46 Sec",
      "url": "https://www.youtube.com/watch?v=2VauBWLXnvA",
      "unlocked": false,
    },
    {
      "title": "How to Make Wireframes",
      "duration": "20 Min 58 Sec",
      "url": "https://www.youtube.com/watch?v=w7ejDZ8SWv8",
      "unlocked": false,
    },
    {
      "title": "Your First Design",
      "duration": "20 Min 58 Sec",
      "url": "https://www.youtube.com/watch?v=3tMdZv4aLVk",
      "unlocked": false,
    },
  ];

  late YoutubePlayerController _controller;
  Map<String, dynamic>? selectedVideo;

  @override
  void initState() {
    super.initState();
    selectedVideo = videos[0];
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(selectedVideo!['url'])!,
      flags: YoutubePlayerFlags(
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

  void _unlockNextVideo() {
    final currentIndex = videos.indexOf(selectedVideo!);
    if (currentIndex + 1 < videos.length &&
        !videos[currentIndex + 1]['unlocked']) {
      setState(() {
        videos[currentIndex + 1]['unlocked'] = true;
      });
    }
  }

  void _playVideo(Map<String, dynamic> video) {
    setState(() {
      selectedVideo = video;
      _controller.load(YoutubePlayer.convertUrlToId(video['url'])!);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UI/UX Design Course"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          // Video Player Section
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.purple,
          ),
          // Video Details Section
          if (selectedVideo != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedVideo!['title'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("Duration: ${selectedVideo!['duration']}"),
                  SizedBox(height: 10),
                  Text(
                    "This video provides an in-depth explanation of UI/UX design and serves as an essential part of your learning journey.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          Divider(),
          // Playlist Section
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return ListTile(
                  leading: Icon(
                    video['unlocked'] ? Icons.play_circle_fill : Icons.lock,
                    color: video['unlocked'] ? Colors.purple : Colors.grey,
                  ),
                  title: Text(video['title']),
                  subtitle: Text(video['duration']),
                  onTap: video['unlocked']
                      ? () => _playVideo(video)
                      : null, // Only allow tapping if unlocked
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
