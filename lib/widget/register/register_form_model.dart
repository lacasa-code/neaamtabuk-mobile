class Model {
  String Name;
  String email;
  String password;
  String address;
  String mobile;
  String region;
  String password_confirmation;
  String gender;
  String longitude;
  String latitude;
  String role_id;
  String donation_type_id;

  Model(
      {this.Name,
        this.email,
        this.password,
        this.mobile,
        this.region,
        this.address,
        this.password_confirmation,
        this.gender,
        this.latitude,
        this.longitude,
        this.role_id,
        this.donation_type_id
      });
}
