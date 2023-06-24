class UserDetail {

  String user_name = '';
  String user_email = '';
  String password = '';
  String phoneNo = '';

  UserDetail(this.user_name, this.user_email, this.password, this.phoneNo,);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{

      'user_name': user_name,
      'user_email': user_email,
      'phone_num': phoneNo,
      'password': password,
//ubah sini
    };
    return map;
  }

  UserDetail.fromMap(Map<String, dynamic> map) {

    user_name = map['user_name'];
    user_email = map['user_email'];
    phoneNo = map['phone_num'];
    password = map['password'];


  }
}