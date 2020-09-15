class ScoreClass{
  double score;
  int total;
  int attempted;
  int unattempted;
  int correct;
  int incorrect;
  ScoreClass(this.score,this.total,this.attempted,this.unattempted,this.correct,this.incorrect);

  Map<String,dynamic> getMap(){
    Map<String,dynamic> map ={
      'score':score,
      'total':total,
      'attempted':attempted,
      'unattempted':unattempted,
      'correct':correct,
      'incorrect':incorrect,
    };
    return map;
  }
}