import "package:flutter/material.dart";
import "package:larvae_classification/Screens/Blogs/SingleBlog.dart";
import 'package:intl/intl.dart';

class BlogsCard extends StatefulWidget {
  final dynamic snap;

  const BlogsCard({
    this.snap,
    Key? key,
  }) : super(key: key);

  @override
  State<BlogsCard> createState() => _BlogsCardState();
}

class _BlogsCardState extends State<BlogsCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleBlog(
                              photoUrl: widget.snap["PostUrl"],
                              title: widget.snap["Title"],
                              postId: widget.snap["PostId"],
                              description: widget.snap["Description"])));
                },
                child: Container(
                  width: 120,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.snap["PostUrl"] ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width:20),
              Expanded(child:
              Container(
                
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.snap["Title"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      widget.snap["Description"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Posted: ${DateFormat.yMMMd().format((widget.snap['DatePublished']).toDate())},",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                isLikeAnimating = !isLikeAnimating;
                              });
                            },
                            icon: isLikeAnimating
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border)),
                      ],
                    ))
                  ],
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
