import 'package:ani_life/components/filters_page.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'my_text_field.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 60,
      width: MediaQuery. of(context). size. width,
      child: SizedBox(
        // height: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                // width: (MediaQuery. of(context). size. width),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: searchController,
                    obscureText: false,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.normal,),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFFDE7DD),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFFFDE7DD))),
                        hintText: "Поиск",
                        hintStyle: Theme.of(context)
                            .inputDecorationTheme
                            .hintStyle
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FiltersPage()),
                    );
                  },
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: AniColorPrimary,
                    size: 40,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
