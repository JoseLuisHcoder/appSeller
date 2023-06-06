import 'package:flutter/material.dart';

import '../data/themes.dart';

class SearchStatic extends StatefulWidget {
  final String textSearch;
  const SearchStatic({super.key, required this.textSearch});

  @override
  State<SearchStatic> createState() => _SearchStaticState();
}

class _SearchStaticState extends State<SearchStatic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: kAppBar,
        ),
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: widget.textSearch,
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                      hintStyle: const TextStyle(fontSize: 14, color: kAppBar)),
                )),
          ),
          Container(
            width: 40,
            margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            decoration: BoxDecoration(
              color: kAppBar,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.search,
              color: kWhite,
            ),
          ),
        ],
      ),
    );
  }
}
