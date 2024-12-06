// // import 'package:flutter/material.dart';
// // import 'package:littlab/view/vedio_screen.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// // class CourseVideosScreen extends StatefulWidget {
// //   @override
// //   _CourseVideosScreenState createState() => _CourseVideosScreenState();
// // }

// // class _CourseVideosScreenState extends State<CourseVideosScreen> {
// //   final List<Map<String, dynamic>> videos = [
// //     {
// //       "title": "Introduction",
// //       "duration": "2 Min 18 Sec",
// //       "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
// //       "unlocked": true
// //     },
// //     {
// //       "title": "What is UI/UX Design?",
// //       "duration": "18 Min 46 Sec",
// //       "url": "https://www.youtube.com/watch?v=2VauBWLXnvA",
// //       "unlocked": false
// //     },
// //     {
// //       "title": "How to Make Wireframes",
// //       "duration": "20 Min 58 Sec",
// //       "url": "https://www.youtube.com/watch?v=w7ejDZ8SWv8",
// //       "unlocked": false
// //     },
// //     {
// //       "title": "Your First Design",
// //       "duration": "20 Min 58 Sec",
// //       "url": "https://www.youtube.com/watch?v=3tMdZv4aLVk",
// //       "unlocked": false
// //     },
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Course Videos"),
// //         backgroundColor: Colors.purple,
// //       ),
// //       body: ListView.builder(
// //         itemCount: videos.length,
// //         itemBuilder: (context, index) {
// //           final video = videos[index];
// //           return ListTile(
// //             leading: Icon(
// //               video['unlocked'] ? Icons.play_circle_fill : Icons.lock,
// //               color: video['unlocked'] ? Colors.purple : Colors.grey,
// //             ),
// //             title: Text(video['title']),
// //             subtitle: Text(video['duration']),
// //             onTap: video['unlocked']
// //                 ? () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => VideoScreen(
// //                           video: video,
// //                           onVideoWatched: () {
// //                             setState(() {
// //                               if (index + 1 < videos.length) {
// //                                 videos[index + 1]['unlocked'] = true;
// //                               }
// //                             });
// //                           },
// //                         ),
// //                       ),
// //                     );
// //                   }
// //                 : null,
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:littlab/controller/course_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// // Adjust the path

// class CourseListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final courses = Provider.of<CourseProvider>(context).courses;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Courses'),
//         backgroundColor: Colors.purple,
//       ),
//       body: ListView.builder(
//         itemCount: courses.length,
//         itemBuilder: (context, index) {
//           final course = courses[index];
//           return ListTile(
//             title: Text(course.name),
//             trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => VideoListScreen(course: course),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class VideoListScreen extends StatelessWidget {
//   final Course course;

//   VideoListScreen({required this.course});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(course.name),
//         backgroundColor: Colors.purple,
//       ),
//       body: ListView.builder(
//         itemCount: course.videos.length,
//         itemBuilder: (context, index) {
//           final video = course.videos[index];
//           return ListTile(
//             leading: Icon(Icons.play_circle, color: Colors.purple),
//             title: Text(video.title),
//             subtitle: Text(video.duration),
//             onTap: () async {
//               final url = video.url;
//               if (await canLaunch(url)) {
//                 await launch(url);
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Could not open video')),
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class Video {
//   final String title;
//   final String url; // YouTube or private video URL
//   final String duration;

//   Video({required this.title, required this.url, required this.duration});
// }

// class Course {
//   final String name;
//   final List<Video> videos;

//   Course({required this.name, required this.videos});
// }
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
    if (currentIndex + 1 < videos.length && !videos[currentIndex + 1]['unlocked']) {
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
