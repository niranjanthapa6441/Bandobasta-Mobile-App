import 'package:flutter/material.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection("Welcome to Bandobasta",
                  "By accessing or using our services, you agree to comply with and be bound by the following terms and conditions."),
              _buildSection("1. Eligibility",
                  "You must have the legal capacity to enter into this agreement and follow all applicable laws."),
              _buildSection("2. Services Offered",
                  "Bandobasta allows users to book services for events and purchase tickets."),
              _buildSection("3. User Types",
                  "Customers book services, while Vendors list their offerings."),
              _buildSection("4. Content Ownership",
                  "Users grant Bandobasta the right to publish uploaded content."),
              _buildSection("5. Prohibited Activities",
                  "Users must not post defamatory content, fake reviews, or engage in abusive behavior."),
              _buildSection("6. Liability Limitations",
                  "Bandobasta is not responsible for interactions between users and vendors."),
              _buildSection("7. Modification of Terms",
                  "Bandobasta may modify these terms at any time. Users should review them regularly."),
              _buildSection("8. Copyright Policy",
                  "Users may not infringe on copyrighted material and must have rights to shared content."),
              _buildSection("9. Governing Law",
                  "These terms shall be governed by the laws of [Insert Jurisdiction]."),
              _buildSection("10. Contact Information",
                  "Email: info@bandobasta.com\nPhone: +977-9818084243"),
              const SizedBox(height: 20),
              const Text(
                  "By using Bandobasta, you acknowledge that you have read, understood, and agree to these Terms and Conditions.",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
