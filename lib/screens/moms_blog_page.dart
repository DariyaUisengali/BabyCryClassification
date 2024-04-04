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
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      'imageUrl': 'lib/assets/baby_blog_items/baby_looking.jpg',
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
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/evening.jpg',
    },
  ];

  // List to store the liked state of each article
  List<bool> isLiked = List.generate(3, (index) => false);
  List<bool> disLiked = List.generate(3, (index_d) => false);

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
            fontSize: 22,
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
