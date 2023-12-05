import 'package:flutter/material.dart';
import '../../room_model.dart';
import '../../room_api.dart';
import 'package:room_details_page/screen/detail/detail.dart';
import 'package:room_details_page/widget/circle_icon_button.dart';

class RecommendedHouse extends StatefulWidget {
  TextEditingController email;
  RecommendedHouse({this.email});
  @override
  State<RecommendedHouse> createState() => _RecommendedHouseState();
}

class _RecommendedHouseState extends State<RecommendedHouse> {
  //final recommendedList = House.generateRecommended();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: 500,
      height: 600,
      child: FutureBuilder(
        future: fetchData(),
        builder: (context,snapshot) {
          if(snapshot.hasError) print(snapshot..error);
          return (snapshot.hasData)?
          ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              separatorBuilder: (_, index) => SizedBox(height: 15),
              itemBuilder: (BuildContext context, index) {
                RoomData api = snapshot.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DetailPage(room: api,email: widget.email);
                    }));
                  },
                  child: Container(
                    height: 230,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(api.imageUrl,),
                                  fit: BoxFit.cover,
                              )
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 15,
                          child: CircleIconButton(
                              iconUrl: 'assets/icons/mark.svg',
                              color: Theme.of(context).accentColor),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.white54,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${api.houseName}(${api.roomNo})",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "\$${api.price} taka",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              }
          ):Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}
