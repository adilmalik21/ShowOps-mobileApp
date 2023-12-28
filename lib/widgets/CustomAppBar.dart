import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueNotifier<int> tabIndex;
  CustomAppBar({required this.tabIndex});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      //backgroundColor: Colors.white,
      title: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
        height: 45,
      ),
      actions: [
        // Using ValueListenableBuilder to control visibility of filter icon
        ValueListenableBuilder<int>(
          valueListenable: tabIndex,
          builder: (context, index, _) {
            if (index == 0) {
              return PopupMenuButton<String>(
                offset: Offset(0, 40),
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'Artist',
                      child: Text('Artist'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Date Range',
                      child: Text('Date Range'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Event Status',
                      child: Text('Event Status'),
                    ),
                  ];
                },
                icon: Icon(Icons.filter_list),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
