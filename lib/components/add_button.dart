// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

//state
import '../state/global_variables.dart';

//utils
import '../utils/db_actions.dart';

class AddButton extends StatefulWidget {
  final dynamic movie;

  const AddButton({required this.movie, Key? key}) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    isAdded = GlobalState.moviesToWatch
        .any((movie) => movie['id'] == widget.movie['id']);
  }

  void toggleIsAdded() {
    setState(() {
      isAdded = !isAdded;
      if (isAdded) {
        dbAdd(context, widget.movie);
        dbGet();
      } else {
        dbRemove(context, widget.movie);
        dbGet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleIsAdded,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: isAdded ? const Color(0xFFF7D633) : Colors.transparent,
          shape: BoxShape.rectangle,
          border: Border.all(
            color: const Color(0xFFF7D633), // Border color
            width: 1, // Border width
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            isAdded ? 'x' : '+',
            style: TextStyle(
              color: isAdded ? Colors.black : const Color(0xFFF7D633),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
