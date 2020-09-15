class PaymentDescription{
  String course;
  String type;
  String standard;
  String subject;
  PaymentDescription(this.course,this.type,this.standard,this.subject);

  Map<String,dynamic> getMap(){
    Map<String,dynamic> map ={
      "course":this.course,
      "type":this.type,
      "standard":this.standard,
      "subject":this.subject,
    };
    return map;
  }
}

class PaymentSchema{
  String payment_id;
  String order_id;
  String customer_id;
  DateTime dateTime;
  DateTime validUpto;
  String balance;
  String status;
  PaymentDescription paymentDescription;

  PaymentSchema(this.payment_id,this.order_id,this.customer_id,this.dateTime,this.validUpto,this.balance,this.status,this.paymentDescription);

  Map<String,dynamic> getMap(){
    Map<String,dynamic> map = {
      "payment_id": this.payment_id,
      "order_id":this.order_id,
      "customer_id":this.customer_id,
      "start-date":this.dateTime,
      "valid-upto":this.validUpto,
      "balance":this.balance,
      "status":this.status,
      "payment-description":this.paymentDescription.getMap(),
    };
    return map;
  }
}
class FailPaymentSchema{
  int code;
  String message;
  String customer_id;
  DateTime dateTime;
  String balance;

  FailPaymentSchema(this.code,this.message,this.customer_id,this.dateTime,this.balance);

  Map<String,dynamic> getMap(){
    Map<String,dynamic> map = {
      "code": this.code,
      "message":this.message,
      "customer_id":this.customer_id,
      "date-time":this.dateTime,
      "balance":this.balance,
    };
    return map;
  }
}