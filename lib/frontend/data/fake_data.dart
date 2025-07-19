import 'package:arfoon_note/client/models/models.dart';

class FakeData {
  static List<Label> labels = [
    Label(id: 1, name: 'Work', details: 'Work-related notes'),
    Label(id: 2, name: 'Personal', details: 'Personal stuff'),
    Label(id: 3, name: 'Urgent', details: 'Needs attention'),
    Label(id: 4, name: 'Ideas', details: 'Brainstorming'),
    Label(id: 5, name: 'Archive', details: 'Old notes'),
  ];

  static List<Note> notes = [
    Note(id: 1, title: 'Project plan', details: 'Outline for new project', colorId: 0xFF123456, labelIds: [1, 3]),
    Note(id: 2, title: 'Grocery list', details: 'Eggs, Milk, Bread', colorId: 0xFF654321, labelIds: [2]),
    Note(id: 3, title: 'App idea', details: 'Note-taking app with tags', colorId: 0xFFABCDEF, labelIds: [4]),
    Note(id: 4, title: 'Meeting summary', details: 'Discussed Q3 targets', colorId: 0xFF998877, labelIds: [1, 5]),
    Note(id: 5, title: 'Vacation plan', details: 'Trip to Japan itinerary', colorId: 0xFFAABBCC, labelIds: [2, 4]),
  ];
}
