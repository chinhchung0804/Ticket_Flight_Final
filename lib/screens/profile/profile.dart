import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';

class ProfileScreen extends StatefulWidget {
  final String userId; // ID người dùng được truyền vào.

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData; // Thông tin người dùng
  bool isLoading = true; // Trạng thái tải dữ liệu
  String? errorMessage; // Lưu lỗi nếu xảy ra
  int flightBookings = 1; // Số vé máy bay đã đặt
  int hotelBookings = 1; // Số khách sạn đã đặt

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Lấy dữ liệu người dùng từ Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userId)
          .get();

      if (!userDoc.exists) {
        setState(() {
          errorMessage = 'Không tìm thấy thông tin người dùng!';
          isLoading = false;
        });
        return;
      }

      setState(() {
        userData = userDoc.data();
        flightBookings = userData!['flightBookings'] ?? 1;
        hotelBookings = userData!['hotelBookings'] ?? 1;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Đã xảy ra lỗi khi tải dữ liệu: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : userData == null
                  ? const Center(
                      child: Text('Không tìm thấy thông tin người dùng.'))
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Ảnh đại diện
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: userData!['avatarUrl'] != null &&
                                      userData!['avatarUrl'].isNotEmpty
                                  ? NetworkImage(userData!['avatarUrl'])
                                  : const AssetImage(
                                          'assets/images/user_avatar.jpg')
                                      as ImageProvider,
                            ),
                            const SizedBox(height: 20),

                            const SizedBox(height: 20),

                            // Card chứa thông tin chi tiết
                            Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Họ và tên:',
                                          style:
                                              AppStyles.headLineStyle3.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          userData!['name'] ?? "Tên không rõ",
                                          style:
                                              AppStyles.headLineStyle1.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                    const Divider(height: 20, thickness: 1),

                                    // Số điện thoại
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Email:',
                                            style: AppStyles.headLineStyle3
                                                .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            userData!['email'] ??
                                                "Email không rõ",
                                            style: AppStyles.headLineStyle2
                                                .copyWith(
                                              fontSize: 16,
                                              color: Colors.grey.shade600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ]
                                      ),
                                      const Divider(height: 20, thickness: 1),

                                    // Ngày tạo
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Ngày tạo tài khoản:',
                                          style:
                                              AppStyles.headLineStyle3.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          userData!['createdAt'] != null
                                              ? (userData!['createdAt']
                                                      as Timestamp)
                                                  .toDate()
                                                  .toString()
                                                  .split(' ')[0]
                                              : "Không rõ",
                                          style:
                                              AppStyles.headLineStyle3.copyWith(
                                            fontSize: 16,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(height: 20, thickness: 1),

                                    // Số vé máy bay đã đặt
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Số vé máy bay đã đặt:',
                                          style:
                                              AppStyles.headLineStyle3.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '$flightBookings',
                                          style:
                                              AppStyles.headLineStyle3.copyWith(
                                            fontSize: 16,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(height: 20, thickness: 1),

                                    // Số khách sạn đã đặt
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Số khách sạn đã đặt:',
                                          style:
                                              AppStyles.headLineStyle3.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '$hotelBookings',
                                          style:
                                              AppStyles.headLineStyle3.copyWith(
                                            fontSize: 16,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Nút chỉnh sửa thông tin
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Thêm chức năng chỉnh sửa tại đây
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Chức năng chỉnh sửa chưa được hỗ trợ."),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text("Chỉnh sửa thông tin"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppStyles.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
    );
  }
}
