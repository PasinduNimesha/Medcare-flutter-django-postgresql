class Patient {
  String User_ID;
  String Patient_ID;
  String First_name;
  String Last_name;
  String Other_name;
  String Birthday;
  String Street_No;
  String Street_Name;
  String City;
  String Postal_Code;
  String NIC;
  String Breakfast_time;
  String Lunch_time;
  String Dinner_time;

  Patient(
      {required this.User_ID,
      required this.Patient_ID,
      required this.First_name,
      required this.Last_name,
      required this.Other_name,
      required this.Birthday,
      required this.Street_No,
      required this.Street_Name,
      required this.City,
      required this.Postal_Code,
      required this.NIC,
      required this.Breakfast_time,
      required this.Lunch_time,
      required this.Dinner_time});
}
