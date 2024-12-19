// Dữ liệu từ all_json.dart
List<Map<String, dynamic>> ticketList = [
  {
    'from': {
      'code': "DN",
      'name': "Đà Nẵng",
    },
    'to': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'flying_time': '08h 30M',
    'thoi_gian_khoi_hanh': "08:00 AM",
    'price': 1000
  },
  {
    'from': {
      'code': "DN",
      'name': "Đà Nẵng",
    },
    'to': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'flying_time': '11h 30M',
    'thoi_gian_khoi_hanh': "11:00 AM",
    'price': 1000
  },
  {
    'from': {
      'code': "DN",
      'name': "Đà Nẵng",
    },
    'to': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'flying_time': '09h 30M',
    'thoi_gian_khoi_hanh': "09:00 AM",
    'price': 900
  },
  {
    'from': {
      'code': "DN",
      'name': "Đà Nẵng",
    },
    'to': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'flying_time': '12h 30M',
    'thoi_gian_khoi_hanh': "12:00 AM",
    'price': 900
  },
  {
    'from': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'to': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'flying_time': '07h 30M',
    'thoi_gian_khoi_hanh': "07:00 AM",
    'price': 1500
  },
  {
    'from': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'to': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'flying_time': '11h 30M',
    'thoi_gian_khoi_hanh': "11:00 AM",
    'price': 1500
  },
  {
    'from': {
      'code': "Hue",
      'name': "Huế",
    },
    'to': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'flying_time': '07h 30M',
    'thoi_gian_khoi_hanh': "07:00 AM",
    'price': 1100
  },
  {
    'from': {
      'code': "Hue",
      'name': "Huế",
    },
    'to': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'flying_time': '14h 30M',
    'thoi_gian_khoi_hanh': "14:00 AM",
    'price': 1100
  },
  {
    'from': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'to': {
      'code': "Hue",
      'name': "Huế",
    },
    'flying_time': '09h 30M',
    'thoi_gian_khoi_hanh': "09:00 PM",
    'price': 800
  },
  {
    'from': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'to': {
      'code': "Hue",
      'name': "Huế",
    },
    'flying_time': '12h 30M',
    'thoi_gian_khoi_hanh': "12:00 PM",
    'price': 800
  },
  {
    'from': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'to': {
      'code': "DN",
      'name': "Đà Nẵng",
    },
    'flying_time': '08h 30M',
    'thoi_gian_khoi_hanh': "08:00 PM",
    'price': 900
  },
  {
    'from': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'to': {
      'code': "DN",
      'name': "Đà Nẵng",
    },
    'flying_time': '18h 30M',
    'thoi_gian_khoi_hanh': "18:00 PM",
    'price': 900
  },
  {
    'from': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'to': {
      'code': "DN",
      'name': "Đà Nẵng",
    },
    'flying_time': '06h 30M',
    'thoi_gian_khoi_hanh': "06:00 PM",
    'price': 1000
  },
  {
    'from': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'to': {
      'code': "DN",
      'name': "Đà Nẵng",
    },
    'flying_time': '14h 30M',
    'thoi_gian_khoi_hanh': "14:00 PM",
    'price': 1000
  },
  {
    'from': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'to': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'flying_time': '08h 30M',
    'thoi_gian_khoi_hanh': "08:00 PM",
    'price': 1200
  },
  {
    'from': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'to': {
      'code': "HN",
      'name': "Hà Nội",
    },
    'flying_time': '12h 30M',
    'thoi_gian_khoi_hanh': "12:00 PM",
    'price': 1200
  },
  {
    'from': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'to': {
      'code': "Hue",
      'name': "Huế",
    },
    'flying_time': '09h 30M',
    'thoi_gian_khoi_hanh': "09:00 PM",
    'price': 800
  },
  {
    'from': {
      'code': "SG",
      'name': "Sài Gòn",
    },
    'to': {
      'code': "Hue",
      'name': "Huế",
    },
    'flying_time': '16h 30M',
    'thoi_gian_khoi_hanh': "16:00 PM",
    'price': 800
  },
  {
   'from': {
    'code': "SG",
    'name': "Sài Gòn",
  },
  'to': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'flying_time': '07h 30M',
  'thoi_gian_khoi_hanh': "07:00 PM",
  'price': 700
  },
  {
   'from': {
    'code': "SG",
    'name': "Sài Gòn",
  },
  'to': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'flying_time': '18h 30M',
  'thoi_gian_khoi_hanh': "18:00 PM",
  'price': 700
  },
  {
   'from': {
    'code': "HN",
    'name': "Hà Nội",
  },
  'to': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'flying_time': '06h 30M',
  'thoi_gian_khoi_hanh': "06:00 PM",
  'price': 1100
  },
  {
   'from': {
    'code': "HN",
    'name': "Hà Nội",
  },
  'to': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'flying_time': '16h 30M',
  'thoi_gian_khoi_hanh': "16:00 PM",
  'price': 1100
  },
  {
   'from': {
    'code': "ĐN",
    'name': "Đà Nẵng",
  },
  'to': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'flying_time': '07h 30M',
  'thoi_gian_khoi_hanh': "07:00 PM",
  'price': 700
  },
  {
   'from': {
    'code': "ĐN",
    'name': "Đà Nẵng",
  },
  'to': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'flying_time': '14h 30M',
  'thoi_gian_khoi_hanh': "14:00 PM",
  'price': 700
  },
  {
   'from': {
    'code': "Huế",
    'name': "Hue",
  },
  'to': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'flying_time': '08h 30M',
  'thoi_gian_khoi_hanh': "08:00 PM",
  'price': 800
  },
  {
   'from': {
    'code': "Huế",
    'name': "Hue",
  },
  'to': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'flying_time': '16h 30M',
  'thoi_gian_khoi_hanh': "16:00 PM",
  'price': 800
  },
  {
   'from': {
    'code': "Huế",
    'name': "Hue",
  },
  'to': {
    'code': "HN",
    'name': "Hà Nội",
  },
  'flying_time': '09h 30M',
  'thoi_gian_khoi_hanh': "09:00 PM",
  'price': 800
  },
  {
   'from': {
    'code': "Huế",
    'name': "Hue",
  },
  'to': {
    'code': "HN",
    'name': "Hà Nội",
  },
  'flying_time': '16h 30M',
  'thoi_gian_khoi_hanh': "16:00 PM",
  'price': 800
  },
  {
   'from': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'to': {
    'code': "HN",
    'name': "Hà Nội",
  },
  'flying_time': '06h 30M',
  'thoi_gian_khoi_hanh': "06:00 PM",
  'price': 1100
  },
  {
   'from': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'to': {
    'code': "HN",
    'name': "Hà Nội",
  },
  'flying_time': '12h 30M',
  'thoi_gian_khoi_hanh': "12:00 PM",
  'price': 1100
  },
  {
   'from': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'to': {
    'code': "Hue",
    'name': "Huế",
  },
  'flying_time': '07h 30M',
  'thoi_gian_khoi_hanh': "07:00 PM",
  'price': 800
  },
  {
   'from': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'to': {
    'code': "Hue",
    'name': "Huế",
  },
  'flying_time': '14h 30M',
  'thoi_gian_khoi_hanh': "14:00 PM",
  'price': 800
  },
  {
   'from': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'to': {
    'code': "ĐN",
    'name': "Đà Nẵng",
  },
  'flying_time': '09h 30M',
  'thoi_gian_khoi_hanh': "09:00 PM",
  'price': 700
  },
  {
   'from': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'to': {
    'code': "ĐN",
    'name': "Đà Nẵng",
  },
  'flying_time': '18h 30M',
  'thoi_gian_khoi_hanh': "18:00 PM",
  'price': 700
  },
  {
   'from': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'to': {
    'code': "SG",
    'name': "Sài Gòn",
  },
  'flying_time': '08h 30M',
  'thoi_gian_khoi_hanh': "08:00 PM",
  'price': 600
  },
  {
   'from': {
    'code': "NT",
    'name': "Nha Trang",
  },
  'to': {
    'code': "SG",
    'name': "Sài Gòn",
  },
  'flying_time': '16h 30M',
  'thoi_gian_khoi_hanh': "16:00 PM",
  'price': 600
  }
];

