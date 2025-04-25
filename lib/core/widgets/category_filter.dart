import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../config/themes/app_color.dart';

class Filter {
  final String? iconPath;
  final String label;
  bool isSelected;

  Filter({this.iconPath, required this.label, this.isSelected = false});
}

class FilterOptionWidget extends StatefulWidget {
  final Function(String) onSelected;
  final List<Filter> filters;

  const FilterOptionWidget({
    super.key,
    required this.onSelected,
    required this.filters,
  });

  @override
  State<FilterOptionWidget> createState() => _FilterOptionWidgetState();
}

class _FilterOptionWidgetState extends State<FilterOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: widget.filters.map((filter) {
          final isSelected = filter.isSelected;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              avatar: filter.iconPath != null
                  ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: SvgPicture.asset(
                  filter.iconPath!,
                  height: 20,
                  width: 20,
                  color: isSelected ? AppColor.primaryColor : AppColor.grey,
                ),
              )
                  : null,
              label: Text(
                filter.label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: isSelected ? AppColor.primaryColor : AppColor.textSecondary,
                ),
              ),
              selectedColor: AppColor.surface,
              backgroundColor: AppColor.background,
              onSelected: (bool value) {
                widget.onSelected(filter.label);
                setState(() {
                  for (final f in widget.filters) {
                    f.isSelected = false;
                  }
                  filter.isSelected = value;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: isSelected ? AppColor.primaryColor : AppColor.lightGrey,
                  width: 1.4,
                ),
              ),
              elevation: 0.5,
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shadowColor: Colors.transparent,
            ),
          );
        }).toList(),
      ),
    );
  }
}
