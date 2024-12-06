import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyLearning extends StatefulWidget {
  final String? title;

  const MyLearning({super.key, this.title});

  @override
  _MyLearningState createState() => _MyLearningState();
}

class _MyLearningState extends State<MyLearning> {
  final List<Map<String, dynamic>> videos = [
    {
      "title": "Introduction to UI/UX Design",
      "duration": "10 Min 13 Sec",
      "url":
          "https://www.youtube.com/watch?v=9gTw2EDkaDQ", // Valid UI/UX Intro Video
      "unlocked": true,
    },
    {
      "title": "What is UI/UX Design?",
      "duration": "7 Min 29 Sec",
      "url":
          "https://www.youtube.com/watch?v=T6TjmKA6Axk", // Valid Explanation Video
      "unlocked": false,
    },
    {
      "title": "How to Make Wireframes",
      "duration": "12 Min 48 Sec",
      "url":
          "https://www.youtube.com/watch?v=oL3Jm1RWOTM", // Wireframes Tutorial
      "unlocked": false,
    },
    {
      "title": "Your First Design",
      "duration": "18 Min 32 Sec",
      "url":
          "https://www.youtube.com/watch?v=Z8_HvF6bmi4", // Beginner Design Walkthrough
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "UI UX Design",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Player Section
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.purple,
              ),
              const SizedBox(height: 20),
              // Course Details Section
              const Text(
                "Figma UI UX Design Essentials",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Text(
                    "Created by Artur Denisovich",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  const Text("4.8"),
                  const SizedBox(width: 20),
                  const Icon(Icons.access_time, color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  const Text("72 Hours"),
                  const Spacer(),
                  const Text(
                    "\$40",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Tab Section
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Playlist(22)",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      onPressed: () {},
                      child: const Text("Description"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Playlist Section
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          video['unlocked']
                              ? Icons.play_circle_fill
                              : Icons.lock,
                          color:
                              video['unlocked'] ? Colors.purple : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: video['unlocked']
                                ? () => _playVideo(video)
                                : null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  video['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  video['duration'],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Enroll Now Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                    child: Text(
                      "Enroll Now",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
