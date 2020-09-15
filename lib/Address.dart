class UserAddress{
  String fullAddress;
  String state;
  String country;
  String district;
  String postalCode;
  double latitude;
  double longitude;


  UserAddress(this.fullAddress,this.state,this.country,this.district,this.postalCode,this.latitude,this.longitude);

   Map<String,dynamic> getMap(){
     Map<String,dynamic> map = {
       "fullAddress": fullAddress,
       "state":state,
       "country":country,
       "district":district,
       "postalCode":postalCode,
       "latitude":latitude,
       "longitude":longitude
     };

     return map;
   }

   void fromMap(Map<String,dynamic> map){
     this.fullAddress = map['fullAddress'];
     this.state = map['state'];
     this.country = map['country'];
     this.district = map['district'];
     this.postalCode = map['postalCode'];
     this.latitude  = map['latitude'];
     this.longitude = map['longitude'];
   }
}
