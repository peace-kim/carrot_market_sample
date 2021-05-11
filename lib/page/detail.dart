import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;

  DetailContentView({key, this.data}) : super(key: key);

  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  Size size;
  List<Map<String,String>> imgList;
  int _current;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    imgList = [
      {"id" : "0", "url" : widget.data["image"]},
      {"id" : "1", "url" : widget.data["image"]},
      {"id" : "2", "url" : widget.data["image"]},
      {"id" : "3", "url" : widget.data["image"]},
      {"id" : "4", "url" : widget.data["image"]},
    ];
  }

  Widget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      },icon: Icon(Icons.arrow_back, color: Colors.white)),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ],
    );
  }

  Widget _bodyWidget() {
    return Stack(
      children: [
        Hero(
          tag: widget.data["cid"],
          child: Container(
            child:
            CarouselSlider(
              options: CarouselOptions(
                height: size.width,
                initialPage: 0,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: (index, reason){
                  setState((){
                    _current = index;
                    print(index);
                  });
                }
              ),
              items: imgList.map((map){
              return Image.asset(
                    map["url"],
                    width: size.width,
                    fit: BoxFit.fill
                );
              }).toList(),

            ),


          ),
        ),
        
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((map) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == int.parse(map["id"])
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                ),
              );
            }).toList(),
          ),
        ),


      ],
    );
  }

  Widget _bottomBarWidget(){
    return Container(
      width : size.width,
      height: 55,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}
