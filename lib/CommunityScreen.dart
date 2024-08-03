import 'package:community_test/CommunityTab.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('커뮤니티'),
          bottom: TabBar(
            tabs: [
              Tab(text: '자유'),
              Tab(text: '질문'),
              Tab(text: '꿀팁'),
              Tab(text: '자랑'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CommunityTab(tabType: '자유'),
            CommunityTab(tabType: '질문'),
            CommunityTab(tabType: '꿀팁'),
            CommunityTab(tabType: '자랑'),
          ],
        ),
      ),
    );
  }
}
