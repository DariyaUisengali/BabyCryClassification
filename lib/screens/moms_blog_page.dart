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
      ),
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class MomsBlogPage extends StatelessWidget {
  final List<Map<String, dynamic>> newsArticles = [
    {
      'title': 'Release of Baby Classificaiton App: version demo is released',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
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
      'imageUrl': 'lib/sleep_sounds_page_items/sleep_images/evening.jpg',
    },
  ];

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
          bool isLiked = false;

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
                          fontWeight: FontWeight.w100),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up),
                          onPressed: () {
                            // Handle like button pressed
                            isLiked = !isLiked;
                            print('Liked ${newsArticles[index]['title']}');
                            print(isLiked);
                          },
                          color: isLiked
                              ? Colors.blue
                              : Color.fromARGB(255, 255, 255, 255),
                        ),
                        IconButton(
                          icon: Icon(Icons.thumb_down),
                          color: Colors.white,
                          onPressed: () {
                            // Handle dislike button pressed
                            print('Disliked ${newsArticles[index]['title']}');
                          },
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

void main() {
  runApp(MaterialApp(
    home: MomsBlogPage(),
  ));
}

class FullArticlePage extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  FullArticlePage({
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF32343E),
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 16.0),
            Image.asset(imageUrl),
          ],
        ),
      ),
    );
  }
}
