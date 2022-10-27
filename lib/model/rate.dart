class Rating{
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count
  });

  factory Rating.fromJson(Map<String, dynamic> obj){
    return Rating(
        rate: obj['rate'],
        count: obj['count']
    );
  }


}