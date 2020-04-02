import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/widgets/range.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calory_calc/utils/databaseHelper.dart';

class Data{
  int id;

  Data({this.id});
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController;

  String name = "";
  String surname = "";
  List<Data> data = [];

  RangeGraphData calory = getColor(RangeGraphData( name: "кКалории",percent: 45.67,weigth: 1245));
  RangeGraphData fat = getColor(RangeGraphData( name: "Жиры",percent: 65.67,weigth: 13.5));
  RangeGraphData squi = getColor(RangeGraphData( name: "Белки",percent: 65.67,weigth: 24.2));
  RangeGraphData carboh = getColor(RangeGraphData( name: "Углеводы",percent: 65.67,weigth: 35.0));

  @override
  void initState() {
    super.initState();
      DBUserProvider.db.getUser().then((res){
        setState(() {
          name = res.name;
          surname = res.surname;
        });
      });
    for (var i = 0; i < 6; i++) {
        data.add(Data(id:i));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTheme.bgColor,
      body:
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  constraints: BoxConstraints.expand(height: 340),
                  decoration: BoxDecoration(
                    gradient: DesignTheme.gradient,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(140), bottomRight: Radius.circular(140))
                  ),
                    
                  child: Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children:<Widget>[
                                Text(name + " " + surname ,style: DesignTheme.bigWhiteText,),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 32,
                                    ),
                                 onPressed: (){

                                 })
                              ]),
                              getBigRangeWidget(calory),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  getRangeWidget(squi),
                                  getRangeWidget(fat),
                                  getRangeWidget(carboh),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child:
                                Text("Сегодня " + DateFormat('dd.MM.yyyy').format(DateTime.now()),
                                  textAlign: TextAlign.start,
                                  style: DesignTheme.lilWhiteText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:280, left: 30, right: 30),
                  constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height-280),
                  child: 
                    FutureBuilder<List<Data>>(
                      initialData: data,
                      // future: isSaerching ? DBNoteProvider.db.getAllNotesSearch(searchText) : DBNoteProvider.db.getAllNotes(),
                      builder:
                      (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                      if (snapshot.hasData) 
                        {
                          return StaggeredGridView.countBuilder(
                            controller: scrollController,
                            padding: const EdgeInsets.all(7.0),
                            mainAxisSpacing: 7.0,
                            crossAxisSpacing: 7.0,
                            crossAxisCount: 4,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i){
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                elevation: 2.0,
                                child:
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Aнтилопа", style: DesignTheme.primeText,),
                                          Text("1140 кКал 100 Грамм", style: DesignTheme.secondaryText,)
                                        ],
                                      ),
                                  ),
                                );
                            },
                            staggeredTileBuilder: (int i) => 
                              StaggeredTile.count(2,1));
                        }
                        else 
                        {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                    ),
                  ),
                ]
              ),

            bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor:DesignTheme.mainColor,
                height: 55.0,
            backgroundColor: Colors.transparent,
            animationDuration: Duration(microseconds: 1000),
            items: <Widget>[
              Icon(Icons.pie_chart_outlined, size: 30, color: Colors.black54,),
              Padding(
                child:
                  Icon(FontAwesomeIcons.userAlt, size: 30, color: DesignTheme.whiteColor),
                  padding: EdgeInsets.all(7.0),
              ),
              Icon(Icons.add, size: 30, color: Colors.black54,),
            ],
            index: 1,
            animationCurve: Curves.easeInCirc,
            onTap: (index) {
              if(index == 0){
                Navigator.pushNamed(context, '/');
              }
              if(index == 1){
                Navigator.pushNamed(context, '/');
              }
              if(index == 2){
                Navigator.pushNamed(context, '/');
              }
            },
          ),

            );
  }

  getRangeWidget(RangeGraphData range) {
    return  Padding(padding: EdgeInsets.only(top: 10, right: 10, left: 0),child: 
            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      range.name,
                                      style: DesignTheme.lilWhiteText,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, top: 4),
                                      child: Container(
                                        height: 6,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: (range.percent * 0.01)*80,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                gradient:range.gradient,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        range.weigth.toString() + ' г',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          // fontFamily: FintnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: DesignTheme.whiteColor
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
  }
  getBigRangeWidget(RangeGraphData range) {
    return  Padding(padding: EdgeInsets.only(top: 10, right: 0, left: 0),
                child: 
                  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children:<Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width-286,),
                                          child: Text(
                                            range.name,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                              letterSpacing: -0.2,
                                              color: DesignTheme.whiteColor,
                                            ),
                                          ),
                                        ),
                                      Text(
                                        range.weigth.toString(),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          letterSpacing: -0.2,
                                          color: DesignTheme.whiteColor,
                                        ),
                                      ),
                                    ]),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, top: 4),
                                      child: Container(
                                        height: 10,
                                        width: MediaQuery.of(context).size.width-122,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: (MediaQuery.of(context).size.width-122)*range.percent*0.01,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                gradient:range.gradient,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
  }

  Widget getTaskCard(Data task) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 20, bottom: 30, top: 30),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                  child: Text('sd'
                ), padding: EdgeInsets.only(left: 5),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          ],
          ),
        ],
      ),
    );
  }

}