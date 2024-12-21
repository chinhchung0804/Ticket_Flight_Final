import 'package:flutter/material.dart';

class AppTicketTabs extends StatefulWidget {
  final String firstTab;
  final String secondTab;
  final Function(bool isFirstTabSelected) onTabChanged;

  const AppTicketTabs({
    super.key,
    required this.firstTab,
    required this.secondTab,
    required this.onTabChanged,
  });

  @override
  State<AppTicketTabs> createState() => _AppTicketTabsState();
}

class _AppTicketTabsState extends State<AppTicketTabs> {
  bool isFirstTabActive = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xFFF4F6FD),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isFirstTabActive = true;
              });
              widget.onTabChanged(true); // Gọi callback
            },
            child: Container(
              width: size.width * 0.44,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isFirstTabActive ? Colors.white : Colors.transparent,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Text(
                  widget.firstTab,
                  style: TextStyle(
                    color: isFirstTabActive ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isFirstTabActive = false;
              });
              widget.onTabChanged(false); // Gọi callback
            },
            child: Container(
              width: size.width * 0.44,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: !isFirstTabActive ? Colors.white : Colors.transparent,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Text(
                  widget.secondTab,
                  style: TextStyle(
                    color: !isFirstTabActive ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}