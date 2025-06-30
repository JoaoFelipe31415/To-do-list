import 'package:flutter/material.dart';

class CreateBarWidget extends StatefulWidget {
  const CreateBarWidget({super.key, required this.onPressed});

  final Function(String) onPressed;

  @override
  State<CreateBarWidget> createState() => _CreateBarWidgetState();
}

class _CreateBarWidgetState extends State<CreateBarWidget> {
  final _controller = TextEditingController();

  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _MyDelegate(
        child: TextField(
          style: TextStyle(color: Colors.black),
          focusNode: _focusNode,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              widget.onPressed(value);
              _controller.clear();
              _focusNode.requestFocus();
            }
          },
          controller: _controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            suffixIconColor: Colors.blue,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(style: BorderStyle.none, width: 0),
            ),
            hintText: "Add Item",
            hintStyle: TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onPressed(_controller.text);
                  _controller.clear();
                  _focusNode.requestFocus();
                }
              },
              icon: Icon(Icons.add_circle),
              iconSize: 32,
            ),
          ),
        ),
      ),
    );
  }
}

class _MyDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  const _MyDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
