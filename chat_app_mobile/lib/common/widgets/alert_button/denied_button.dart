import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeniedButton extends StatelessWidget {
  const DeniedButton({
    super.key,
    this.text = "No",
    this.handleClick,
  });

  final String text;
  final Function()? handleClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      onPressed: handleClick,
      child: Text(
        'No',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
