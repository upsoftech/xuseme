import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/constant/image.dart';
import '../../constant/api_constant.dart';
import '../../services/api_services.dart';
import '../../services/preference_services.dart';
import '../../constant/color.dart';
import '../../provider/category_provider.dart';
import '../../provider/location_provider.dart';
class EditVendorProfile extends StatefulWidget {
  const EditVendorProfile({Key? key, this.data}) : super(key: key);
  final Map<String, dynamic>? data;

  @override
  State<EditVendorProfile> createState() => _EditVendorProfileState();
}

class _EditVendorProfileState extends State<EditVendorProfile> {

  final formKey = GlobalKey<FormState>();

  XFile? images;
  final ImagePicker _picker = ImagePicker();

  openPhoto(ImageSource imageSource) async {
    await _picker.pickImage(source: imageSource).then((value) {
      images = value;
      setState(() {});
      Navigator.pop(context);
    });
  }

  final pinController = TextEditingController();
  String? state;
  String? shopType;

  /// Controller for textfield ///
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final landlineController = TextEditingController();
  final emailController = TextEditingController();
  final shopNameController = TextEditingController();
  final shopTypeController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final addServicesController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   nameController.text = widget.data!["name"];
   mobileController.text = widget.data!["mobile"];
   landlineController.text = widget.data!["landline"];
   emailController.text = widget.data!["email"];
   shopNameController.text = widget.data!["shopName"];
   shopType = widget.data!["shopType"];
   addressController.text = widget.data!["address"];
   landmarkController.text = widget.data!["landmark"];
   pinController.text = widget.data!["pincode"];
   state = widget.data!["state"];
   addServicesController.text = widget.data!["services"];
    Provider.of<CategoryProvider>(context, listen: false).getCategoryData( query: '');
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final catProvider = Provider.of<CategoryProvider>(context);


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text("Edit Profile",style: GoogleFonts.alice(color: textWhite,fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: GestureDetector(
        onTap:(){

            if (formKey.currentState!.validate()) {
              Provider.of<LocationProvider>(context, listen: false)
                  .getCoordinatesFromAddress(
                "${addressController.text.trim()}, ${landmarkController.text
                    .trim()}, "
                    "${pinController.text.trim()},"
                    "${state}",
              )
                  .then((value) {
                if (locationProvider.geocodingLocation != null) {
                  ApiServices()
                      .updatePartner(
                      images?.path,
                      nameController.text.trim(),
                      mobileController.text.trim(),
                      landlineController.text.trim(),
                      emailController.text.trim(),
                      shopNameController.text.trim(),
                      shopType,
                      addressController.text.trim(),
                      landmarkController.text.trim(),
                      pinController.text.trim(),
                      locationProvider.geocodingLocation!.latitude.toString(),
                      locationProvider.geocodingLocation!.longitude
                          .toString(),
                      state,
                      addServicesController.text.trim())
                      .then((value) {
                    log("message$value");
                    if (value.toString().contains("PathNotFoundException")) {
                      Fluttertoast.showToast(
                          msg: "Please Select Image",
                          backgroundColor: primaryColor);
                    } else if (value.toString().contains(
                        "All parameters are required")) {
                      Fluttertoast.showToast(
                          msg: "${value["message"]}",
                          backgroundColor: primaryColor);
                    }
                    else {
                      Fluttertoast.showToast(
                          msg: "${value["message"]}",
                          backgroundColor: primaryColor);
                      PrefService().setRegId(value["data"]["_id"]);
                      PrefService().setSelectType(value["data"]["type"]);
                      Get.back();
                    }
                  });
                } else {
                  // No location found for the given address
                  log("No location found for the given address");
                }
              }).catchError((error) {
                // Handle the error from geocoding operation
                log("Error during geocoding: $error");
                Fluttertoast.showToast(
                    msg: "Please Provide Correct Address",
                    backgroundColor: primaryColor);
              });
            }

        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          alignment: Alignment.center,
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: textBlack,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Text("Update",style: GoogleFonts.alice(color: textWhite,fontSize: 16,fontWeight: FontWeight.bold),),
        ),
      ),
      body:SafeArea(
        child:SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextFormField(
                    controller: nameController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: ('Name'),
                      labelStyle: GoogleFonts.alice(),
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'name is required';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextFormField(
                    controller: mobileController,
                    cursorColor: Colors.black,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: ('Mobile No.'),
                      labelStyle: GoogleFonts.alice(),
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                              .hasMatch(value)) {
                        return "Enter Mobile Number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextFormField(
                    controller: landlineController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: ('Landline No.'),
                      labelStyle: GoogleFonts.alice(),
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                              .hasMatch(value)) {
                        return "Enter Landline Number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: ('Email'),
                      labelStyle: GoogleFonts.alice(),
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                    ),
                    /*   validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },*/
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextFormField(
                    controller: shopNameController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: ('Shop name'),
                      labelStyle: GoogleFonts.alice(),
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Shop name is required';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: DropdownButtonFormField<String>(

                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Shop Type ',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      labelStyle: GoogleFonts.alice(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Shop Type is required';
                      }
                      return null;
                    },
                    value: shopType,
                    items: catProvider.categoryList.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.title,
                        child: Text(
                          "${e.title}",
                          style: GoogleFonts.alice(),
                        ),
                      );
                    }).toList(),

                    onChanged: (String? newStateId) {
                      setState(() {
                        shopType = newStateId!;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextFormField(
                    controller: addressController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: ('Address'),
                      labelStyle: GoogleFonts.alice(),
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextFormField(
                    controller: landmarkController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: ('Landmark'),
                      labelStyle: GoogleFonts.alice(),
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Landmark is required';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: pinController,
                          onChanged: (v) {
                            if (v.length >= 7) {
                              pinController.text = "";
                              Fluttertoast.showToast(
                                  msg: "Only Required 6 digit",
                                  backgroundColor: primaryColor);
                            }
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 1, color: textBlack),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 1, color: textBlack),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: ('Pin Code'),
                            labelStyle: GoogleFonts.alice(),
                            contentPadding:
                            const EdgeInsets.only(top: 10, left: 20),
                          ),
                          // validator: (value) {
                          //   if (value!.isEmpty ||
                          //       !RegExp(r'^[1-9]{1}[0-9]{2}\\s{0,1}[0-9]{3}$')
                          //           .hasMatch(value)) {
                          //     return "Enter Pin Code";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          key: UniqueKey(),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: textBlack),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: textBlack),
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: 'State',
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              labelStyle: GoogleFonts.alice()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select state';
                            }
                            return null;
                          },
                          value: state,
                          items: const [
                            DropdownMenuItem<String>(
                              value: "Andhra Pradesh",
                              child: Text("Andhra Pradesh"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Arunachal Pradesh",
                              child: Text("Arunachal Pradesh"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Assam",
                              child: Text("Assam"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Bihar",
                              child: Text("Bihar"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Chhattisgarh",
                              child: Text("Chhattisgarh"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Goa",
                              child: Text("Goa"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Gujarat",
                              child: Text("Gujarat"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Haryana",
                              child: Text("Haryana"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Himachal Pradesh",
                              child: Text("Himachal Pradesh"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Jharkhand",
                              child: Text("Jharkhand"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Karnataka",
                              child: Text("Karnataka"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Kerala",
                              child: Text("Kerala"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Madhya Pradesh",
                              child: Text("Madhya Pradesh"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Maharashtra",
                              child: Text("Maharashtra"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Manipur",
                              child: Text("Manipur"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Meghalaya",
                              child: Text("Meghalaya"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Mizoram",
                              child: Text("Mizoram"),
                            ),
                            DropdownMenuItem<String>(
                              value: "New Delhi",
                              child: Text("New Delhi"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Nagaland",
                              child: Text("Nagaland"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Odisha",
                              child: Text("Odisha"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Punjab",
                              child: Text("Punjab"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Rajasthan",
                              child: Text("Rajasthan"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Sikkim",
                              child: Text("Sikkim"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Tamil Nadu",
                              child: Text("Tamil Nadu"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Telangana",
                              child: Text("Telangana"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Tripura",
                              child: Text("Tripura"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Uttar Pradesh",
                              child: Text("Uttar Pradesh"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Uttarakhand",
                              child: Text("Uttarakhand"),
                            ),
                            DropdownMenuItem<String>(
                              value: "West Bengal",
                              child: Text("West Bengal"),
                            ),
                          ],
                          onChanged: (String? newStateId) {
                            setState(() {
                              state = newStateId!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextFormField(
                    controller: addServicesController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: textBlack),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: ('Add Services'),
                      labelStyle: GoogleFonts.alice(),
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Add Services';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Upload Shop Logo",
                    style: GoogleFonts.alice(
                        color: textBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.withOpacity(.2),
                        backgroundImage: NetworkImage(
                          widget.data!["shopLogo"].toString() != ""
                              ? "${ApiConstant.baseUrl}uploads/${widget.data!["shopLogo"]}"
                              : noImage,
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  content: TextButton(
                                      onPressed: () {
                                        openPhoto(ImageSource.camera);
                                      },
                                      child: Text(
                                        "From Camera",
                                        style: GoogleFonts.alice(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  title: TextButton(
                                      onPressed: () {
                                        openPhoto(ImageSource.gallery);
                                      },
                                      child: Text(
                                        "From Gallery",
                                        style: GoogleFonts.alice(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              color: primaryColor,
                              size: 30,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
