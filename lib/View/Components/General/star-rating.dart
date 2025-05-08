import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/material.dart';
typedef void RatingChangeCallback(double rating);

class StarRating extends StatefulWidget {
  final int starCount;
  double width;
  double rating;
  double? size;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;
  bool editable;
  StarRating({this.width=220,this.starCount = 5, this.rating = 0, this.onRatingChanged, this.color,this.size=30,this.editable=true});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  Widget buildStar(BuildContext context, int index) {
    Widget icon;
    if (index >= widget.rating) {
      icon = Img(star_icon,color: Color(0xffD4D4D4),width: widget.size,height: widget.size,);
    }
    // else if (index > widget.rating - 1 && index < widget.rating) {
    //   icon = new Icon(
    //     Icons.star_half,
    //     size: this.widget.size,
    //     color: widget.color ?? blackColor,
    //   );
    // }
    else {
      icon = Img(star_icon,color: warningLightColor,width: widget.size,height: widget.size,);
    }
    return new InkWell(
      onTap: !widget.editable ? null : () {
        setState(() {
          widget.rating=index+1;
        });
        if(widget.onRatingChanged!=null)
          widget.onRatingChanged!(index + 1.0);
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.ltr,
          children: new List.generate(widget.starCount, (index) => buildStar(context, index))),
    );
  }
}