import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final List<Color> colors;
  final Function(Color) onColorSelected;
  final Color? selectedColor;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.onColorSelected,
    this.selectedColor,
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children:
          widget.colors.map((color) {
            final isSelected = _selected == color;

            return GestureDetector(
              onTap: () {
                setState(() => _selected = color);
                widget.onColorSelected(color);
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey,
                    width: isSelected ? 3 : 1,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
