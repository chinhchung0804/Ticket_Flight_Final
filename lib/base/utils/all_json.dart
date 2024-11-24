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
    'flying_time': '8h 30M',
    'date': "01/05",
    'thoi_gian_khoi_hanh': "08:00 AM",
    'Number': 23
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
    'flying_time': '9h 30M',
    'date': "01/05",
    'thoi_gian_khoi_hanh': "09:00 AM",
    'Number': 25
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
    'date': "01/05",
    'thoi_gian_khoi_hanh': "11:00 AM",
    'Number': 5
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
    'flying_time': '7h 30M',
    'date': "01/05",
    'thoi_gian_khoi_hanh': "07:00 AM",
    'Number': 15
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
    'flying_time': '14h 30M',
    'date': "01/05",
    'thoi_gian_khoi_hanh': "2:00 PM",
    'Number': 18
  },
];


List<Map<String, dynamic>> hotelList = [
  {
    'image': 'hotel_room_dn_1.jpg',
    'place': 'Open Space',
    'destination': 'Đà Nẵng',
    'price': '400.000đ',
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
    'price': '350.000đ',
    'detail': 'Tọa lạc ở trung tâm TP. Hồ Chí Minh, cách Chợ Bến Thành 3 phút đi bộ, MG Daisy Boutique Hotel cung cấp các phòng có điều hòa và Wi-Fi miễn phí. Chỗ nghỉ nằm gần một số điểm tham quan nổi tiếng, cách Trung tâm Thương mại Vincom Center A khoảng chưa đến 1 km, Dinh Thống Nhất khoảng 12 phút đi bộ, Nhà thờ Đức Bà khoảng 1.1 km. Đây là chỗ nghỉ không gây dị ứng và nằm cách Bảo tàng Thành phố Hồ Chí Minh 8 phút đi bộ. Tại khách sạn, mỗi phòng đều có bàn làm việc, TV màn hình phẳng, phòng tắm riêng, ga trải giường và khăn tắm. Các phòng đều có tủ lạnh. Các điểm tham quan nổi tiếng gần MG Daisy Boutique Hotel bao gồm Trung tâm mua sắm Takashimaya Việt Nam, Công viên Tao Đàn và Ủy ban nhân dân Thành phố Hồ Chí Minh. Chỗ nghỉ cách Sân bay Quốc tế Tân Sơn Nhất 7 km và cung cấp dịch vụ đưa đón sân bay mất phí.',
    'images': [
      'image_sg_1.jpg',
      'image_sg_2.jpg',
      'image_sg_3.jpg',
    ]
  },
  {
    'image': 'hotel_room_hn_1.jpg',
    'place': 'Close Space',
    'destination': 'Hà Nội',
    'price': '500.000đ',
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
    'price': '300.000đ',
    'detail': 'Tọa lạc tại khu trung tâm thành phố Huế, cách Sông Hương và Cầu Tràng Tiền 5 phút lái xe, khách sạn này cung cấp các phòng nghỉ lắp máy điều hòa, khu vườn, nhà hàng trong khuôn viên. Wi-Fi lẫn chỗ đỗ xe riêng đều được cung cấp miễn phí ngay trong khuôn viên. Các phòng nghỉ tại ÊMM Hotel Hue có sàn lát gạch/đá cẩm thạch, ban công riêng, truyền hình vệ tinh màn hình phẳng, tủ lạnh mini và ấm đun nước điện. Phòng tắm riêng trong mỗi phòng được trang bị vòi sen, máy sấy tóc, đồ vệ sinh cá nhân miễn phí, dép và áo choàng tắm để tạo sự thoải mái cho du khách. Đội ngũ nhân viên tại quầy lễ tân làm việc 24/24 có thể hỗ trợ du khách với các dịch vụ phòng giữ hành lý, cho thuê xe hơi và dịch vụ đưa đón sân bay có thể được thu xếp kèm phụ phí. Nhà hàng Spiceviet phục vụ các món ăn Huế chính thống được chế biến bằng những nguyên liệu địa phương. Yen Restaurant là nhà hàng phục vụ ăn uống suốt cả ngày với một loạt các món ăn Việt Nam và quốc tế. Chợ Đông Ba và Tử Cấm Thành đều cách ÊMM Hotel Hue 2 km trong khi ga tàu Huế cách đó 1,45 km. Sân bay gần nhất là sân bay quốc tế Phú Bài, cách nơi nghỉ 15 km.',
    'images': [
      'image_hue_1.jpg',
      'image_hue_2.jpg',
      'image_hue_3.jpg',
    ]
  },
];