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
      padding: const EdgeInsets.all(8.0),
      child: FilterChip(
        label: Text(widget.lbl),
        selected: isSelected,
        onSelected: (bool value) {
          setState(() {
            isSelected != isSelected;
          });
        },
      ),
    );
  }
}
