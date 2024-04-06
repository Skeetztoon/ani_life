import 'package:ani_life/core/ui_kit/widgets/app_place_button_sheet.dart';
import 'package:ani_life/features/map/presentation/widgets/my_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  String searchInput = "";

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // width: (MediaQuery. of(context). size. width),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _searchController,
                      textAlignVertical: TextAlignVertical.bottom,
                      obscureText: false,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                      decoration: InputDecoration(
                        suffixIcon: (!_isFocused)
                            ? null
                            : InkWell(
                                onTap: () {
                                  _searchController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                                child: const Icon(Icons.clear),
                              ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        hintText: "Поиск",
                        hintStyle:
                            Theme.of(context).inputDecorationTheme.hintStyle,
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchInput = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isFocused)
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("vets").snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index].data();
                          // String name = data["name"];
                          if (searchInput.isEmpty) {
                            return Container();
                          }
                          if (data["name"]
                              .toString()
                              .toLowerCase()
                              .startsWith(searchInput.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                mapController.move(
                                  LatLng(
                                    data["coords"][0],
                                    data["coords"][1],
                                  ),
                                  15.5,
                                );
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AppPlaceBottomSheet(
                                      placeName: data["name"],
                                      address: data["place"],
                                      schedule: data["schedule"] ?? "",
                                    );
                                  },
                                );
                              },
                              child: ListTile(
                                title: Text(data["name"] ?? ""),
                                subtitle: Text(data["place"] ?? ""),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
              },
            ),
          ),
      ],
    );
  }
}
