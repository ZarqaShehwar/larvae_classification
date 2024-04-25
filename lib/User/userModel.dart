
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetail  {
  final String? username;
  final String uid;
  final String? password;
  final String email;
   String? photoURL;
 
  UserDetail(
      {this.username,
      required this.uid,
      required this.email,
      this.password,
     this.photoURL,
    });
  Map<String, dynamic> ToJson() => {
        "Username": username,
        "uid":uid,
        "Email": email,
        "Password": password,
        "Photo": photoURL,
        
      };

      static UserDetail fromSnap(DocumentSnapshot snap){
        var snapshot = snap.data()as Map<String,dynamic>;
        return UserDetail(username: snapshot
        ['Username'], uid: snapshot['uid'],  
        email: snapshot['Email'], password: snapshot['Password'],
         photoURL: snapshot['Photo']);


      }
}