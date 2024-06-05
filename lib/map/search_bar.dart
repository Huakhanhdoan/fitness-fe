
import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  late SearchController controller;
  List<String> languages = ['Java', 'C++', 'C#', 'Dart', 'JavaScript', 'Python'];
  @override
  void initState() {
    super.initState();
    controller = SearchController();
  }

  // Phương thức để điều hướng sang trang mới
  void _navigateToSearchResult(BuildContext context, String query) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Category(query: query,)),
    // );
  }

  @override
  void dispose() {
    // Giải phóng controller khi không còn sử dụng
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              if (mounted) {
                controller.openView();
              }
            },
            onChanged: (_) {
              if (mounted) {
                controller.openView();
              }
            },
            leading: Icon(Icons.search, color: Colors.blueAccent.shade200),
            trailing: <Widget>[
              Tooltip(
                message: 'Change brightness mode',
                child: IconButton(
                  isSelected: isDark,
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        isDark = !isDark;
                      });
                    }
                  },
                  icon: Icon(Icons.wb_sunny_outlined, color: Colors.blueAccent.shade200),
                  selectedIcon: Icon(Icons.brightness_2_outlined, color: Colors.blueAccent.shade200),
                ),
              )
            ],
            onSubmitted: (String query) {
              if (mounted) {
                _navigateToSearchResult(context, query);
              }
            },
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(languages.length, (int index) {
            final String item = languages[index];
            return ListTile(
              title: Text(item),
              onTap: () {
                if (mounted) {
                  setState(() {
                    controller.closeView(item);
                  });
                }
              },
            );
          });
        },
      ),
    );
  }
}
