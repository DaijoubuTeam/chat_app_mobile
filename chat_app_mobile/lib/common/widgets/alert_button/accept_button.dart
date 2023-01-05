import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptButton extends StatelessWidget {
  const AcceptButton({
    super.key,
    this.text = "Yes",
    this.handleClick,
  });

  final String text;
  final Function()? handleClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
      onPressed: handleClick,
      child: Text(
        'Yes',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
