import 'package:flutter/material.dart';

class ImageLoad extends StatelessWidget {
  const ImageLoad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            elevation: 2,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                topRight: Radius.circular(16)),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 8.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
