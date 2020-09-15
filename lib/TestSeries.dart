class TestSeries{
  int quesNumber;
  String question;
  String questionUrl;
  String option1;
  String option1Url;
  String option2;
  String option2Url;
  String option3;
  String option3Url;
  String option4;
  String option4Url;
  String answer;

  TestSeries(this.quesNumber,this.question,this.option1,this.option2,this.option3,this.option4,this.answer);

  void urlUpdate(String questionUrl,String option1Url,String option2Url,String option3Url,String option4Url){
    this.questionUrl = questionUrl;
    this.option1Url = option1Url;
    this.option2Url= option3Url;
    this.option4Url = option4Url;
  }

  Map<String,dynamic> getMap(){
    Map<String,dynamic> map={
      'question':question,
      'questionUrl':questionUrl,
      'option1':option1,
      'option1Url':option1Url,
      'option2':option2,
      'option2Url':option2Url,
      'option3':option3,
      'option3Url':option3Url,
      'option4':option3,
      'option4Url':option3Url,
      'answer':answer,
    };
    Map<String,dynamic> finalMap={
      quesNumber.toString():map,
    };
    return finalMap;
  }
}