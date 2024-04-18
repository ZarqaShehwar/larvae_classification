import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class FAQ extends StatelessWidget {
  FAQ({super.key});
final List<Map<String, dynamic>> data = [
  {
    'question': 'What is the Larvae Detection App for?',
    'answer': 'It helps users identify larvae through microscopic images using advanced image recognition.',
  },
  {
    'question': 'How does the app work?',
    'answer': 'The app analyzes microscopic images using image processing and machine learning to identify and classify larvae species.',
  },
  {
    'question': 'What types of larvae can the app detect?',
    'answer': 'It can detect and classify various larvae species found in different environments, catering to entomology, agriculture, and environmental science.',
  },
  {
    'question': 'How accurate is the larvae detection process?',
    'answer': 'Accuracy depends on image quality and species diversity. Clear images enhance accuracy, and the app continuously improves through machine learning and user feedback.',
  },
  {
    'question': 'Do I need an internet connection to use the app?',
    'answer': 'An internet connection is required for initial setup, updates, and accessing the latest larvae species database. Basic detection tasks can be performed offline.',
  },
  {
    'question': 'How is my data protected?',
    'answer': 'Rest assured, your data is encrypted and stored securely. Read our privacy policy for detailed information on how we safeguard your information and maintain the highest standards of data protection.',
  },
];

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
          "Interactive FAQ's ",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 100,
                decoration: const  BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.red,
                ])),
              ),
              for(var item in data)
              SingleChildScrollView(child:Padding(padding:const   EdgeInsets.only(left:7,top:2),
              child:
            SizedBox(
              width:MediaQuery.sizeOf(context).width,
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item["question"],style: const TextStyle(fontSize:16,fontWeight: FontWeight.bold,),),
                  Text(item["answer"],style: const  TextStyle(fontSize:14,fontWeight: FontWeight.normal,),),

                ],
              )
            ),),
              ),
            ],
          )),
    );
  }
}
