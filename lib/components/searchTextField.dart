import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;

  const SearchTextField(this.hintText);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 380,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(229, 229, 229, 0.90),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 0.90), width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.search,
              color: const Color.fromRGBO(108, 168, 129, 1),
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
