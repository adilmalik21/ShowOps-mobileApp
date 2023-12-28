import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showops/widgets/VideoPlayerWidget.dart';

void main() => runApp(MaterialApp(home: Production()));

class Production extends StatefulWidget {
  @override
  _ProductionState createState() => _ProductionState();
}

class _ProductionState extends State<Production> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  final GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  final FocusNode _editorFocusNode = FocusNode();
  String? _selectedFileName;
  String? _selectedFilePath;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media, // for both image and video
    );

    if (result != null) {
      setState(() {
        _selectedFileName = result.files.single.name;
        _selectedFilePath = result.files.single.path;
        _promptRenameFile(); // Prompt to rename the file
      });
    }
  }

  Future<void> _takePhoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _selectedFileName = photo.name;
        _selectedFilePath = photo.path;
        _promptRenameFile(); // Prompt to rename the file
      });
    }
  }

  Future<void> _recordVideo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);

    if (video != null) {
      setState(() {
        _selectedFileName = video.name;
        _selectedFilePath = video.path;
        _promptRenameFile(); // Prompt to rename the file
      });
    }
  }

  void _removeSelectedFile() {
    setState(() {
      _selectedFileName = null;
      _selectedFilePath = null;
    });
  }

  void _previewFile() {
    if (_selectedFilePath != null) {
      showDialog(
        context: context,
        builder: (_) {
          final file = File(_selectedFilePath!);
          final isImage = ['jpg', 'jpeg', 'png', 'HEIC', 'heic']
              .any((ext) => _selectedFileName!.toLowerCase().endsWith(ext));
          return AlertDialog(
            content: isImage ? Image.file(file) : VideoPlayerWidget(file: file),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Record video'),
                onTap: () {
                  Navigator.pop(context);
                  _recordVideo();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to prompt the user to rename the file
  void _promptRenameFile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Extract the file extension
        String fileExtension = _selectedFileName!.split('.').last;

        TextEditingController _renameController = TextEditingController(
          text: _selectedFileName!.replaceAll('.$fileExtension', ''),
        );

        return AlertDialog(
          title: Text("Rename File"),
          content: TextField(
            controller: _renameController,
            decoration: InputDecoration(hintText: "Enter new file name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Rename"),
              onPressed: () {
                setState(() {
                  // Append the original extension to the new name
                  _selectedFileName =
                      '${_renameController.text}.$fileExtension';
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          height: 45,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: KeyboardActions(
            config: _buildConfig(),
            child: ListView(
              children: [
                const Center(
                  child: Text(
                    'Sep 13, 2023 - 7:30pm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Center(
                  child: Text(
                    'The Signal - Chattanooga, TN',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Divider(thickness: 1.0),
                ExpansionTile(
                  title: Text(
                    "Video",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _isChecked1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked1 = value!;
                                    });
                                  },
                                  activeColor: Colors.black,
                                ),
                                Text("Example Text 1",
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _isChecked2,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked2 = value!;
                                    });
                                  },
                                  activeColor: Colors.black,
                                ),
                                Text("Example Text 2",
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(_editorFocusNode);
                              },
                              child: FlutterSummernote(
                                height: 200,
                                hint: 'Your text here...',
                                key: _keyEditor,
                                hasAttachment: true,
                                showBottomToolbar: false,
                                customToolbar: """
                                  [
                                    ['style', ['bold', 'italic', 'underline', 'clear']],
                                    ['font', ['strikethrough', 'superscript', 'subscript']],
                                    ['insert', ['link', 'table', 'hr']]
                                  ]
                                """,
                              ),
                            ),
                            SizedBox(height: 10),
                            _selectedFileName == null
                                ? TextButton(
                                    onPressed: _showPickerOptions,
                                    child: Text("Attach file..."),
                                  )
                                : InkWell(
                                    onTap: _previewFile,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            child: Text(
                                              _selectedFileName!,
                                              style: TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: _removeSelectedFile,
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  KeyboardActionsConfig _buildConfig() {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: [
        KeyboardActionsItem(focusNode: _editorFocusNode),
      ],
    );
  }
}
