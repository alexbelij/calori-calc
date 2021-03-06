import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class CustomRadio extends StatefulWidget {
  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 1.2, 'Минимум физической активности'));
    sampleData.add(new RadioModel(false, 1.375, 'Занимаюсь спортом 1-3 раза в неделю'));
    sampleData.add(new RadioModel(false, 1.55, 'Занимаюсь спортом 3-4 раза в неделю'));
    sampleData.add(new RadioModel(false, 1.7, 'Занимаюсь спортом каждый день'));
    sampleData.add(new RadioModel(false, 1.9, 'Тренируюсь по несколько раз в день'));
  }
  
                  
                      
  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      Padding(padding: EdgeInsets.only(top:120),
        child:
      Text("Выберите Степень вашей физической активности: ", style: DesignTheme.label,),),

      Padding(padding: EdgeInsets.only(top:170),
        child:
          ListView.builder(
            itemCount: sampleData.length,
            itemBuilder: (BuildContext context, int index) {
              return new InkWell(
                highlightColor: DesignTheme.secondColor,
                focusColor: DesignTheme.secondColor,

                splashColor: DesignTheme.secondColor,
               onTap: (){ addClick(); 
                  setState(() {
                    sampleData.forEach((element) => element.isSelected = false);
                    sampleData[index].isSelected = true;
                  });
                  DBUserProvider.db.updateDateProducts("workModel", sampleData[index].multiplaier).then((count1){
                      if(count1 == 1){
                        Navigator.pushNamed(context, '/selectActiviti');
                      }
                      else{
                        // TODO : Alert
                      }
                  });
                },
                child: new RadioItem(sampleData[index]),
              );
            },
          )
        ),
      ]
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(10.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left:0),
            child:
          new Container(
            height: 25.0,
            width: 25.0,
            child: new Center(
              child: new Icon(
                Icons.check,
                      color:
                          _item.isSelected ? Colors.white : Colors.black,
                      size: 18.0
                    ),
            ),
            decoration: new BoxDecoration(

              color: _item.isSelected
                  ? DesignTheme.secondColor
                  : Colors.transparent,

              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? DesignTheme.secondColor
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Column(children:[
              Text(_item.text, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),)
            ]),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final double multiplaier;
  final String text;

  RadioModel(this.isSelected, this.multiplaier, this.text);
}