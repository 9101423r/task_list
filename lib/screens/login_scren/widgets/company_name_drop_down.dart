import 'package:flutter/material.dart';

class DropDownCompanyName extends StatefulWidget{
  final List<String> companyNameList;
  const DropDownCompanyName({required this.companyNameList,super.key});

  @override
  State<DropDownCompanyName> createState() => _DropDownCompanyNameState();
}

class _DropDownCompanyNameState extends State<DropDownCompanyName> {
  late String _selectedItem;
  @override
  Widget build(BuildContext context) {
    _selectedItem = widget.companyNameList[0];
    return DropdownButton(
      value: _selectedItem,
      items:widget.companyNameList.map((String value){
      return DropdownMenuItem<String>(child: Text(value));
    }).toList(),
    
     
     onChanged: (value){


     });
  }
}