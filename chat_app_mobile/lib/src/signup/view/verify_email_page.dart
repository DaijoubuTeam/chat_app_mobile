import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailPage extends StatelessWidget {
  static String namePage = 'VerifyEmailPage';
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Verify Email',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 36,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: const VerifyEmailView(),
    );
  }
}

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/images/Logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'Coffe Solution Chat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'We have sent a verified email to you',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 150),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => {context.pop()},
                  // border radius
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      side: MaterialStateProperty.all(BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.0))),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'I don\'t get it',
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
