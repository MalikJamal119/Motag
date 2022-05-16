import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:myapp/screens/login_screen.dart';

void main() {
  runApp( MaterialApp(home: Home()));
}
class CardItem {
  final String urlImage;
  final String title;
  final String subtitle;

  const CardItem({
    required this.urlImage,
    required this.title,
    required this.subtitle,
  });
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  List<CardItem> items = [
    CardItem(
      urlImage:
      'https://i.pinimg.com/236x/c4/2a/f6/c42af62037e3d7cd9961d38e7212a453.jpg',
      title: 'Zara',
      subtitle: 'QR',

    ),
    CardItem(
      urlImage:
      'https://www.secrettelaviv.com/wp-content/uploads/2019/05/77996_27657372_967581220074055_6490517124524720240_n.jpg',
      title: 'Golda',
      subtitle: 'QR',

    ),
    CardItem(
      urlImage:
      'https://brandslogos.com/wp-content/uploads/images/hm-logo-1.png',
      title: 'H&M',
      subtitle: 'QR',

    ),
    CardItem(
      urlImage:
      'https://wallpaper.dog/large/17092517.jpg',
      title: 'Nike',
      subtitle: 'QR',

    ),
    CardItem(
      urlImage:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/TheNorthFace_logo.svg/1200px-TheNorthFace_logo.svg.png',
      title: 'The North Face',
      subtitle: 'QR',

    ),
    CardItem(
      urlImage:
      'https://shimeba.blob.core.windows.net/shimeba-new-container/53916cb3921a492385d3243770851dc7.JPG',
      title: 'Rebar',
      subtitle: 'QR',

    ),

  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Email and password Login',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
      home: LoginScreen(),
    );
  }
}
