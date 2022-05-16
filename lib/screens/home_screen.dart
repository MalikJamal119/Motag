import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:myapp/screens/login_screen.dart';


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


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardItem> items = [
    const CardItem(
      urlImage:
      'https://i.pinimg.com/236x/c4/2a/f6/c42af62037e3d7cd9961d38e7212a453.jpg',
      title: 'Zara',
      subtitle: 'QR',

    ),
    const CardItem(
      urlImage:
      'https://www.secrettelaviv.com/wp-content/uploads/2019/05/77996_27657372_967581220074055_6490517124524720240_n.jpg',
      title: 'Golda',
      subtitle: 'QR',

    ),
    const CardItem(
      urlImage:
      'https://brandslogos.com/wp-content/uploads/images/hm-logo-1.png',
      title: 'H&M',
      subtitle: 'QR',

    ),
    const CardItem(
      urlImage:
      'https://wallpaper.dog/large/17092517.jpg',
      title: 'Nike',
      subtitle: 'QR',

    ),
    const CardItem(
      urlImage:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/TheNorthFace_logo.svg/1200px-TheNorthFace_logo.svg.png',
      title: 'The North Face',
      subtitle: 'QR',

    ),
    const CardItem(
      urlImage:
      'https://shimeba.blob.core.windows.net/shimeba-new-container/53916cb3921a492385d3243770851dc7.JPG',
      title: 'Rebar',
      subtitle: 'QR',

    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text(
          'Motag',
          style: TextStyle(
            fontFamily: 'AmaticSC',
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          color: Colors.black12,
          height: 120.0,

          child: const Text(
            'Welcome to Motag! The points generator. Send , receive and scan points '
                'of the brands you love for lower prices and deals everyone loves!',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Macondo',
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,

            ),
          ),
        ),
        Container(
          height: 70.0,
          color: Colors.black38,
          child: const Text(
            'Here are some of the brands that we work with',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Macondo',
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
        Container(
          height: 256,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (context, _) => SizedBox(width: 8),
            itemBuilder: (context,index) => buildCard(item: items[index]),


          ),),


      ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.lightGreen,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.logout),
            label: 'Log Out',
            onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }

          ),
          SpeedDialChild(
            child: Icon(Icons.info),
            label: 'About Us',
          ),
          SpeedDialChild(
            onTap: () {

            },
            child: Icon(Icons.wallet_giftcard),
            label: 'Enter New Points',
          ),
          SpeedDialChild(
            child: Icon(Icons.compare_arrows_rounded),
            label: 'Transfer Points',
          ),

        ],
        child: Icon(Icons.menu),
      ),
    );
  }
  Widget buildCard({
    required CardItem item,
  }) =>
      Container(
        width: 200,

        child: Column(
          children: [
            Expanded(
              child: Image.network(
                item.urlImage,
                fit: BoxFit.cover,
              ),),
            const SizedBox(height: 4),
            Text(
              item.title,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              item.subtitle,
              style: TextStyle(fontSize: 20, color: Colors.black38),),


          ],
        ),);
}

