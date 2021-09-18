import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class EntryFieldDropdown extends StatelessWidget{
  final String title;
  final String hint;
  final String selected;
  final List<String> items;
  final Function onChanged;
  const EntryFieldDropdown({
    Key key,
    this.title,
    this.items = const [],
    this.hint,
    this.selected,
    this.onChanged
  }) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: this.items,
            hint: this.hint,
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: this.onChanged,
            selectedItem: this.selected,
            dropdownSearchDecoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true
            )
          )
        ],
      ),
    );
  }
}