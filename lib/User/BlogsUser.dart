
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogsUser {
  final String description;
  final String title;
  final String postId;
  final DateTime  datePublished;
  
  final String postUrl;
  BlogsUser(
      {required this.description,
      required this.title,
      required this.postId,
      required this.datePublished,
      
      required this.postUrl,
   });
  Map<String, dynamic> ToJson() => {
        
        "Description":description,
        "Title": title,
        "PostId": postId,
        "DatePublished":datePublished ,
        "PostUrl": postUrl,
      
      };

      static BlogsUser fromSnap(DocumentSnapshot snap){
        var snapshot = snap.data()as Map<String,dynamic>;
        return BlogsUser( description: snapshot['Description'],title: snapshot
        ['Title'], postId: snapshot['PostId'], 
        datePublished: snapshot['DatePublished'], postUrl: snapshot['PostUrl'],
         
          );
      }
}