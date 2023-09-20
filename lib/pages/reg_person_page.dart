import 'package:flutter/material.dart';

import '../utils/constants.dart';

class RegPersonPage extends StatefulWidget {
  const RegPersonPage({super.key});

  @override
  State<RegPersonPage> createState() => _RegPersonPageState();
}

class _RegPersonPageState extends State<RegPersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: (Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: 250,
                        child: TextField(
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyPrimaryColor, width: 2.0),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: "Email",
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          style: const TextStyle(
                            fontSize: MediumTextSize,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyPrimaryColor, width: 2.0),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: "Номер телефона",
                            hintStyle: const TextStyle(
                                fontSize: MediumTextSize,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyPrimaryColor, width: 2.0),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: "Email",
                            hintStyle: const TextStyle(
                                fontSize: MediumTextSize,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyPrimaryColor, width: 2.0),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: "Пароль",
                            hintStyle: const TextStyle(
                                fontSize: MediumTextSize,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyPrimaryColor, width: 2.0),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: "Повторите пароль",
                            hintStyle: const TextStyle(
                                fontSize: MediumTextSize,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                                203, 99, 99, 1), // Background color
                            // onPrimary: Colors.amber, // Text Color (Foreground color)
                          ),
                          onPressed: () {},
                          child: Text(
                            "Далее",
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                    ),
                  ],
                ),
              ])),
        ),
      ),
    );
  }
}
