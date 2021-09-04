
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({ Key? key }) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 2, 
      
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Text(
              "Trips",
              style: TextStyle(
                color: Colors.black,
              ),
              ),
          
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors. black,
            indicatorWeight: 5.0,
            onTap: (index) {},
            tabs : <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 50),
                child: Tab(
                  
                  child: Container(
                    child: Text(
                      'UPCOMING',
                      style: TextStyle(color: Colors.black,fontSize: 12.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50,right: 30),
                child: Tab(
                  child: Container(
                    child: Text(
                      'PAST',
                      style: TextStyle(color: Colors.black,fontSize: 12.0),
                    ),
                  ),
                ),
              ),
            ],
              
          ),
        ),
        body: TabBarView(
          children: [
            _buildListView('Upcoming'),
            _buildListView('past')
          ],
        ),
      
      ),
    );
  }
}
ListView _buildListView(String s){
  return ListView.builder(
    itemBuilder: (context,index) => ListTile(
      title: Text(s + ' ' + '$index'),
    )
    );
}