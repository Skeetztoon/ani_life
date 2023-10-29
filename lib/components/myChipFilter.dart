import 'package:flutter/material.dart';

class MyChipFilter extends StatefulWidget {
  final String lbl;
  const MyChipFilter({super.key, required this.lbl});

  @override
  State<MyChipFilter> createState() => _MyChipFilterState();
}

class _MyChipFilterState extends State<MyChipFilter> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(widget.lbl),
        selected: isSelected,
        onSelected: (bool value) {
          setState(() {
            isSelected != isSelected;
          });
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: Color(0xFFF39191),
            width: 2.0,
          ),
        ),
        // avatar: const Text("A"),
      ),
    );
  }
}
