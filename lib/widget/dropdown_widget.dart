import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key key,
    this.items,
    this.onChanged,
    this.dropDownMode,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    this.value,
  }) : super(key: key);
  final List<String> items;
  final void Function(String) onChanged;
  final Mode dropDownMode;
  final bool enabled;

  /// localization hint .....
  final String hint;

  final Widget prefixIcon;

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: DropdownSearch(
        validator: (v) {
          if (v == null) {
            return "${getTransrlate(context, 'requiredempty')}";
          } else
            return null;
        },
        label: value,
        initialValue: value,
        dropdownSearchDecoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          border: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        dropDownButton: const Icon(Icons.keyboard_arrow_down),
        onChanged: onChanged,
        enabled: enabled,
        items: items,
        mode: dropDownMode,
        hint: hint == null ? null : getTransrlate(context, hint),
        prefixIcon: prefixIcon,
        // onChanged: ,
      ),
    );
  }
}
