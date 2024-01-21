import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
        ],
      ),
      Expanded(child: 
      Container(
        width:MediaQuery.sizeOf(context).width,
        color:Colors.white
        
      )),
    ]));
  }
}
