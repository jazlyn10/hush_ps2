import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


// class NoteApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Note App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: NoteListScreen(),
//     );
//   }
// }

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notes = prefs.getStringList('notes') ?? [];
    });
  }

  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', notes);
  }

  void addNote() async {
    String newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNoteScreen()),
    );
    setState(() {
      notes.add(newNote);
    });
    saveNotes();
  }

  void editNote(int index) async {
    String editedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(note: notes[index]),
      ),
    );
    setState(() {
      notes[index] = editedNote;
    });
    saveNotes();
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
    saveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        backgroundColor: Color(0xffF4F8FF),
        title: Row(
          children: [
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your sleep journal',
                  style: TextStyle(
                    color: Color(0xff323339),
                    fontSize: 21,
                  ),
                ),
                SizedBox(height: 8), // Add a SizedBox for vertical spacing
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6), // Add left padding to create margin
                  child: Text(
                    'Write about how you feel! ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right:0),
              child: SizedBox(height:100,width:100,child: Image.asset("assets/images/note.png")),
            ),
          IconButton(icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),)
          ],
        ),
        
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {

          String noteContent = notes[index];
          String sanitizedNote = noteContent.replaceAll('\n', ' ');
          String truncatedNote = sanitizedNote;

          if (sanitizedNote.length > 10) {
            List<String> words = sanitizedNote.split(' ');
            truncatedNote = words.take(20).join(' ');
          }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(truncatedNote),
                onTap: () => editNote(index),
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Note'),
                        content: Text('Are you sure you want to delete this note?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              deleteNote(index); // Perform the delete action
                            },
                            child: Text('Delete'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(
          Icons.edit,
          color: Colors.blue,
        ),
      ),
    );
  }
}


class AddNoteScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Set the back button color to black
        ),
        toolbarHeight: 120,
        backgroundColor: Color(0xffF4F8FF),
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add Notes',
                style: TextStyle(
                  color: Color(0xff323339),
                  fontSize: 24,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _textEditingController.text),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Set the background color to white
                    onPrimary: Colors.blue, // Set the icon color to blue
                    side: BorderSide(color: Colors.blue),
                    fixedSize: Size(75, 60),// Set the border color to blue
                  ),
                  child: Icon(Icons.save,size: 32,),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Write here',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditNoteScreen extends StatefulWidget {
  final String? note;

  EditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.note!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Set the back button color to black
        ),
        toolbarHeight: 120,
        backgroundColor: Color(0xffF4F8FF),
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Edit Notes',
                style: TextStyle(
                  color: Color(0xff323339),
                  fontSize: 24,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _textEditingController.text),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Set the background color to white
                    onPrimary: Colors.blue, // Set the icon color to blue
                    side: BorderSide(color: Colors.blue),
                    fixedSize: Size(75, 60),// Set the border color to blue
                  ),
                  child: Icon(Icons.save,size: 32,),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Write here',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// class AddNoteScreen extends StatelessWidget {
//   final TextEditingController _textEditingController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.black, // Set the back button color to black
//         ),
//         toolbarHeight: 120,
//         backgroundColor: Color(0xffF4F8FF),
//         title: Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(
//                 'Add Notes',
//                 style: TextStyle(
//                   color: Color(0xff323339),
//                   fontSize: 24,
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context, _textEditingController.text),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.white, // Set the background color to white
//                   onPrimary: Colors.blue, // Set the icon color to blue
//                   side: BorderSide(color: Colors.blue),
//                   fixedSize: Size(75, 60),// Set the border color to blue
//                 ),
//                 child: Icon(Icons.save,size: 32,),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _textEditingController,
//               maxLines: null,
//               decoration: InputDecoration(
//                 labelText: 'Write here',
//                 border: InputBorder.none,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class EditNoteScreen extends StatefulWidget {
//   final String? note;
//
//   EditNoteScreen({Key? key, this.note}) : super(key: key);
//
//   @override
//   _EditNoteScreenState createState() => _EditNoteScreenState();
// }
//
// class _EditNoteScreenState extends State<EditNoteScreen> {
//   final TextEditingController _textEditingController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _textEditingController.text = widget.note!;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.black, // Set the back button color to black
//         ),
//         toolbarHeight: 120,
//         backgroundColor: Color(0xffF4F8FF),
//         title: Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(
//                 'Edit Notes',
//                 style: TextStyle(
//                   color: Color(0xff323339),
//                   fontSize: 24,
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context, _textEditingController.text),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.white, // Set the background color to white
//                   onPrimary: Colors.blue, // Set the icon color to blue
//                   side: BorderSide(color: Colors.blue),
//                   fixedSize: Size(75, 60),// Set the border color to blue
//                 ),
//                 child: Icon(Icons.save,size: 32,),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _textEditingController,
//               maxLines: null,
//               decoration: InputDecoration(
//                 labelText: 'Write here',
//                 border: InputBorder.none,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
