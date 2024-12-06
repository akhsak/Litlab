// import 'package:flutter/material.dart';
// import 'package:littlab/view/wishlist.dart';

// class CourseProvider with ChangeNotifier {
//   List<Course> _courses = [
//     Course(
//       name: 'UI/UX Design',
//       videos: [
//         Video(
//             title: 'Introduction to UI/UX',
//             url: 'https://www.youtube.com/watch?v=example1',
//             duration: '12 Min'),
//         Video(
//             title: 'Figma Essentials',
//             url: 'https://www.youtube.com/watch?v=example2',
//             duration: '15 Min'),
//       ],
//     ),
//     Course(
//       name: 'Flutter Development',
//       videos: [
//         Video(
//             title: 'Getting Started with Flutter',
//             url: 'https://www.youtube.com/watch?v=example3',
//             duration: '18 Min'),
//         Video(
//             title: 'Building Layouts in Flutter',
//             url: 'https://www.youtube.com/watch?v=example4',
//             duration: '20 Min'),
//       ],
//     ),
//   ];

//   List<Course> get courses => _courses;

//   void addCourse(Course course) {
//     _courses.add(course);
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:littlab/view/vedio_screen.dart';

class CourseProvider with ChangeNotifier {
  final List<Course> _courses = [
    Course(
      name: 'Flutter Development',
      videos: [
        Video(
          title: 'Getting Started with Flutter',
          url: 'https://www.youtube.com/watch?v=x0uinJvhNxI',
          duration: '8:30',
        ),
        Video(
          title: 'Flutter State Management',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '10:15',
        ),
        Video(
          title: 'Building a Todo App in Flutter',
          url: 'https://www.youtube.com/watch?v=x0uinJvhNxI',
          duration: '12:45',
        ),
        Video(
          title: 'Flutter UI Design',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '7:50',
        ),
        Video(
          title: 'Flutter Navigation Basics',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '5:30',
        ),
      ],
    ),
    Course(
      name: 'UI/UX Design',
      videos: [
        Video(
          title: 'Introduction to UI/UX',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '6:00',
        ),
        Video(
          title: 'Wireframing Basics',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '8:00',
        ),
        Video(
          title: 'UI/UX Design Process',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '7:45',
        ),
        Video(
          title: 'Sketch for UI Design',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '9:30',
        ),
        Video(
          title: 'Figma UI/UX Tutorial',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '10:00',
        ),
      ],
    ),
    Course(
      name: 'Dart Programming',
      videos: [
        Video(
          title: 'Dart Introduction',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '5:00',
        ),
        Video(
          title: 'Dart Lists and Collections',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '6:30',
        ),
        Video(
          title: 'Dart Functions and Methods',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '8:15',
        ),
        Video(
          title: 'Dart Asynchronous Programming',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '9:20',
        ),
        Video(
          title: 'Dart Streams',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '7:40',
        ),
      ],
    ),
    Course(
      name: 'Hive Database',
      videos: [
        Video(
          title: 'Getting Started with Hive',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '5:45',
        ),
        Video(
          title: 'Hive Database Basics',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '6:30',
        ),
        Video(
          title: 'Using Hive with Flutter',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '7:20',
        ),
        Video(
          title: 'CRUD Operations in Hive',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '8:10',
        ),
        Video(
          title: 'Advanced Hive Features',
          url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          duration: '9:00',
        ),
      ],
    ),
  ];

  List<Course> get courses => _courses;
}
