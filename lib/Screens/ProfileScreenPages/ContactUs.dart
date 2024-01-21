import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(FontAwesomeIcons.arrowLeft,
                size: 24, color: Colors.white)),
        title: const Text(
          "Contact Us",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.red,
                ])),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "You can get in touch with us through below platform.Our Team will reach out to you as soon as it would be possible.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
              ),
              Card(
                  elevation: 8,
                  shadowColor: Colors.grey,
                  child: Container(
                      width: 400,
                      height: 200,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Padding(
                          padding: EdgeInsets.only(top: 8, left: 8, bottom: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Customer Support",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 200,
                                  child: Row(children: [
                                    const CircleAvatar(
                                        child: Icon(
                                      FontAwesomeIcons.phone,
                                      size: 20,
                                      color: Colors.grey,
                                    )),
                                    const SizedBox(width: 10),
                                    Container(
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Contact Number",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "03065436176",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    width: 400,
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                            child: Icon(
                                          FontAwesomeIcons.person,
                                          size: 20,
                                          color: Colors.grey,
                                        )),
                                        const SizedBox(width: 10),
                                        Container(
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Email Address",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "zarqashehwar02@gmail.com",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ])))),
              Card(
                  elevation: 8,
                  shadowColor: Colors.grey,
                  child: Container(
                      width: 400,
                      height: 200,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Padding(
                          padding: EdgeInsets.only(top: 8, left: 8, bottom: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Social Media",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 200,
                                  child: Row(children: [
                                    const CircleAvatar(
                                        child: Icon(
                                      FontAwesomeIcons.instagram,
                                      size: 20,
                                      color: Colors.grey,
                                    )),
                                    const SizedBox(width: 10),
                                    Container(
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Instagram",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "ZarqaShehwar",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    width: 400,
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                            child: Icon(
                                          FontAwesomeIcons.facebookF,
                                          size: 20,
                                          color: Colors.grey,
                                        )),
                                        const SizedBox(width: 10),
                                        Container(
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Facebook",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Zarqa Malik",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ])))),
            ],
          )),
    );
  }
}