List<Map<String, dynamic>> hotelList = [
  {
    'image': 'hotel_room_dn_1.jpg',
    'place': 'Open Space',
    'destination': 'Đà Nẵng',
    'price': 400,
    'detail': 'Tọa lạc ở nội thành Đà Nẵng và cách bãi biển Mỹ An 800 m, Le Indochina Hotel & Beach Da Nang City sở hữu hồ bơi ngoài trời cùng trung tâm spa và cung cấp WiFi miễn phí trong toàn khuôn viên. Các phòng nghỉ tại đây đều có máy lạnh, ghế sofa, tủ quần áo và két an toàn. Phòng tắm riêng được trang bị bồn tắm/vòi sen, bồn rửa vệ sinh và áo choàng tắm, dép cùng đồ vệ sinh cá nhân miễn phí. Nhân viên tại quầy lễ tân 24 giờ sẵn sàng hỗ trợ quý khách bố trí chỗ để hành lý. Chỗ nghỉ còn có bồn tắm nóng cùng phòng xông hơi khô và cũng cung cấp xe đạp miễn phí. Le Indochina Hotel & Beach Da Nang City nằm trong bán kính 3,2 km từ Cầu Khóa Tình yêu và 3,4 km từ Bảo tàng Chăm. Sân bay quốc tế Đà Nẵng cách chỗ nghỉ 5 km. Chỗ nghỉ cung cấp dịch vụ đưa đón sân bay có tính phí. Quý khách có thể thưởng thức các bữa ăn tại nhà hàng trong khuôn viên.',
    'images': [
      'image_dn_1.jpg',
      'image_dn_2.jpg',
      'image_dn_3.jpg',
    ]
  },
  {
    'image': 'hotel_room_sg_1.jpg',
    'place': 'Night Space',
    'destination': 'Sài Gòn',
    'price': 350,
    'detail': 'Tọa lạc ở trung tâm TP. Hồ Chí Minh, cách Chợ Bến Thành 3 phút đi bộ, MG Daisy Boutique Hotel cung cấp các phòng có điều hòa và Wi-Fi miễn phí. Chỗ nghỉ nằm gần một số điểm tham quan nổi tiếng, cách Trung tâm Thương mại Vincom Center A khoảng chưa đến 1 km, Dinh Thống Nhất khoảng 12 phút đi bộ, Nhà thờ Đức Bà khoảng 1.1 km. Đây là chỗ nghỉ không gây dị ứng và nằm cách Bảo tàng Thành phố Hồ Chí Minh 8 phút đi bộ. Tại khách sạn, mỗi phòng đều có bàn làm việc, TV màn hình phẳng, phòng tắm riêng, ga trải giường và khăn tắm. Các phòng đều có tủ lạnh. Các điểm tham quan nổi tiếng gần MG Daisy Boutique Hotel bao gồm Trung tâm mua sắm Takashimaya Việt Nam, Công viên Tao Đàn và Ủy ban nhân dân Thành phố Hồ Chí Minh. Chỗ nghỉ cách Sân bay Quốc tế Tân Sơn Nhất 7 km và cung cấp dịch vụ đưa đón sân bay mất phí.',
    'images': [
      'image_sg_1.jpg',
      'image_sg_2.jpg',
      'image_sg_3.jpg',
    ]
  },
  {
    'image': 'hotel_room_hn_1.jpg',
    'place': 'H Hotel Ha Noi',
    'destination': 'Hà Nội',
    'price': 350,
    'detail': 'Nằm tại vị trí thuận tiện ở Hà Nội, H Hotel Ha Noi cung cấp các phòng có điều hòa, sân hiên, Wi-Fi miễn phí và nhà hàng. Khách sạn 4 sao này có dịch vụ phòng và quầy lễ tân 24 giờ. Đây là chỗ nghỉ không hút thuốc và nằm cách Ô Quan Chưởng 9 phút đi bộ. Tại khách sạn, các phòng được thiết kế có bàn làm việc. Ngoài phòng tắm riêng với vòi sen và đồ vệ sinh cá nhân miễn phí, một số phòng tại H Hotel Ha Noi cũng có view thành phố. Các căn ở chỗ nghỉ được trang bị TV màn hình phẳng và máy sấy tóc. Chỗ nghỉ có phục vụ bữa sáng thực đơn buffet, thực đơn à la carte hoặc kiểu lục địa mỗi buổi sáng. Các điểm tham quan nổi tiếng gần H Hotel Ha Noi bao gồm Nhà hát múa rối Thăng Long, Hồ Hoàn Kiếm và Nhà thờ Thánh Joseph. Chỗ nghỉ cách Sân bay Quốc tế Nội Bài 24 km và cung cấp dịch vụ đưa đón sân bay mất phí.',
    'images': [
      'image_hn_1.jpg',
      'image_hn_2.jpg',
      'image_hn_3.jpg',
    ]
  },
  {
    'image': 'hotel_room_hue_1.jpg',
    'place': 'Bach Ma',
    'destination': 'Huế',
    'price': 300,
    'detail': 'Tọa lạc tại khu trung tâm thành phố Huế, cách Sông Hương và Cầu Tràng Tiền 5 phút lái xe, khách sạn này cung cấp các phòng nghỉ lắp máy điều hòa, khu vườn, nhà hàng trong khuôn viên. Wi-Fi lẫn chỗ đỗ xe riêng đều được cung cấp miễn phí ngay trong khuôn viên. Các phòng nghỉ tại ÊMM Hotel Hue có sàn lát gạch/đá cẩm thạch, ban công riêng, truyền hình vệ tinh màn hình phẳng, tủ lạnh mini và ấm đun nước điện. Phòng tắm riêng trong mỗi phòng được trang bị vòi sen, máy sấy tóc, đồ vệ sinh cá nhân miễn phí, dép và áo choàng tắm để tạo sự thoải mái cho du khách. Đội ngũ nhân viên tại quầy lễ tân làm việc 24/24 có thể hỗ trợ du khách với các dịch vụ phòng giữ hành lý, cho thuê xe hơi và dịch vụ đưa đón sân bay có thể được thu xếp kèm phụ phí. Nhà hàng Spiceviet phục vụ các món ăn Huế chính thống được chế biến bằng những nguyên liệu địa phương. Yen Restaurant là nhà hàng phục vụ ăn uống suốt cả ngày với một loạt các món ăn Việt Nam và quốc tế. Chợ Đông Ba và Tử Cấm Thành đều cách ÊMM Hotel Hue 2 km trong khi ga tàu Huế cách đó 1,45 km. Sân bay gần nhất là sân bay quốc tế Phú Bài, cách nơi nghỉ 15 km.',
    'images': [
      'image_hue_1.jpg',
      'image_hue_2.jpg',
      'image_hue_3.jpg',
    ]
  },
  {
    'image': 'hotel_room_nt_1.jpg',
    'place': 'Maris',
    'destination': 'Nha Trang',
    'price': 400,
    'detail': 'Maris Hotel Nha Trang có hồ bơi ngoài trời, trung tâm thể dục, nhà hàng và quầy bar ở Nha Trang. Ngoài Wi-Fi miễn phí, khách sạn 4 sao này còn cung cấp câu lạc bộ trẻ em và dịch vụ phòng. Khách sạn cung cấp bể sục và quầy lễ tân 24 giờ. Khách sạn sẽ cung cấp cho khách các phòng có điều hòa, bàn làm việc, ấm đun nước, minibar, két an toàn, TV màn hình phẳng và phòng tắm riêng với vòi sen. Các phòng có tủ quần áo. Maris Hotel Nha Trang có phục vụ bữa sáng thực đơn buffet và kiểu lục địa hằng ngày. Các điểm tham quan nổi tiếng gần chỗ nghỉ bao gồm Bãi biển Nha Trang, Tháp Trầm Hương và Trung tâm thương mại Nha Trang Center. Sân bay quốc tế Cam Ranh cách 34 km.',
    'images': [
      'image_nt_1.jpg',
      'image_nt_2.jpg',
      'image_nt_3.jpg',
    ]
  },


  {
    'image': 'hotel_room_dn_11.jpg',
    'place': 'Dylan Hotel',
    'destination': 'Đà Nẵng',
    'price': 450,
    'detail': 'Nằm giáp biển, Dylan Hotel Danang cung cấp chỗ nghỉ 4 sao ở Đà Nẵng, đồng thời có hồ bơi ngoài trời, sân hiên và nhà hàng. Với quầy bar, chỗ nghỉ nằm cách Bãi biển Mỹ Khê chưa đến 1 km. Chỗ nghỉ cung cấp lễ tân 24/24, dịch vụ đưa đón sân bay, dịch vụ phòng và Wi-Fi miễn phí ở toàn bộ chỗ nghỉ. Tại khách sạn, tất cả các phòng có điều hòa, khu vực ghế ngồi, TV màn hình phẳng có truyền hình vệ tinh, két an toàn, phòng tắm riêng, vòi xịt/chậu rửa vệ sinh, đồ vệ sinh cá nhân miễn phí và máy sấy tóc. Tại Dylan Hotel Danang, mỗi phòng đều có ga trải giường và khăn tắm. Chỗ nghỉ có phục vụ bữa sáng thực đơn buffet, thực đơn à la carte hoặc kiểu lục địa mỗi sáng. Chỗ nghỉ cách Bãi biển Bắc Mỹ An 2.6 km và Cầu khóa Tình yêu Đà Nẵng 2.2 km.',
    'images': [
      'image_dn_11.jpg',
      'image_dn_21.jpg',
      'image_dn_31.jpg',
    ]
  },
  {
    'image': 'hotel_room_sg_11.jpg',
    'place': 'La Vela Saigon Hotel',
    'destination': 'Sài Gòn',
    'price': 550,
    'detail': 'Nằm ở TP. Hồ Chí Minh, cách Chợ Tân Định 8 phút đi bộ, La Vela Saigon Hotel cung cấp chỗ nghỉ có hồ bơi ngoài trời, chỗ đậu xe riêng miễn phí, trung tâm thể dục và phòng chờ chung. Ngoài sân hiên, khách sạn 5 sao này có các phòng được trang bị điều hòa và Wi-Fi miễn phí, trong đó mỗi phòng sẽ có phòng tắm riêng. Chỗ nghỉ này cung cấp dịch vụ phòng, quầy lễ tân 24 giờ và dịch vụ thu đổi ngoại tệ cho khách. Tại khách sạn, tất cả các phòng đều có bàn làm việc. Các phòng được thiết kế có két an toàn, trong đó một số phòng có ban công và một số khác cũng nhìn ra thành phố. Các căn có tủ quần áo. Hằng ngày, chỗ nghỉ có các lựa chọn thực đơn buffet, kiểu lục địa hoặc kiểu Mỹ cho bữa sáng. Tại La Vela Saigon Hotel, khách sẽ tìm thấy nhà hàng phục vụ ẩm thực Á. Bên cạnh đó, họ có thể yêu cầu không chứa sữa. Chỗ nghỉ cách Bảo tàng chứng tích chiến tranh 18 phút đi bộ và Dinh Thống Nhất 1.9 km.',
    'images': [
      'image_sg_11.jpg',
      'image_sg_21.jpg',
      'image_sg_31.jpg',
    ]
  },
  {
    'image': 'hotel_room_hn_11.jpg',
    'place': 'Hanoi Paradise Center Hotel',
    'destination': 'Hà Nội',
    'price': 450,
    'detail': 'Tọa lạc ở Hà Nội, cách Nhà hát múa rối Thăng Long 4 phút đi bộ, Hanoi Paradise Center Hotel & Spa cung cấp chỗ nghỉ có phòng chờ chung, chỗ đậu xe riêng, sân hiên và quầy bar. Với dịch vụ mát xa, khách sạn nằm gần một số điểm tham quan nổi tiếng, cách Hồ Hoàn Kiếm chưa đến 1 km, Ô Quan Chưởng 12 phút đi bộ và Tràng Tiền Plaza chưa đến 1 km. Chỗ nghỉ cung cấp lễ tân 24/24, dịch vụ đưa đón sân bay, dịch vụ phòng và Wi-Fi miễn phí. Khách sạn sẽ cung cấp cho khách các phòng được trang bị điều hòa có bàn làm việc, ấm đun nước, tủ lạnh, minibar, két an toàn, TV màn hình phẳng và phòng tắm riêng với vòi xịt/chậu rửa vệ sinh. Tại Hanoi Paradise Center Hotel & Spa, tất cả các phòng đều được thiết kế có ga trải giường và khăn tắm. Khách có thể thưởng thức bữa sáng thực đơn buffet, thực đơn à la carte hoặc kiểu Anh/ Ai-len tại chỗ nghỉ. Tại chỗ nghỉ, khách sẽ tìm thấy nhà hàng phục vụ ẩm thực châu Phi, Mỹ và Argentina. Bên cạnh đó, họ có thể yêu cầu không chứa sữa, đồ ăn Halal và kosher (cho người đạo Do Thái). Đi xe đạp là hoạt động được ưa chuộng trong khu vực. Ngoài ra, khách sạn 4 sao này có dịch vụ thuê xe đạp. Hanoi Paradise Center Hotel & Spa cách Nhà hát Lớn Hà Nội 12 phút đi bộ và Nhà thờ Thánh Joseph 1.2 km.',
    'images': [
      'image_hn_11.jpg',
      'image_hn_21.jpg',
      'image_hn_31.jpg',
    ]
  },
  {
    'image': 'hotel_room_hue_11.jpg',
    'place': 'Hue Serene Palace Hotel',
    'destination': 'Huế',
    'price': 350,
    'detail': 'Hue Serene Palace Hotel có vị trí chiến lược, cách Sông Hương nổi tiếng và Cầu Tràng Tiền 1 km. Khách sạn cung cấp các phòng nghỉ hiện đại được trang bị đầy đủ tiện nghi và Wi-Fi miễn phí trong toàn bộ khuôn viên. Khách sạn chỉ cách Kinh thành Huế 2 km và cách Ga Huế khoảng 3 km. Sân bay Huế cách đó 15 km trong khi Sân bay Quốc tế Đà Nẵng cách đó khoảng 90 km. Được trang bị sàn gỗ, các phòng máy lạnh được trang bị đầy đủ tiện nghi với tủ quần áo, két an toàn cá nhân, TV truyền hình cáp màn hình phẳng và khu vực tiếp khách. Tiện nghi pha trà/cà phê miễn phí cũng được cung cấp. Phòng tắm riêng đi kèm máy sấy tóc, áo choàng tắm và đồ vệ sinh cá nhân miễn phí. Hue Serene Palace Hotel có bàn đặt tour có thể hỗ trợ sắp xếp việc tham quan và đi lại. Quý khách có thể yêu cầu dịch vụ giữ hành lý, giặt là tại quầy lễ tân 24 giờ. Các tiện nghi khác bao gồm trung tâm dịch vụ doanh nhân, dịch vụ thu đổi ngoại tệ và dịch vụ cho thuê xe đạp/xe hơi.',
    'images': [
      'image_hue_11.jpg',
      'image_hue_21.jpg',
      'image_hue_31.jpg',
    ]
  },
  {
    'image': 'hotel_room_nt_11.jpg',
    'place': 'Pavillon Garden Hotel',
    'destination': 'Nha Trang',
    'price': 400,
    'detail': 'Tọa lạc tại vị trí đắc địa ở Thành phố Nha Trang, Pavillon Garden Hotel nằm cách Quảng trường 2/4 và Bãi biển Nha Trang chỉ 3 phút tản bộ. Quý khách có thể sử dụng hồ bơi ngoài trời tại đây. Khách sạn cũng cung cấp truy cập Wi-Fi miễn phí cho tất cả khách lưu trú tại đây. Chợ Đêm nằm cách chỗ nghỉ khoảng 3 phút đi bộ trong khi Trung tâm Thuyền buồm Việt Nam và quán Sailing Club đều cách đó 100 m. Khách sạn nằm trong bán kính chỉ 50 m từ Tháp Trầm Hương. Sân bay Nha Trang cách đó 27 km. Với nhiều phòng nhìn ra biển, mở ra ban công riêng, khách sạn cung cấp các phòng nghỉ được trang bị TV truyền hình cáp, máy điều hòa và khu vực ghế ngồi thoải mái. Ngoài ra, phòng còn có tiện nghi phòng tắm riêng. Một số phòng cho tầm nhìn ra quang cảnh thành phố xung quanh. Du khách có thể nhận phòng sớm lúc 12:00 miễn phí Đội ngũ nhân viên thân thiện và niềm nở tại quầy lễ tân 24 giờ có thể hỗ trợ du khách sắp xếp việc đi lại và phòng giữ hành lý, bao gồm cả dịch vụ cho thuê xe đạp và dịch vụ đưa đón sân bay. Du khách có thể thưởng thức một loạt các món ăn địa phương Việt Nam hảo hạng bao gồm cả các món ăn ngon nổi tiếng của phương Tây tại Nhà hàng Pavillon Garden. Bữa sáng buffet được phục vụ hằng ngày.',
    'images': [
      'image_nt_11.jpg',
      'image_nt_21.jpg',
      'image_nt_31.jpg',
    ]
  },

  {
    'image': 'hotel_room_dn_12.jpg',
    'place': 'NATURE Hotel',
    'destination': 'Đà Nẵng',
    'price': 450,
    'detail': 'Nằm ở Đà Nẵng, cách Bãi biển Mỹ Khê 16 phút đi bộ, NATURE Hotel By K D H cung cấp chỗ nghỉ có hồ bơi ngoài trời, chỗ đậu xe riêng miễn phí, sân hiên và tiện nghi BBQ. Chỗ nghỉ cách Bảo tàng điêu khắc Chăm khoảng 3 km, Công viên giải trí Asia Park Đà Nẵng 6 km và Ngũ Hành Sơn 10 km. Chỗ nghỉ cung cấp lễ tân 24/24, dịch vụ đưa đón sân bay, dịch vụ phòng và Wi-Fi miễn phí ở toàn bộ chỗ nghỉ. Khách sạn sẽ cung cấp cho khách các phòng có điều hòa, bàn làm việc, ấm đun nước, két an toàn, TV màn hình phẳng và phòng tắm riêng với vòi xịt/chậu rửa vệ sinh. Tại NATURE Hotel By K D H, các phòng đều có ga trải giường và khăn tắm. Hằng ngày, chỗ nghỉ có các lựa chọn thực đơn buffet, thực đơn à la carte hoặc kiểu Mỹ cho bữa sáng. Tại chỗ nghỉ, khách sẽ tìm thấy nhà hàng phục vụ ẩm thực Mỹ, Hoa và Anh. Bên cạnh đó, họ có thể yêu cầu món chay, không chứa sữa và kosher (cho người đạo Do Thái). NATURE Hotel By K D H cung cấp chỗ nghỉ 4 sao với phòng xông hơi khô. Các điểm tham quan nổi tiếng gần khách sạn bao gồm Cầu sông Hàn, Trung tâm thương mại Indochina Riverside và Cầu khóa Tình yêu Đà Nẵng. Sân bay Quốc tế Đà Nẵng cách 6 km.',
    'images': [
      'image_dn_12.jpg',
      'image_dn_22.jpg',
      'image_dn_32.jpg',
    ]
  },
  {
    'image': 'hotel_room_sg_12.jpg',
    'place': 'Apec Hotel Saigon',
    'destination': 'Sài Gòn',
    'price': 550,
    'detail': 'Tọa lạc ở TP. Hồ Chí Minh cách Công viên Tao Đàn chưa đến 1 km và Bảo tàng Mỹ thuật 14 phút đi bộ, Apec Hotel Saigon cung cấp Wi-Fi miễn phí ở toàn bộ chỗ nghỉ. Chỗ nghỉ cách Dinh Thống Nhất khoảng 16 phút đi bộ, Trung tâm Thương mại Vincom Center A 1.8 km và Ủy ban nhân dân Thành phố Hồ Chí Minh 1.7 km. Chỗ nghỉ này cách Chợ Bến Thành chưa đến 1 km và trung tâm thành phố 500 m. Chỗ nghỉ có phục vụ bữa sáng thực đơn buffet, kiểu lục địa hoặc kiểu Á mỗi sáng. Các điểm tham quan nổi tiếng gần hostel bao gồm Trung tâm mua sắm Takashimaya Việt Nam, Bảo tàng Thành phố Hồ Chí Minh và Bảo tàng chứng tích chiến tranh. Sân bay Quốc tế Tân Sơn Nhất cách 7 km.',
    'images': [
      'image_sg_12.jpg',
      'image_sg_22.jpg',
      'image_sg_32.jpg',
    ]
  },
  {
    'image': 'hotel_room_hn_12.jpg',
    'place': 'Ha Noi Lake View Hotel & Travel',
    'destination': 'Hà Nội',
    'price': 500,
    'detail': 'Nằm ở trung tâm Hà Nội, Ha Noi Lake View Hotel & Travel tọa lạc cách Nhà hát múa rối Thăng Long 3 phút đi bộ và Hồ Hoàn Kiếm chưa đến 1 km. Hostel 4 sao này có dịch vụ tiền sảnh và bàn bán tour. Chỗ nghỉ cung cấp lễ tân 24/24, dịch vụ đưa đón sân bay, dịch vụ phòng và Wi-Fi miễn phí. Hostel sẽ cung cấp cho khách các phòng có điều hòa, bàn làm việc, ấm đun nước, minibar, két an toàn, TV màn hình phẳng và phòng tắm riêng với vòi xịt/chậu rửa vệ sinh. Tất cả các phòng có tủ quần áo. Hằng ngày, chỗ nghỉ có các lựa chọn thực đơn buffet, thực đơn à la carte hoặc kiểu lục địa cho bữa sáng. Các điểm tham quan nổi tiếng gần Ha Noi Lake View Hotel & Travel bao gồm Ô Quan Chưởng, Tràng Tiền Plaza và Nhà hát Lớn Hà Nội. Sân bay Quốc tế Nội Bài cách 24 km.',
    'images': [
      'image_hn_12.jpg',
      'image_hn_22.jpg',
      'image_hn_32.jpg',
    ]
  },
  {
    'image': 'hotel_room_hue_12.jpg',
    'place': 'Rosaleen Boutique Hotel',
    'destination': 'Huế',
    'price': 300,
    'detail': 'Rosaleen Boutique Hotel nằm ở trung tâm thành phố Huế, trong bán kính chưa đến 5 phút đi bộ từ Sông Hương. Bến phà Huế cách đó 10 phút đi bộ. Các phòng tại Rosaleen Boutique Hotel đều rộng rãi và hiện đại. Phòng có kiểu trang trí sáng sủa, mát mẻ và được trang bị truyền hình vệ tinh cùng máy pha trà/cà phê. Nhiều phòng có ban công với tầm nhìn ra thành phố. Hồ bơi ngoài trời với ghế ngồi phơi nắng xung quanh là địa điểm lý tưởng để tắm nắng và thư giãn. Rosaleen Boutique Hotel cũng cung cấp dịch vụ mát-xa chuyên nghiệp và phòng xông hơi khô. Để tạo thuận tiện cho khách, Rosaleen Boutique Hotel còn cung cấp lễ tân 24 giờ, chỗ đỗ xe miễn phí trong khuôn viên và Wi-Fi miễn phí toàn khách sạn. Dịch vụ đưa đón sân bay cũng có thể được bố trí theo yêu cầu.',
    'images': [
      'image_hue_12.jpg',
      'image_hue_22.jpg',
      'image_hue_32.jpg',
    ]
  },
  {
    'image': 'hotel_room_nt_12.jpg',
    'place': 'Apus Hotel',
    'destination': 'Nha Trang',
    'price': 400,
    'detail': 'Nằm giáp biển, Apus Hotel cung cấp chỗ nghỉ 4 sao ở Nha Trang, đồng thời có hồ bơi ngoài trời, phòng chờ chung và sân hiên. Chỗ nghỉ này có các tiện nghi như nhà hàng và quầy bar. Chỗ nghỉ cung cấp lễ tân 24/24, dịch vụ đưa đón sân bay, dịch vụ phòng và Wi-Fi miễn phí ở toàn bộ chỗ nghỉ. Khách sạn sẽ cung cấp cho khách các phòng có điều hòa, bàn làm việc, ấm đun nước, minibar, két an toàn, TV màn hình phẳng và phòng tắm riêng với vòi xịt/chậu rửa vệ sinh. Tại Apus Hotel, tất cả các phòng đều được thiết kế có ga trải giường và khăn tắm. Hằng ngày, chỗ nghỉ có các lựa chọn thực đơn buffet, thực đơn à la carte hoặc kiểu lục địa cho bữa sáng. Khách có thể sử dụng dịch vụ văn phòng để làm việc hoặc đi tour tham quan được sắp xếp bởi bàn bán tour. Các điểm tham quan nổi tiếng gần chỗ nghỉ bao gồm Bãi biển Nha Trang, Tháp Trầm Hương và Trung tâm thương mại Nha Trang Center. Sân bay quốc tế Cam Ranh cách 34 km.',
    'images': [
      'image_nt_12.jpg',
      'image_nt_22.jpg',
      'image_nt_32.jpg',
    ]
  },
];

