import '../constant/image.dart';

class InquiryModel{
  final String image;
  final String address;
  final String services;
  final String date;
  final String process;
  InquiryModel({
    required this.image,
    required this.address,
    required this.services,
    required this.date,
    required this.process});
}


List<InquiryModel>inquiryData=[
  InquiryModel(image: window, address: "Noida City, Noida,110015", services: "Chicken leg,Boneless leg Chicken", date: "10/02/2023,10:00 AM", process: "Cooling Point Solution"),
  InquiryModel(image: ro, address: "Noida City, Noida,110015", services: "Chicken leg,Boneless leg Chicken", date: "09/01/2023,10:00 AM", process: "Fast Cool Repair"),
  InquiryModel(image: window, address: "Noida City, Noida,110015", services: "Chicken leg,Boneless leg Chicken", date: "20/11/2022,10:00 AM", process: "Cooltech Refrigeration and Aircondition"),
  InquiryModel(image: hotel, address: "Noida City, Noida,110015", services: "Chicken leg,Boneless leg Chicken", date: "09/11/2022,10:00 AM", process: "Gauri Ac Service"),
  InquiryModel(image: services, address: "Noida City, Noida,110015", services: "Chicken leg,Boneless leg Chicken", date: "01/01/2022,10:00 AM", process: "Pawan Kumar Hv Ac"),
];