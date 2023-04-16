// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newzia/application/home/bloc/home_bloc.dart';
import 'package:newzia/domain/home/model/home.dart';
import 'package:newzia/presentation/home/article_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const HomeEvent.getNews());
    });
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Image.asset('assets/logo2.png'),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.isError) {
              return Center(child: Text('Some Error Occurd'));
            }
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                final newsItem = state.news[index];
                return GestureDetector(
                  onTap: () {
                    navigateToArticleDetailPage(context, newsItem);
                  },
                  child: NewsCard(
                    newsItem: newsItem,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void navigateToArticleDetailPage(BuildContext context, newsItem) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return ArticleScreen(
      newsItem: newsItem,
      // article: article,
    );
  }));
}

class NewsCard extends StatelessWidget {
  final Home newsItem;
  const NewsCard({
    Key? key,
    required this.newsItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String originalDateString = newsItem.publishedAt.toString();
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(originalDateString));
    return Container(
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage('${newsItem.urlToImage}'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.5, 1],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${newsItem.title}",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${newsItem.author}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
