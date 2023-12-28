import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:showops/Views/Events/SetList/addSongs.dart';

class SetList extends StatefulWidget {
  @override
  _SetListState createState() => _SetListState();
}

class _SetListState extends State<SetList> {
  final List<ListItem> _items = [
    ListItem('Good God Almighty'),
    ListItem('Red Letters'),
    ListItem('Come As You Are'),
    ListItem('All My Hope'),
    ListItem('Run Devil Run'),
    ListItem('All My Hope'),
    ListItem('Milk And Honey'),
    // ... and so on
  ];

  bool _onReorderCallback(Key refKey, Key newKey) {
    int oldIndex = _items.indexWhere((item) => ValueKey(item) == refKey);
    int newIndex = _items.indexWhere((item) => ValueKey(item) == newKey);
    if (oldIndex != newIndex) {
      setState(() {
        ListItem item = _items.removeAt(oldIndex);
        _items.insert(newIndex, item);
      });
    }
    return true;
  }

  Widget _buildReorderableItem(ListItem item) {
    return ReorderableItem(
      key: ValueKey(item),
      childBuilder: (BuildContext context, ReorderableItemState state) {
        return Opacity(
          opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
          child: SizedBox(
            height: 70,
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              title: Text(item.title),
              leading: ReorderableListener(
                child: Icon(FontAwesomeIcons.alignJustify),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.edit),
                    onPressed: () {
                      // Edit action
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.trashCan),
                    onPressed: () {
                      // Delete action
                    },
                  ),
                ],
              ),
            ),
          ),
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
        centerTitle: true, // Ensure the title is centered
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 5),
              const Center(
                child: Text(
                  'The Signal - Chattanooga, TN',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle Allocate button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 82, 85, 90),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation:
                              15, // Set the elevation to adjust the shadow effect
                        ),
                        child: const Text('Load Set List',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                          width: 10), // Add space between the buttons
                      ElevatedButton(
                        onPressed: () {
                          // Handle add song button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddSongs()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 82, 85, 90),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation:
                              15, // Set the elevation to adjust the shadow effect
                        ),
                        child: const Text('Add Song',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: ReorderableListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      key: ValueKey(_items[index]), // Move the key here
                      children: [
                        Icon(FontAwesomeIcons.alignJustify), // Leading icon

                        // This Expanded widget makes the ListTile's title take the
                        // available space between the leading and trailing icons.
                        Expanded(
                          child: ListTile(
                            title: Text(_items[index].title),
                          ),
                        ),

                        // Trailing icons
                        IconButton(
                          icon: Icon(FontAwesomeIcons.edit),
                          onPressed: () {
                            // Edit action
                          },
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.trashCan),
                          onPressed: () {
                            // Delete action
                          },
                        ),
                      ],
                    );
                  },
                  itemCount: _items.length,
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final item = _items.removeAt(oldIndex);
                      _items.insert(newIndex, item);
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: Text(
                    "Total Run Time - 47 minutes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem {
  final String title;

  ListItem(this.title);
}
