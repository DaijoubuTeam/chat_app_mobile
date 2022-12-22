import 'package:flutter/material.dart';

class ButtonResend extends StatelessWidget {
  const ButtonResend({
    super.key,
    this.isAble = false,
    required this.handleClickButton,
  });

  final bool isAble;
  final Function() handleClickButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: isAble ? handleClickButton : null,
            // border radius
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              side: MaterialStateProperty.all(
                BorderSide(
                    color:
                        isAble ? Theme.of(context).primaryColor : Colors.grey,
                    width: 1.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Resend',
                style: TextStyle(fontSize: 20),
              ),
            )),
      ),
    );
  }
}
