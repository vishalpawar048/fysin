import 'package:flutter/material.dart';
import 'CarouselBanner.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 3, left: 50, top: 10, bottom: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
          child: TextField(
            onSubmitted: (String str) {
              Navigator.pushNamed(context, '/products',
                  arguments: ScreenArguments(str, null, ''));
            },
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.blueGrey[300],
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: "What are you looking for ?",
              prefixIcon: Icon(
                Icons.search,
                color: Colors.blueGrey[500],
              ),
              hintStyle: TextStyle(
                fontSize: 15.0,
                color: Colors.blueGrey[300],
              ),
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

// Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.only(right: 0, left: 10, top: 10, bottom: 10),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.blueGrey[50],
//             borderRadius: BorderRadius.all(
//               Radius.circular(50.0),
//             ),
//           ),
//           child: TextField(
//             onSubmitted: (String str) {
//               Navigator.pushNamed(context, '/products',
//                   arguments: ScreenArguments(str, null, ''));
//             },
//             style: TextStyle(
//               fontSize: 15.0,
//               color: Colors.blueGrey[300],
//             ),
//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.all(10.0),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5.0),
//                 borderSide: BorderSide(
//                   color: Colors.white,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Colors.white,
//                 ),
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               hintText: "What are you looking for ?",
//               prefixIcon: Icon(
//                 Icons.search,
//                 color: Colors.blueGrey[500],
//               ),
//               hintStyle: TextStyle(
//                 fontSize: 15.0,
//                 color: Colors.blueGrey[300],
//               ),
//             ),
//             maxLines: 1,
//           ),
//         ),
//       ),
//     );
//   }
