// ignore_for_file: deprecated_member_use

import 'package:taskmanager/core/routes/exports.dart';

class CustomDropdown extends StatelessWidget {

  final String value;
  final List<String> items;
  final String hintText;
  final IconData prefixIcon;
  final Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    required this.prefixIcon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField<String>(

      value: value,

      style: const TextStyle(
        color: Color(0xff050b2c),
        fontSize: 16,
      ),

      decoration: InputDecoration(

        hintText: hintText,

        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),

        prefixIcon: Icon(
          prefixIcon,
          color: const Color(0xff24558f),
        ),

        filled: true,

        fillColor: Colors.white,

        contentPadding:
        const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 10,
        ),

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xff3986e2),
            width: 1.5,
          ),
        ),
      ),

      items: items.map((item) {

        return DropdownMenuItem(

          value: item,

          child: Text(item),
        );
      }).toList(),

      onChanged: onChanged,
    );
  }
}