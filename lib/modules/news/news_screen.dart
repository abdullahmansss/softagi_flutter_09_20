import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget
{
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
{
  List postsList = [];

  @override
  void initState()
  {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: postsList.length == 0 ? Center(child: CircularProgressIndicator()) : ListView.separated(
          itemBuilder: (context, index) => buildItem(context, postsList[index]),
          separatorBuilder: (context, index) => Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey,
          ),
          itemCount: postsList.length,
      ),
    );
  }

  Widget buildItem(context, post) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.blue,
          child: Text(
            '${post['id']}',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${post['title']}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'by : ${post['author']['name']}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${post['categories'][0]['name']}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${post['content']}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  void getData() async
  {
    var url = 'https://2code.info/demo/themes/Discy/Boxed/api/get_recent_posts/?post_type=question';
    var jsonResponse = await http.get(url);

    Map response = json.decode(jsonResponse.body);

    postsList = RecentPostsMap.get(response).getPosts();
    setState(() {

    });
  }
}




// class RecentPosts
// {
//   bool status;
//   int count;
//   int count_total;
//   int pages;
//
//   List<Post> posts;
// }
//
// class Post
// {
//
//
//   int id;
//   String title;
//   String content;
//   String date;
//   List<Categories> categories;
//   List<Categories> tags;
//   Author author;
//   bool favorite;
// }
//
// class Categories
// {
//   int id;
//   String name;
// }
//
// class Author
// {
//   int id;
//   String name;
//   String description;
//   String avatar;
//   bool verified;
// }
//



class RecentPostsMap
{
  final Map dataFromApi;

  RecentPostsMap(this.dataFromApi);

  static RecentPostsMap get(Map stringFromApi)
  {
    return RecentPostsMap(stringFromApi);
  }

  bool getStatus() => dataFromApi['status'];
  int getCount() => dataFromApi['count'];
  int getPages() => dataFromApi['pages'];
  int getTotal() => dataFromApi['count_total'];
  List getPosts() => dataFromApi['posts'];
}

