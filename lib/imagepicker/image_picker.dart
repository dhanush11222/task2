import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // To handle file paths

class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  File? _image; // To store the selected image

  // Method to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the image file
      });
    }
  }

  // Method to show a dialog for selecting between camera and gallery
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Makes the dialog size small
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                  _pickImage(ImageSource.camera); // Pick image from camera
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                  _pickImage(ImageSource.gallery); // Pick image from gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row for Title with Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.red,
                  size: screenHeight * 0.04, // Icon size relative to screen height
                ),
                SizedBox(width: screenWidth * 0.02), // Add spacing
                Text(
                  "RadicalStart",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.03, // Font size relative to screen height
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03), // Add spacing

            // Container for image or placeholder text
            Container(
              width: screenWidth * 0.9, // 90% of the screen width
              height: screenHeight * 0.4, // 40% of the screen height
              decoration: BoxDecoration(
                color: Colors.grey[300], // Placeholder background
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: _image == null
                  ? Center(
                child: Text(
                  'Upload Image',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025, // Responsive text size
                  ),
                ),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // Add spacing

            // Circular button with camera icon to pick an image
            GestureDetector(
              onTap: () => _showImageSourceDialog(), // Show dialog on tap
              child: Container(
                width: screenWidth * 0.15, // 15% of the screen width
                height: screenWidth * 0.15, // Circular button with same width and height
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Circular shape
                  color: Colors.blue, // Button color
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: screenHeight * 0.04, // Icon size relative to screen height
                ), // Camera icon
              ),
            ),
          ],
        ),
      ),
    );
  }
}