final List<Map<String, dynamic>> locations = [
    {
      "name": "Hà Nội",
      "description": "Hà Nội là thủ đô nghìn năm văn hiến của Việt Nam, là trung tâm chính trị, văn hóa và kinh tế lớn. Nơi đây không chỉ thu hút du khách bởi nét cổ kính, mà còn bởi hệ thống giao thông hiện đại, nổi bật là Sân bay Quốc tế Nội Bài.",
      "image": "ha-noi-1.jpg",
      "airport": "Sân bay Nội Bài",
      "images": [
        'ha-noi-1.jpg',
        'ha-noi-2.jpg',
        'ha-noi-3.jpg',
      ]
    },
    {
      "name": "Đà Nẵng",
      "description": "Đà Nẵng là một trong sáu thành phố trực thuộc trung ương của Việt Nam, nằm tại vùng Duyên hải Nam Trung Bộ. Đây là thành phố lớn nhất của khu vực Duyên hải Nam Trung Bộ và Tây Nguyên, đóng vai trò là trung tâm kinh tế của miền Trung và là hạt nhân quan trọng trong Vùng kinh tế trọng điểm miền Trung, thành phố biển hiện đại và năng động, nổi tiếng với Cầu Vàng.",
      "image": "da-nang-1.jpg",
      "airport": "Sân bay Đà Nẵng",
      "images": [
        'da-nang-1.jpg',
        'da-nang-2.jpg',
        'da-nang-3.jpg',
      ]
    },
    {
      "name": "Hồ Chí Minh",
      "description": "Thành phố Hồ Chí Minh (thường được gọi là Sài Gòn) là một thành phố ở miền nam Việt Nam nổi tiếng với vai trò nòng cốt trong chiến tranh Việt Nam. Sài Gòn cũng được biết đến với địa danh của thực dân Pháp, trong đó có Nhà thờ Đức Bà được xây dựng hoàn toàn bằng nguyên liệu nhập khẩu từ Pháp và Bưu điện trung tâm được xây dựng vào thế kỷ 19. Quán ăn nằm dọc các đường phố Sài Gòn, nhất là xung quanh chợ Bến Thành nhộn nhịp.",
      "image": "sai-gon-1.jpg",
      "airport": "Sân bay Tân Sơn Nhất",
      "images": [
        'sai-gon-1.jpg',
        'sai-gon-2.jpg',
        'sai-gon-3.jpg',
      ]
    },
    {
      "name": "Huế",
      "description": "Huế nổi tiếng mang nét đẹp vượt thời gian với rất nhiều danh lam thắng cảnh đắm say lòng người. Đây là nơi lý tưởng để bạn khám phá nhiều cảnh đẹp cũng như tận hưởng những phút giây thư giãn, thoải mái nhất, là cố đô mang vẻ đẹp thơ mộng, được UNESCO công nhận là di sản văn hóa thế giới. Huế còn là nơi bảo tồn các giá trị lịch sử và văn hóa truyền thống của Việt Nam.",
      "image": "hue-1.jpg",
      "airport": "Sân bay Phú Bài",
      "images": [
        'hue-1.jpg',
        'hue-2.jpg',
        'hue-3.jpg',
      ]
    },
    {
      "name": "Nha Trang - Khánh Hòa",
      "description": "Khánh Hòa là một tỉnh ven biển thuộc khu vực Nam Trung Bộ Việt Nam, nổi tiếng với cảnh quan tuyệt đẹp và là trung tâm du lịch lớn. Nơi đây không chỉ thu hút du khách trong nước mà còn hấp dẫn đông đảo du khách quốc tế nhờ hệ thống bãi biển dài, nước biển trong xanh và các đảo hoang sơ. Thành phố Nha Trang – trung tâm hành chính và kinh tế của Khánh Hòa – được mệnh danh là 'viên ngọc của Biển Đông'.",
      "image": "nha-trang-1.jpg",
      "airport": "Sân bay Phú Bài",
      "images": [
        'nha-trang-1.jpg',
        'nha-trang-2.jpg',
        'nha-trang-3.jpg',
      ]
    },
  ];