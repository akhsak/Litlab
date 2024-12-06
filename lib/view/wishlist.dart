import 'package:flutter/material.dart';
import 'package:littlab/controller/course_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CourseProvider>(context).courses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return ListTile(
            title: Text(course.name),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoListScreen(course: course),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VideoListScreen extends StatelessWidget {
  final Course course;

  VideoListScreen({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: ListView.builder(
        itemCount: course.videos.length,
        itemBuilder: (context, index) {
          final video = course.videos[index];
          return ListTile(
            leading: Icon(Icons.play_circle, color: Colors.purple),
            title: Text(video.title),
            subtitle: Text(video.duration),
            onTap: () async {
              final Uri url = Uri.parse(video.url);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Could not open video')),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class Video {
  final String title;
  final String url; // YouTube or private video URL
  final String duration;

  Video({required this.title, required this.url, required this.duration});
}

class Course {
  final String name;
  final List<Video> videos;

  Course({required this.name, required this.videos});
}
