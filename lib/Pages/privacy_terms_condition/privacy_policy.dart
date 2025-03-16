import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
                "Welcome to Bandobasta. Your privacy is important to us. This Privacy Policy outlines the types of information we collect, how it is used, and the measures we take to protect it. By using Bandobasta, you agree to this Privacy Policy. If you do not agree, please refrain from using our services."),
            const SizedBox(height: 10),
            const Text("Last Updated: Feb 6th, 2025",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildSection("1. Information We Collect", [
              "Personal Information: Name, email address, phone number, and payment details when you register or make bookings.",
              "Usage Data: Information about how you use the platform, including pages visited, actions taken, and device information (e.g., IP address, browser type).",
              "Location Data: We do not currently collect location data. If this changes in the future, we will notify you and update this Privacy Policy accordingly."
            ]),
            _buildSection("2. How We Use Your Information", [
              "To provide and personalize our services for all users, regardless of age, gender, ethnicity, or background.",
              "To process bookings and facilitate communication between users and vendors.",
              "To send updates, promotional offers, and important notifications.",
              "To improve our platform based on user behavior and feedback.",
              "To comply with legal obligations and protect the rights of Bandobasta and its users."
            ]),
            _buildSection("3. Sharing of Information", [
              "With vendors to fulfill your bookings.",
              "With service providers assisting us in platform operations (such as analytics providers).",
              "As required by law or to protect the rights of Bandobasta and its users."
            ]),
            _buildSection("4. Security Measures", [
              "We take appropriate measures to protect your data from unauthorized access, alteration, or disclosure. This includes encrypted data transmission, secure storage systems, and regular security audits. However, no system is completely secure, and we cannot guarantee absolute security."
            ]),
            _buildSection("5. Your Choices", [
              "Access and update your personal information through your account settings.",
              "Request deletion of your account and associated data by filling out this Account Deletion Form or contacting us at info@bandobasta.com."
            ]),
            _buildSection("6. Use by Minors", [
              "Bandobasta is designed for users of all ages. However, users under 18 years of age must have parental or guardian consent to register and use our services.",
              "We do not knowingly collect personal data from children under 13. If you believe we have collected data from a minor, please contact us for immediate removal."
            ]),
            _buildSection("7. Cookies", [
              "We use cookies to enhance your experience and gather analytical data. You can manage cookie preferences through your browser settings. Note that disabling cookies may affect platform functionality."
            ]),
            _buildSection("8. Changes to This Policy", [
              "We may update this Privacy Policy from time to time. Changes will be posted on this page with an updated 'Last Revised' date. Continued use of our platform constitutes acceptance of the updated terms."
            ]),
            _buildSection("9. Contact Information", [
              "If you have questions about this Privacy Policy or wish to exercise your rights, please contact us at:",
              "Email: info@bandobasta.com",
              "Phone: +977-9818084243"
            ]),
            const SizedBox(height: 20),
            const Text(
              "By using Bandobasta, you confirm that you have read, understood, and accepted our Privacy Policy.",
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          ...points.map((point) => Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
                child: Text("• $point"),
              )),
        ],
      ),
    );
  }
}
