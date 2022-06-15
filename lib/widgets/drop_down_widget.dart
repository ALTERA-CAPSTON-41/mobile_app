import 'package:capston_project/common/const.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownSearchApiWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function? onFind;
  final dynamic selectedItem;
  final Function(dynamic) onChanged;

  const DropdownSearchApiWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.label,
    required this.selectedItem,
    this.onFind,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<dynamic>(
      showSearchBox: true,
      showSelectedItems: true,
      compareFn: (i, s) => i?.isEqual(s) ?? false,
      selectedItem: selectedItem,
      popupTitle: Container(
        margin: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value == '') {
          return "$label tidak boleh kosong";
        }
        return null;
      },
      dropdownSearchDecoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        border: const OutlineInputBorder(),
      ),
      onFind: (dynamic filter) => onFind!(),
      onChanged: onChanged,
    );
  }
}

class DropdowndSearchWidget extends StatelessWidget {
  const DropdowndSearchWidget({
    Key? key,
    required this.controller,
    required this.items,
    required this.onChanged,
    required this.label,
    this.isEnabled = true,
    this.margin,
    this.contentPadding,
    this.labelStyle,
  }) : super(key: key);

  final String? label;
  final TextEditingController controller;
  final List<dynamic> items;
  final Function(dynamic) onChanged;
  final bool isEnabled;
  final EdgeInsets? margin;
  final EdgeInsets? contentPadding;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<dynamic>(
      enabled: isEnabled,
      items: items,
      selectedItem: controller.text == "" ? null : controller.text,
      popupTitle: Container(
        margin: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            label ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      compareFn: (a, b) => a == b,
      maxHeight: 300,
      validator: (value) {
        if (value == null || value == '') {
          return "$label tidak boleh kosong";
        }
        return null;
      },
      onChanged: onChanged,
      dropdownSearchDecoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(20, 20, 20, 20),
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}
