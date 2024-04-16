import 'package:flutter/material.dart';
import 'package:record_with_play/bottom_menu.dart';

class ArticleDetailsPage extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  ArticleDetailsPage(
      {required this.title, required this.content, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFF494E64),
      ),
      backgroundColor: Color(0xFF32343E),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text(content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                )),
          ],
        ),
      ),
    );
  }
}

class MomsBlogPage extends StatefulWidget {
  @override
  _MomsBlogPageState createState() => _MomsBlogPageState();
}

class _MomsBlogPageState extends State<MomsBlogPage> {
  final List<Map<String, dynamic>> newsArticles = [
    {
      'title':
          'The Science and Mystery Behind a Baby\'s Cry: Understanding the Language of Infant Communication',
      'content':
          'Life has changed now that your baby is here, and you might have lots of questions about what to do. These tips can help first-time parents feel confident about caring for a newborn in no time.\n\nHow Do I Get Help After My Baby Comes Home?\nAn important part of caring for a newborn is to also take care of yourself. Consider getting help during this time, which can feel hectic and a bit overwhelming. Relatives and friends might want to help. Even if you disagree on some things, their own experiences might be helpful. To keep your baby healthy, anyone handling your little one should be up to date on their vaccines and help only if they feel well. But if you don\'t feel up to having guests or have other concerns, don\'t feel guilty about limiting visitors.\n\nHow Do I Handle My Baby? \n If you haven\'t spent a lot of time around newborns, they may seem very fragile. Here are a few basics to remember:\n Wash your hands (or use a hand sanitizer) before handling your baby. Newborns don\'t have a strong immune system yet, so they\'re at risk for infections. Make sure that everyone who handles your baby has clean hands. \nSupport your baby\'s head and neck. Cradle the head when carrying your baby. And support the head when carrying the baby upright or when you lay your baby down.\n\nNever shake your baby, whether in play or in frustration. Shaking can cause bleeding in the brain and sometimes death. If you need to wake your baby, don\'t do it by shaking. Instead, tickle your baby\'s feet or blow gently on a cheek.\nAlways fasten your baby securely when using a carrier, stroller, or car seat. Limit any activity that could be too rough or bouncy.\n Avoid rough play with newborns, such as jiggling them on the knee or throwing them in the air. How Can I Bond With My Baby? Bonding happens during the first hours and days after birth when parents make a deep connection with their child. Physical closeness can help form an emotional link and help your baby develop in other ways. Another way to think of bonding is "falling in love" with your baby. Kids thrive from having a parent or other adult in their life who loves them unconditionally. Begin bonding by cradling and gently stroking your baby in different patterns. Another good technique is skin-to-skin contact (also called kangaroo care), where you hold your newborn against your own chest. This helps calm and soothe babies and regulate their heartbeat. Its a good practice for moms or dads to do.\n\nHere\'s how to do skin-to-skin contact with your baby',
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/dreamland.jpg',
    },
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/evening.jpg',
    },
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/underwater-1.jpg',
    },
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/waterfall.jpg',
    },
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/the-magic-tree.jpg',
    },
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/forest-lullaby.jpg',
    },
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/piano-lullaby.jpg',
    },
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl':
          'lib/sleep_sounds_page_items/sleep_images/piano-lullaby-2.jpg',
    },
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/storm.jpg',
    },
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/train.jpg',
    },
  ];

  // List to store the liked state of each article
  List<bool> isLiked = List.generate(10, (index) => false);
  List<bool> disLiked = List.generate(10, (index_d) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF32343E),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Baby\'s blog',
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF494E64),
      ),
      bottomNavigationBar: BottomMenu(activePage: 'moms_blog'),
      body: ListView.builder(
        itemCount: newsArticles.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailsPage(
                    title: newsArticles[index]['title'],
                    content: newsArticles[index]['content'],
                    imageUrl: newsArticles[index]['imageUrl'],
                  ),
                ),
              );
            },
            child: Card(
              color: Color(0xFF32343E),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsArticles[index]['title'],
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Image.asset(
                      newsArticles[index]['imageUrl'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      newsArticles[index]['content'].substring(0, 500) + '...',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up),
                          onPressed: () {
                            // Handle like button pressed
                            setState(() {
                              isLiked[index] = !isLiked[index];
                              if (isLiked[index]) {
                                disLiked[index] = false;
                              }
                            });
                          },
                          color: isLiked[index] ? Colors.blue : Colors.white,
                        ),
                        IconButton(
                          icon: Icon(Icons.thumb_down),
                          onPressed: () {
                            // Handle dislike button pressed
                            setState(() {
                              disLiked[index] = !disLiked[index];
                              if (disLiked[index]) {
                                isLiked[index] = false;
                              }
                            });
                          },
                          color: disLiked[index] ? Colors.blue : Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
