class MyUser{
  String email;
  String companyName;
  String phoneNumber;
  String fullName;

  MyUser({required this.email,required this.companyName,required this.phoneNumber,required this.fullName});
   
   Map<String, Object> toDocument() {
    return {
      'email': email,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
    };
  }

  static MyUser fromDocument(Map<String, dynamic> doc) {
    return MyUser(
        email: doc['email'],
        companyName: doc['companyName'],
        phoneNumber: doc['phoneNumber'],
        fullName: doc['fullName']);
  }
}