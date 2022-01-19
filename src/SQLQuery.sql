create database BookHouseSE
go

use BookHouseSE
go


create table Book(
	BookName nvarchar(200),
	BookID char(5),
	AuthorName nvarchar(100) not null,
	Description nvarchar(2000),
	Price int not null,
	Stock smallint,
	NumOfPage smallint,
	PublishingCom nvarchar(200),
	ReleaseDate date,
	CONSTRAINT PK_Book PRIMARY KEY (BookID)
);
go

create table Img(
	ImagePath nchar(300) not null,
	BookID char(5) not null FOREIGN KEY REFERENCES Book(BookID)
	CONSTRAINT PK_Img PRIMARY KEY (BookID,ImagePath)
);
go

create table Category(
	CategoryID char(5),
	CategoryName nvarchar(200),
	CONSTRAINT PK_Category PRIMARY KEY (CategoryID)
);
go

create table BookCategory(
	BookID char(5) FOREIGN KEY REFERENCES Book(BookID),
	CategoryID char(5) FOREIGN KEY REFERENCES Category(CategoryID),
	CONSTRAINT PK_BookCategory PRIMARY KEY (BookID,CategoryID)
);
go

create table FAQ(
	QuestionID char(5),
	Question nvarchar(2000) not null,
	Answer nvarchar(2000) not null,
	CONSTRAINT PK_FAQ PRIMARY KEY (QuestionID)
);
go

create table Admin(
	AdminID char(5) not null, 
	AdminName nvarchar(200) not null,
	UserName nchar(30) unique not null,
	Password nchar(30) not null,
	CONSTRAINT PK_AminUser PRIMARY KEY (AdminID)
);
go

create table Customer(
	CustomerID char(5) not null, 
	CustomerName nvarchar(200) not null,
	UserName nchar(30) unique not null,
	Password nchar(30) not null,
	CustomerEmail nchar(100),
	CustomerPhone nchar(11) unique not null,
	Address nvarchar (200),
	InBlankList bit,
	CONSTRAINT PK_Customer PRIMARY KEY (CustomerID)
);
go

Create table [Order](
	OrderID char(5),
	CustomerID char(5) FOREIGN KEY REFERENCES Customer(CustomerID),
	Address nvarchar(100),
	Phone nchar(11),
	OrderState nvarchar(50),
	TotalPrice int,
	NoteForOrder nvarchar(200),
	OrderDate date, 
	ReceivedDate date,
	RecipientName nvarchar(200),
	DeliveryMethod nvarchar(100),
	DeliveryCharge int,
	GoodsPrice int,
	CONSTRAINT PK_Order PRIMARY KEY (OrderID)
);
go

Create table OrderDetail(
	DetailID char(5),
	OrderID char(5) FOREIGN KEY REFERENCES [Order](OrderID),
	BookID char(5) FOREIGN KEY REFERENCES Book(BookID),
	Quatity smallint not null,
	PriceForDetail int,
	IsRating bit,
	CONSTRAINT PK_OrderDetail PRIMARY KEY (DetailID)
);
go

Create table CartDetail(
	CartDetailID char(5),
	CustomerID char(5) FOREIGN KEY REFERENCES Customer(CustomerID),
	BookID char(5) FOREIGN KEY REFERENCES Book(BookID),
	Quatity smallint not null,
	Price int not null,
	CONSTRAINT PK_CartDetail PRIMARY KEY (CartDetailID)
);
go


Create table CommentBook(
	CommentID char(5) not null,
	BookID char(5) not null FOREIGN KEY REFERENCES Book(BookID),
	CustomerID char(5) not null FOREIGN KEY REFERENCES Customer(CustomerID),
	Content nvarchar(2000) not null,
	CONSTRAINT PK_CommentBook PRIMARY KEY (CommentID)
);

Create table Rating(
	RatingID char(5) not null,
	BookID char(5) not null FOREIGN KEY REFERENCES Book(BookID),
	CustomerID char(5) not null FOREIGN KEY REFERENCES Customer(CustomerID),
	RatingStar smallint not null CHECK (RatingStar = 1 or RatingStar = 2 or RatingStar = 3 or RatingStar = 4 or RatingStar = 5 )
);

insert into Category
values 
	('00000',N'Tiểu thuyết'),
	('00001',N'Truyện ngắn'),
	('00002',N'Thơ'),
	('00003',N'Trinh thám'),
	('00004',N'Truyện tranh'),
	('00005',N'Lịch sử'),
	('00006',N'Triết học'),
	('00007',N'Kinh tế'),
	('00008',N'Tâm lý học'),
	('00009',N'Tham khảo'),
	('00010',N'Viễn tưởng');

--tiểu thuyết
insert into Book
values 
	(N'SÔNG NGÂN KHI TỎ KHI MỜ','00000',N'Nguyễn Quang Riệu', N'Trong cuốn sách này, Giáo sư Nguyễn Quang Riệu, nhà khoa học danh tiếng, nhà vật lý thiên văn có đóng góp đáng kể trong lĩnh vực vật lý thiên văn vô tuyến của thế giới trong những năm 1970, đã giúp các bạn đọc trẻ có được vốn hiểu biết cơ bản về vũ trụ: những người cổ đại, từ Ai Cập, Babylon, Hy Lạp đến Trung Hoa có quan niệm thế nào về vũ trụ, vũ trụ ẩn hiện trong văn hóa dân gian Việt Nam ra sao, rồi cũng vũ trụ ấy được nhìn từ phương diện khoa học: nguồn gốc và sự hình thành vũ trụ, trong đó có dải Ngân hà và hệ Mặt Trời, nơi chúng ta đang sống… “Thông qua cách sắp xếp độc đáo của cuốn sách, qua việc giảng giải các truyền thuyết hay trình bày một cách sáng sủa những thành tựu mũi nhọn của khoa học, và nhờ việc sưu tầm xuất sắc các hình ảnh minh họa, Nguyễn Quang Riệu đã thực sự hoàn thành một công trình văn hóa. Chúng ta biết ơn ông đã chia sẻ với chúng ta hai nền văn hóa mà ông hấp thụ được.” - Françoise Praderie, Nhà thiên văn tại Đài thiên văn Paris',
	61000,5,184,N'Thế giới','2019-05-31');

insert into Book
values
	(N'LÒNG TỐT CỦA BẠN CẦN THÊM ĐÔI PHẦN SẮC SẢO','00001',N'Mộ Nhan Ca', N'“Một người có thể sống cả đời theo cách mình thích là chuyện vô cùng khó khăn. Chúng ta không giây phút nào không bị thế giới bên ngoài chỉ trỏ, lâu dần sẽ quên mất tâm tư ban sơ, mất đi khả năng suy nghĩ độc lập và giữ vững cái tôi. So với từng câu từng câu an ủi dịu dàng, tôi nghĩ chúng ta cần một chậu nước lạnh hơn. Nó sẽ giúp chúng ta tỉnh táo ý thức được tính tình cáu bẳn của mình, tầm nhìn và lòng dạ hạn hẹp của mình, EQ thấp của mình, và tất cả những vấn đề mà bản thân chúng ta không nhìn rõ, nhưng người khác thấy rõ mồn một mà không muốn nói cho chúng ta biết. Khi bạn khốn đốn, hoang mang, nếu đọc được cuốn sách này, mong rằng bạn có thể rút ra sức mạnh từ trong câu chữ của nó, đừng nộp vũ khí đầu hàng thế giới này. [...] Đời người là một quá trình thử sai, trưởng thành cũng không ngoại lệ. Nên làm những gì, đi con đường nào, mỗi người đều tuân theo tiếng nói của nội tâm, dò dẫm từng bước một. Vấp ngã, thì bò dậy; va vỡ đầu, thì lùi lại; đi đường sai, thì quay lại; lạc lối, thì ngừng chân… Cuộc đời của mỗi người mỗi khác, ai ai cũng phải tự mình trải qua, mỗi người đều có bài học nhân sinh cần bản thân một mình hoàn thành. Bởi vì từng trải, cho nên thấu hiểu. Nguyện cho tất cả những người không hiểu và thấu hiểu trên đời không ngừng trưởng thành nhưng vẫn tốt bụng như xưa!”',
	84000,5,264,N'Hà Nội','2018-12-01');

insert into Book
values
	(N'MUA VÉ SỐ VÀO NGÀY NÀO THÌ DỄ TRÚNG?','00002',N'Tĩnh Phong', N'Bạn lại vừa phải trải qua một ngày thứ Hai điển hình… Buổi sáng bạn quên đun nước pha cà phê trước khi đánh răng, bạn ra khỏi nhà muộn hơn 5 phút so với mọi ngày và ôi thôi – kẹt xe! – Bạn đến công ty muộn mất 30 phút. Sau một ngày làm việc mệt mỏi, bạn tìm cách xả xì trét cho mình bằng cách đi shopping, khi ra về bạn bỗng ngước lên và bắt gặp một khuôn mặt hoàn toàn lạ lẫm nhưng lại đáng yêu nhất từng thấy trong đời đang đi ngược chiều. Sau một phút choáng váng, bạn chợt nhận ra là mình phải làm quen với “người ta” bằng mọi giá, khổ nỗi “người ta” đã ở rất xa theo hướng ngược lại của thang cuốn. Bạn hộc tốc chạy đuổi theo, nhưng vô ích, chẳng thấy đâu nữa rồi. Bạn về nhà, định bụng tắm nước nóng cho thoải mái, thế nhưng không tài nào điều chỉnh cho nước vòi sen có nhiệt độ dễ chịu được cả, chỉ có thể là bỏng rát hoặc lạnh toát.',
	76000,5,268,N'Thế giới','2018-11-30');

insert into Book
values
	(N'KẺ DỊ BIỆT TẠI TRƯỜNG HỌC PHÉP THUẬT 2','00003',N'Sato Tsutomu', N'Cuốn sách nên đọc',
	76000,5,268,N'Thế giới','2018-11-30');

insert into Book
values
	(N'THĂM THẲM MÙA HÈ','00004',N'Nguyễn Dương Quỳnh', N'Cô công chúa nhỏ ấy đã chết rồi. Tự sát ư? Xinh đẹp, thông minh, danh giá và một tương lai ngời ngời trước mặt, dường như cô chẳng có lý do gì để làm thế. Hay ai đã giết cô? Có thể lắm chứ, cha cô là một nhà chính trị và chắc hẳn không ít kẻ thù. Nhưng chẳng có gì trong những manh mối để lại cho thấy đó là một vụ giết người. Nguyên, Thụy, Nam Phong, mỗi người đều bị ám ảnh về cô theo những cách khác nhau, và đi tìm câu trả lời theo những cách khác nhau, để rồi đều nhận ra vị của trái táo xanh mùa hè năm nào, vị của thanh xuân, đã trở nên đắng ngắt. Với Thăm thẳm mùa hè, Nguyễn Dương Quỳnh lần đầu tiên thách thức mình với trinh thám, một thể loại gần như còn trống vắng trong văn học Việt. CÓ THỂ BẠN QUAN TÂM',
	92000,5,336,N'Hội nhà văn','2018-11-15');

insert into Book
values
	(N'TẮT ĐÈN','00005',N'Ngô Tất Tố', N'“Đánh ‘xoảng’ một cái, cái bát ở mâm lý cựu bay thẳng sang mâm lý đương. Và đánh ‘chát’ một cái, cái chậu ở chiếu lý đương cũng đập luôn vào cây cột bên cạnh lý cựu. Nước canh, nước mắm bắn ra tứ tung. Hết thảy mọi người đều lố nhố đứng dậy… Chánh tổng sực tan giấc mộng, ngơ ngác hỏi giật hỏi giọng: - Cái gì thế? Cái gì thế? Nốc cho lắm rồi nói bậy! Người nào gây chuyện với người nào?”',
	48000,5,231,N'Thế giới','2018-07-30');

insert into Book
values
	(N'LẶNG YÊN CHO NƯỚC CHẢY','00006',N'Mai Văn Phấn', N'“Chiều nay em cho con bú. Ngoài kia từng chân kiến đang đi, từng cánh ong vẫn còn đang vỗ. Nơi anh về trú ngụ là ô trời xanh trong mắt em cười. Hạnh phúc nào bằng ta bên nhau thảnh thơi, như được xoải mình nơi chân đê cát mịn. Anh hôn lên ngực em căng đầy thơm mát, chiều ngọt ngào cánh cò cánh vạc, qua môi anh khẽ đậu xuống hồn. Căn phòng mình chẳng còn những bức tường bao quanh và không gian thành thời gian thánh thiện, khi anh mải mê nhìn vầng ngực em dâng đầy như biển, cứ thu mình tìm vào miệng con be bé xinh xinh...” CÓ THỂ BẠN QUAN TÂM',
	56000,5,120,N'Hội nhà văn','2018-03-18');

insert into Book
values
	(N'KHÚC ĐẮM SAY TUYỆT VỌNG','00007',N'Camellia Dương', N'Một thiếu phụ trở về Việt Nam, mang theo trái tim tan nát vì cuộc hôn nhân đầu đời đổ vỡ. Vào thời điểm đau khổ nhất, cô tình cờ gặp một người bạn chơi game trên mạng xã hội, một người đàn ông xa lạ mà cô chưa từng biết ngoài đời. Ngọn lửa một lần nữa lại cháy lên trong trái tim đã vỡ, rực rỡ như chưa từng biết tới thương đau, ấm nóng như tình đầu si dại, không thể lý giải giống như số phận. Dù linh cảm nỗi đau sẽ là kết cục, trái tim mềm yếu của cô không chịu đầu hàng, nhất định đòi hoà nhịp yêu thương, cho dù có phải trả giá đắt cỡ nào đi nữa…',
	55200,5,132,N'Hội nhà văn','2018-03-12');

insert into Book
values
	(N'AI VÀ KY Ở XỨ SỞ NHỮNG CON SỐ TÀNG HÌNH (TÁI BẢN 2017)','00008',N'Ngô Bảo Châu và Nguyễn Phương Văn', N'“Cuốn sách là một câu chuyện cổ tích tuyệt đẹp, với nắng vàng trên bãi cát, với bầu không khí trong vắt của trí tuệ và tình người, với những nghịch lý và âm mưu. Ta chợt nhận ra rằng, thế giới của những con số cũng huyền ảo, kỳ bí và lãng mạn như cuộc đời.”',
	55000,5,176,N'Thế giới','2017-11-18');

insert into Book
values
	(N'NHỮNG NGÃ TƯ VÀ NHỮNG CỘT ĐÈN (GIẢI THƯỞNG HNV HÀ NỘI) - TÁI BẢN 2017','00009',N'Trần Dần', N'Tôi qua ngã tư Cửa Nam. Ngã tư Cửa Nam đầy khói. Để không thể đếm bao nhiêu nốt chân trên ngã tư. Ai đếm bao nhiêu nốt chân khôn dại. Bao nhiêu nốt chân vui buồn? Ai đếm những ngã tư đời láo nháo nốt chân. Láo nháo cột đèn láo nháo đèn? Đời tôi đã rẽ rồi. Như đã hạ nước cờ không sao đi lại được. Nhưng tại sao tôi cứ ám ảnh: cái ngã tư tại sao ấy. Tôi quên không được. Đi đi không được. Tôi ngồi bệt lề đường. Tôi là đàn ông: tôi không đau khổ. Nhưng tôi muốn khóc. Tôi là đàn ông: Tôi không khóc. Nhưng tôi đau khổ lắm. Tôi ngồi bệt mà nhìn láo nháo cột đèn. Láo nháo khói. Láo nháo hàng cây bên đường lá rụng. Tôi nghe gà gáy te te nội thành. Chỗ tôi ngồi không xa có vườn hoa Canh Nông. Tôi lảo đảo dậy: tôi đi tìm vườn hoa Canh Nông. Tôi vào vườn hoa. Tôi ngồi ghế đá. Ghế đá lạnh. Gà gáy te te. Phố bắt đầu mất khói. Vườn hoa cũng bắt đầu hết khói. Là rạng đông rồi. Tôi không mệt. Buồn ngủ cũng không. Tôi đã nói rồi: tôi đi thấu sáng. Bây giờ tôi ngồi. Cùng với rạng đông. Trong một vườn hoa.',
	54000,5,344,N'Hội nhà văn','2018-03-18');

insert into BookCategory
values 
	('00000','00000'),
	('00001','00000'),
	('00002','00000'),
	('00003','00000'),
	('00004','00000'),
	('00005','00000'),
	('00006','00000'),
	('00007','00000'),
	('00008','00000'),
	('00009','00000');

insert into Img
values
	('00000.jpg','00000'),
	('00001.jpg','00001'),
	('00002.jpg','00002'),
	('00003.jpg','00003'),
	('00004.jpg','00004'),
	('00005.jpg','00005'),
	('00006.jpg','00006'),
	('00007.jpg','00007'),
	('00008.jpg','00008'),
	('00009.jpg','00009');



--truyện ngắn

insert into Book
values
	(N'KÝ TÚC XÁ PHÒNG 307','00010',N'Zihua Nguyễn', N'“Thời sinh viên, trong tôi, ý nghĩ trở thành vĩ nhân luôn thường trực. Bill Gates, Steve Jobs, Mark Zuckerberg. Đặc điểm chung của các vĩ nhân là họ luôn bỏ ngang đại học. Suốt năm năm ngồi trên giảng đường, ý nghĩ “mình sẽ bỏ học” lóe lên trong đầu tôi 226 lần. Nhưng rốt cuộc, tôi không đi theo tiếng gọi của các vĩ nhân. Tôi hoàn thành 180 tín chỉ học phần. Tốt nghiệp đại học, cầm tấm bằng đỏ chót, rồi lao vào đời.” Những câu chuyện chân thực, hài hước, mang nhiều niềm vui xen lẫn những nỗi ngậm ngùi của những cậu sinh viên nghèo sống trong Ký túc xá phòng 307. Một cuốn sách dành tặng cho những ai đã-đang-và-sẽ là sinh viên.',
	55200,5,176,N'Hội nhà văn','2019-11-19');

insert into Book
values
	(N'VỀ NHÀ','00011',N'Phan Việt', N'Bắt đầu từ những bước chân bỡ ngỡ, háo hức nhưng cũng đơn côi, cô độc trong Một mình ở Châu Âu, tác giả, người phụ nữ kể chuyện, trong Xuyên Mỹ đã bươn chải qua nhiều chặng đường đầy nhọc nhằn, tâm trạng dọc ngang nước Mỹ. Với tập sách này, cô tiếp tục hành trình đa chiều, phức tạp, cả trong nội tâm lẫn giữa những dặm dài địa lý, sau những tổn thương và sợ hãi. Về nhà, với cách tường thuật cụ thể và trung thực tra vấn đến tận cùng, chính là tự truyện về một cá tính, một con người không mệt mỏi truy tìm nguyên nhân của hạnh phúc và bất hạnh, hòng nhìn thấy cái "chân bản lai diện mục" của chính mình, để lại bình an cất bước, sau bao nhiêu đau khổ, đổ vỡ, trên con đường "về nhà".',
	87000,5,399,N'Hội nhà văn','2018-04-13');

insert into Book
values
	(N'CÁI NỒI GÌ THẾ?','00012',N'Hoàng Nhật', N'Một gã nhân viên văn phòng quên mặc quần khi đi làm, một cô gái trúng thưởng chiếc nồi xịn xò của công ty vào đúng ngày Valentine, một nàng về làm dâu phố cổ nhà có cái toilet chưa đến ba mét vuông để vừa tắm vừa ị, cùng vô số những con người hài hước, đầy rẫy những chuyện ngớ ngẩn, hóa ra lại diễn ra đâu đó, ngay cạnh bạn, hoặc cũng có khi chính là bạn. Cuộc sống, như nhà triết học nào (hay một gã khốn nạn nào?) đã nói, là một nồi lẩu hải sản, và con người là những con tôm trong đó: chẳng thể chui ra khỏi nồi, chỉ có thể nhảy vòng quanh, sao cho mình không bị đẩy xuống đáy, cứ như vậy đến khi nước sôi và tất cả đều bị nấu chín. Đối mặt với cuộc sống cùn mòn, quẩn quanh, và đó lại là cuộc sống đô thị ngột ngạt của những người trẻ, câu đáp trả ngắn gọn nhất, dễ dãi nhất, bật ngay khỏi não và bắn ngay khỏi mồm, chắc sẽ là: “Cái nồi gì thế?!!”',
	70000,5,236,N'Hội nhà văn','2016-03-18');

insert into Book
values
	(N'CALIFORNIA UNIVERSITIES & COLLEGES VÀ NHỮNG ĐIỀU CẦN BIẾT KHI ĐI DU HỌC HOA KỲ','00013',N'Đỗ Hữu Tâm', '',
	68000,5,262,N'Thế giới','2019-10-12');

insert into Book
values
	(N'HÀ NỘI BĂM SÁU PHỐ PHƯỜNG','00014',N'Thạch Lam', N'“Có ai buổi trưa vắng hay buổi đêm khuya, đi qua các nhà cô đào, và các chị em thanh lâu, thấy họ ăn cái quà ấy một cách chăm chú và tha thiết đến đâu không? Nước ốc chua làm nhăn các nét mặt tàn phấn và mệt lả, miếng ớt cay làm xoa xuýt những cặp môi héo hắt, và khiến đôi khi rỏ những giọt lệ thật thà hơn cả những giọt lệ tình. Cô hàng ốc có một cái dụng cụ, một đầu là búa, một đầu là dùi nhọn. Một cái gõ nhẹ, và một cái trở tay, là con ốc nguyên cả ruột đã gọn gàng rơi mình vào bát nước. Cô thoăn thoắt rút ốc không kịp, trông thấy người ta ăn ngon lành, chính cô cũng sinh thèm.”',
	40000,5,124,N'Hội nhà văn','2019-04-04');

insert into Book
values
	(N'PHÉP TÍNH CỦA MỘT NHO SĨ','00015',N'Trần Vũ', N'Nhắc đến thành tựu truyện ngắn đương đại mà không kể đến Trần Vũ là một thiếu sót lớn. Đặc trưng của tác giả là những câu chữ hoặc đau đớn đến tan nát, hoặc táo bạo, lạnh lùng đến sắc rợn; các thủ pháp lạ hóa, biến đổi hiện thực, huyền ảo được tận dụng tối đa để khai phá mối tương quan giữa lịch sử, hiện thực, bạo lực và tình dục. Văn của Trần Vũ khước từ sự lưng chừng, mơ hồ, luôn đẩy sức căng đến những góc cạnh cực đoan nhất và tìm thấy con người hoặc ở nơi sâu thẳm, hoặc chốn man rợ khốn cùng.',
	68000,5,223,N'Hội nhà văn','2018-02-19');

insert into Book
values
	(N'CHUYỆN NGƯỜI TÂY Ở XỨ TA','00016',N'Nhiều tác giả', N'Qua những con chữ vừa chân thành và nồng nhiệt, vừa hài hước và suy tư, họ chia sẻ rất nhiều góc nhìn thú vị về con người, xã hội, đất nước Việt Nam, bày tỏ nỗi trăn trở về bản ngã, sự khó khăn khi học tập và lập nghiệp ở một đất nước xa lạ, những nỗi đau quá khứ và niềm tin ở hiện tại, sự hứng khởi trước bao điều mới mẻ, và niềm hạnh phúc khi tìm thấy tình yêu…',
	70000,5,267,N'Hội nhà văn','2019-02-19');

insert into Book
values
	(N'CON LÀ KHÁCH QUÝ','00017',N'Cẩm Nhung', N'“Đây là một cuốn sách hấp dẫn và bổ ích, nhất là những thông tin về chăm sóc sức khỏe hay ăn uống cho bé. Tôi  nghĩ đây sẽ là một cuốn sách có ích cho các ông bố bà mẹ, và nhất là cho các ông bà nội ngoại của các em bé. Trên hết, cuốn sách sẽ rất cần cho các bác sỹ nhi khoa (và cả sản khoa) ở Việt Nam đọc để thay đổi cách suy nghĩ  và tư vấn cho các ông bố bà mẹ ở Việt Nam.”',
	68000,5,302,N'Thế Giới','2018-12-13');

insert into Book
values
	(N'CỬA SỔ HÌNH TIA CHỚP','00018',N'Võ Diệu Thanh', N'Trở lại với tập truyện ngắn Cửa sổ hình tia chớp, Võ Diệu Thanh cho thấy mình vẫn là một trong những nhà văn nữ có sức viết mạnh mẽ nhất hiện nay. Những con người dung dị ở miền Tây hiện rõ nét trên từng trang viết: một cô giáo tỉnh lẻ lo sợ trộm ở dãy nhà công vụ, một phụ nữ bị nhục hình thời chiến bước vào thời bình với nỗi đau không nói nên lời, một người đàn ông tự nhận là Khmer đỏ có gia đình chín người đều thiệt mạng… Hàng loạt thân phận lạc lõng giữa những dòng sông, những chuyến phà, trôi qua vô số mất mát cuộc đời chỉ để tìm kiếm sự bình yên. Miền Tây của Võ Diệu Thanh là một miền Tây rất khác.',
	56000,5,184,N'Hội nhà văn','2018-12-03');

insert into Book
values
	(N'MỘT BUỔI SÁNG KHÓ QUÊN VÀ NHỮNG BẢN TÌNH CA DANG DỞ','00019',N'Ngô Hữu Long , Nguyễn Thùy Trâm', N'17 truyện ngắn là 17 cảnh huống oái oăm, hài hước: một nữ nhà báo sẽ làm gì khi đột nhiên biết rằng chỉ một tiếng nữa thành phố cô đang sống sẽ bị phá hủy?; một anh chàng xa vợ muốn chỉn chu trong mắt đồng nghiệp nên đã vì mấy chiếc cúc bị đứt mà thành ra ngoại tình; một tay trộm tranh lại nẫng được cả bà chủ nhà hay chính hắn đã bị nẫng?; một con mèo đã giúp phát hiện một vụ ngoại tình;… Tiếng cười bật ra một cách bất ngờ nhờ lối viết dửng dưng, bình đạm của nhà văn - nhưng chất chứa sau những mỉa mai ấy là những suy nghĩ, dằn vặt của một cây bút bậc thầy.',
	63000,5,248,N'Văn học','2018-10-25');



insert into BookCategory
values 
	('00010','00001'),
	('00011','00001'),
	('00012','00001'),
	('00013','00001'),
	('00014','00001'),
	('00015','00001'),
	('00016','00001'),
	('00017','00001'),
	('00018','00001'),
	('00019','00001');

insert into Img
values
	('00010.jpg','00010'),
	('00011.jpg','00011'),
	('00012.jpg','00012'),
	('00013.jpg','00013'),
	('00014.jpg','00014'),
	('00015.jpg','00015'),
	('00016.jpg','00016'),
	('00017.jpg','00017'),
	('00018.jpg','00018'),
	('00019.jpg','00019');

--thơ
insert into Book
values
	(N'MAMA- MẸ','00020',N'Hélène Delforge Quentin Greban', N'MẸ là ai? Là tiếng gọi đầu tiên trên đôi môi hầu như mọi đứa trẻ. Là tên chung cho hàng tỉ phụ nữ trên thế giới này. Là người nói với ta những lời yêu thương, khiến ta nghĩ đến sự dịu dàng, mối ràng buộc ruột thịt, sự nhung nhớ và những hy sinh lặng thầm. Ở mỗi thời đại, mỗi xứ sở, mỗi gia đình, những người phụ nữ thật khác nhau biết mấy, nhưng khi ôm đứa con thơ trong lòng, tất cả họ đều giống nhau, bởi họ đều là MẸ.',
	86000,5,68,N'Hội nhà văn','2019-04-19');

insert into Book
values
	(N'BỆNH VẢY NẾN NƠI VĨNH HẰNG','00021',N'Trần Trọng Vũ', N'Bệnh vẩy nến nơi vĩnh hằng, xuất bản tại Pháp năm 2011 bởi Nhà xuất bản Rafael de Surtis, gồm 785 bài thơ độc lập, nhưng tập hợp của chúng lại tạo dựng nên một bức tranh toàn cảnh của một cuộc đời, mà ở đấy có các nhân vật chính, có dàn nhân vật phụ, có phong cảnh lớn, có bối cảnh nhỏ một căn phòng. Có thể đọc chúng như một cuốn truyện dài cảm động, thông qua những con số vô cảm.',
	76000,5,244,N'Hội nhà văn','2018-11-18');

insert into Book
values
	(N'TA CÒN EM','00022',N'Phan Vũ', N'“Ta còn em Cổ Ngư, tên thật cũ Nắng chiều phai La đà cành phượng vĩ Bông hoa muộn in hình ngọn lửa… Chiếc lá rụng Khởi đầu nguồn gió Lao xao sóng biếc Tây Hồ Hoàng hôn xa đến tự bao giờ? Những bước chân tìm nhau Vồi vội Tiếng thì thầm đến sớm hơn buổi tối Cuộc tình hờ bỗng chốc nghiêm trang…”',
	56000,5,172,N'Hội nhà văn','2018-05-02');

insert into Book
values
	(N'THƠ DƯƠNG TƯỜNG','00023',N'Dương Tường', N'"Chiều se sẽ hương Vườn se sẽ vương Đường se sẽ quạnh Trời se sẽ lạnh Người se sẽ buồn"',
	86000,5,234,N'Hội nhà văn','2017-08-16');

insert into Book
values
	(N'SỰ ĐÃ RỒI ANH NGỒI ANH HÁT','00024',N'LU', N'“cho tôi về lại dốc Khâm Thiên đường ray xe lửa cây xăng giấu mình một nửa đầy bình lượn phố thâu đêm”',
	52000,5,168,N'Hội nhà văn','2017-03-28');

insert into Book
values
	(N'ĐƯỜI ƯƠI CHÂN KINH','00025','Bùi Giáng', N'Đười Ươi Chân Kinh là tinh tuyển đầu tiên của Bùi Giáng, được tuyển chọn từ kho tác phẩm đồ sộ đã xuất bản của ông, trong đó có một số tác phẩm từ lâu đã tuyệt bản. Cuốn tinh tuyển này là nơi bạn có thể yên tâm lật giở để thưởng thức “đười ươi thi sĩ”, tức Bùi Giáng, một huyền-thoại-sống đúng nghĩa.',
	100000,5,536,N'Hội nhà văn','2016-06-30');

insert into Book
values
	(N'XEM ĐÊM','00026',N'Phùng Cung', N'"Thơ Phùng Cung tích lũy trong thầm lặng khắc kỷ đã phải nằm chờ hơn hai mươi năm dưới lớp bụi thờ ơ, như Hằng Nga ngủ trong rừng, chưa có Hoàng tử đẹp trai đến đánh thức... Ông là một cây bút vốn bị hoàn cảnh không bình thường kìm hãm, đang giành lại chỗ đứng dưới mặt trời."',
	54000,5,222,N'Hội nhà văn','2016-06-30');

insert into Book
values
	(N'ĐÀN BÀ ĐO HẠNH PHÚC TRONG QUANH QUẨN ĐÀN ÔNG','00027',N'Thái Thuận Minh', N'“Anh - hoàng tử bạch mã - đẹp trai - tốt bụng - tiền nhiều Em - cô gái lọ lem nghèo bước ra từ cổ tích Theo như sách, thì mình đã yêu nhau đến nghiêng ngả hoàng hôn u tịch Theo như đời, Em tự mặc lại xiêm y thấy mình chẳng còn gì ngoài cơn động dục Em vội hóa màn đêm tự làm nhục chính mình...”',
	54000,5,132,N'Hội nhà văn','2016-04-21');

insert into Book
values
	(N'MƯỜI HAI BẾN NƯỚC','00028',N'Nguyễn Bính', N'Đáng để đọc',
	39000,5,65,N'Hội nhà văn','2016-04-13');


insert into Book
values
	(N'THƠ SAY','00029',N'Vũ Hoàng Chương', N'"Cổ chưa khô, đầu chưa nặng, mắt chưa hoa, Tay mềm mại, bước còn chưa chếnh choáng. Chưa cuối Mê ly, chưa cùng trời Phóng đãng Còn chưa say, hồ khát vẫn thèm men".',
	47000,5,93,N'Hội nhà văn','2016-04-13');

insert into BookCategory
values 
	('00020','00002'),
	('00021','00002'),
	('00022','00002'),
	('00023','00002'),
	('00024','00002'),
	('00025','00002'),
	('00026','00002'),
	('00027','00002'),
	('00028','00002'),
	('00029','00002');

insert into Img
values
	('00020.jpg','00020'),
	('00021.jpg','00021'),
	('00022.jpg','00022'),
	('00023.jpg','00023'),
	('00024.jpg','00024'),
	('00025.jpg','00025'),
	('00026.jpg','00026'),
	('00027.jpg','00027'),
	('00028.jpg','00028'),
	('00029.jpg','00029');

--trinh thám

insert into Book
values
	(N'BẠCH DẠ HÀNH (TB 2021)','00030',N'Higashino Keigo', N'Osuke, chủ một tiệm cầm đồ bị sát hại tại một ngôi nhà chưa hoàn công, một triệu yên mang theo người cũng bị cướp mất. Sau đó một tháng, nghi can Fumiyo được cho rằng có quan hệ tình ái với nạn nhân và đã sát hại ông để cướp một triệu yên, cũng chết tại nhà riêng vì ngộ độc khí ga. Vụ án mạng ông chủ tiệm cầm đồ rơi vào bế tắc và bị bỏ xó. Nhưng với hai đứa trẻ mười một tuổi, con trai nạn nhân và con gái nghi can, vụ án mạng năm ấy chưa bao giờ kết thúc. Sinh tồn và trưởng thành dưới bóng đen cái chết của bố mẹ, cho đến cuối đời, Ryoji vẫn luôn khao khát được một lần đi dưới ánh mặt trời, còn Yukiho cứ ra sức vẫy vùng rồi mãi mãi chìm vào đêm trắng.',
	167000,5,628,N'Hội nhà văn','2021-06-30');

insert into Book
values
	(N'CUỘC ĐỜI LÀ MỘT TIỂU THUYẾT','00031',N'Guillaume Musso', N'Với anh, mọi thứ đã được viết sẵn Với cô, mọi thứ đang đợi viết tiếp “Sáu tháng trước, ngày 12 tháng Tư năm 2010, con gái ba tuổi của tôi, Carrie Conway, đã bị bắt cóc trong lúc hai mẹ con đang chơi trốn tìm trong căn hộ nhà mình ở Williamsburg.” Câu chuyện của Flora Conway, nữ tiểu thuyết gia nổi tiếng sống kín đáo, đã bắt đầu như thế. Carrie đột ngột mất tích, không cách nào lý giải được. Cửa chính và các cửa sổ đều đóng kín, các camera giám sát trong tòa nhà không phát hiện điều khả nghi nào. Cuộc điều tra của cảnh sát không mang lại kết quả gì. Cùng thời điểm ấy, ở bờ kia Đại Tây Dương, một nhà văn với trái tim tan nát trốn tránh xã hội trong một ngôi nhà xập xệ, bế tắc với tiểu thuyết đang viết dở. Anh là người duy nhất nắm giữ chìa khóa của bí ẩn. Và Flora sẽ đánh bật anh.',
	112000,5,268,N'Hội nhà văn','2021-01-12');

insert into Book
values
	(N'SA MÔN KHÔNG HẢI THẾT YẾN BẦY QUỶ ĐẠI ĐƯỜNG TẬP 4','00032',N' Yumemakura Baku', N'Bức thư mà thái giám Cao Lực Sĩ để lại cho A Bội Trọng Ma Lữ ngay trước khi qua đời chứa đựng một sự thật khủng khiếp liên quan đến xuất thân của Dương quý phi. Thuận Tông hoàng đế hấp hối trên giường bệnh vì bùa phép và lời nguyền rủa của Bạch Long. Giang sơn Đại Đường như trứng để đầu đẳng... Để vạch trần chân tướng của lời nguyền và khép lại mọi chuyện, Không Hải dẫn theo Dật Thế, Bạch Lạc Thiên, nhiều nhạc sĩ và đầu bếp, đi đến Hoa Thanh Cung ở Ly Sơn - nơi liên quan tới Huyền Tông hoàng đế và Dương quý phi – và tái hiện lại buổi tiệc năm mươi năm trước...',
	112000,5,388,N'Hội nhà văn','2020-11-24');

insert into Book
values
	(N'CHÚC MẸ NGỦ NGON','00033',N'Mi-ae Seo', N'Cuộc sống vốn yên ả của nhà tâm lý học tội phạm Lee Sun Kyung bỗng chốc lệch quỹ đạo khi hai biến cố bất ngờ và bất thường cùng lúc ập tới. Vào ngày Sun Kyung nhận nhiệm vụ phỏng vấn một tên tội phạm giết người hàng loạt, chồng cô dẫn về nhà con gái riêng mười một tuổi, nạn nhân sống sót duy nhất trong vụ hỏa hoạn cướp đi mạng sống tất cả người thân trong gia đình cô bé.',
	116000,5,396,N'Hà Nội','2020-11-10');

insert into Book
values
	(N'SA MÔN KHÔNG HẢI THẾT YẾN BẦY QUỶ ĐẠI ĐƯỜNG TẬP 3','00034',N'Yumemakura Baku', N'Từ lá thư mà A Bội Trọng Ma Lữ để lại, nhóm Không Hải biết được một sự thật. Đó là, khi hoàng đế Huyền Tông buộc phải xử tử Dương quý phi, ngài đã làm theo mưu kế của đạo sĩ Hoàng Hạc, thực hiện phép thi giải đưa Quý phi vào trạng thái chết giả để đợi hồi sinh, nhưng thật không may, họ đã thất bại. Cùng lúc ấy, Bạch Long, đệ tử cũ của Hoàng Hạc xuất hiện. Bạch Long nguyền rủa hoàng đế Thuận Tông, tìm cách hủy diệt cả triều đại nhà Đường. Chỉ còn chút sức tàn, Huệ Quả của Thanh Long Tự phải đứng ra đấu với Bạch Long, cứu hoàng đế, giải nguy cho vương triều...',
	112000,5,376,N'Hội nhà văn','2020-10-09');

insert into Book
values
	(N'TRÁI TIM CỦA BRUTUS','00035',N'Higashino Keigo', N'Suenaga Takuya đảm trách phát triển robot sử dụng trí thông minh nhân tạo ở công ty Công nghiệp nặng MM. Là một gã trai sáng giá, đầy hứa hẹn tương lai, y trở thành “ứng cử viên” chức hôn phu của Hoshiko – con gái út ông chủ. Vì thế, khi người tình Yasuko bắt đầu thai nghén đứa con của gã, Takuya hoang mang. Cùng với Naoki – anh trai cùng cha khác mẹ của Hoshiko, và Hashimoto – đồng nghiệp ở công ty, y quyết định vạch ra một kế hoạch giết người…',
	110000,5,628,N'Hà Nội','2020-09-11');

insert into Book
values
	(N'CẢNH NGỘ','00036',N'Minato Kanae', N'Cùng chia sẻ cảnh ngộ được trại trẻ mồ côi nhận nuôi từ khi vừa lọt lòng mẹ, Takakura Yoko – phu nhân một chính trị gia, và nữ nhà báo Aida Harumi trở thành đôi bạn thân gắn bó với nhau sâu sắc. Bước ngoặt xảy ra khi cuốn sách tranh Ruy băng trên trời xanh mà Yoko vẽ tặng con trai Yuta dựa trên câu chuyện đời của Harumi bất ngờ đoạt giải thưởng lớn tầm cỡ và trở thành sách bán chạy. Một thời gian ngắn sau đó, Yuta mất tích. Lá thư đe dọa gửi về văn phòng Takakura có đoạn: “Nếu muốn thằng bé trở về bình an vô sự, hãy công khai sự thật cho mọi người biết”. “Sự thật” đó rốt cuộc là gì? Và ai là hung thủ đã bắt cóc Yuta?',
	94000,5,284,N'Hội nhà văn','2020-07-16');

insert into Book
values
	(N'HANNIBAL TRỖI DẬY','00037',N'Thomas Harris', N'Hannibal Trỗi dậy “Một tuyệt phẩm của máu và bạo lực nơi những nỗi kinh hoàng của chiến tranh được miêu tả một cách đẹp đẽ, nếu có thể dùng từ đó, khi Hannibal buộc phải trở thành kẻ ăn thịt người mà sau này sẽ trở thành thương hiệu của hắn.”-',
	110000,5,312,N'Hội nhà văn','2020-05-11');

insert into Book
values
	(N'SA MÔN KHÔNG HẢI THẾT YẾN BẦY QUỶ ĐẠI ĐƯỜNG TẬP 2','00038',N'Yumemakura Baku', N'Lần theo manh mối từ tập một, Không Hải bắt tay vào điều tra từ bài ca mà người vợ bị mèo ám của nhà họ Lưu hát. Biết được đó là bài thơ khoảng 60 năm trước khi tiên Lý Bạch đã làm để ngợi ca vẻ đẹp của Dương Quý Phi sủng phi của Đường Huyền Tông, Không Hải và Dật Thế đã cùng Bạch Lạc Thiên - người bạn tình cờ quen biết, sau này sẽ trở thành đại thi hào - đi đến Mã Ngôi Dịch đào mộ của Dương Quý Phi. Kỳ lạ thay, ngôi mộ đã bị ếm bởi những lời nguyền ma quái, hơn nữa, thi hài Quý phi hoàn toàn không có trong quan tài..',
	112000,5,404,N'Hội nhà văn','2020-05-04');

insert into Book
values
	(N'KHÔNG TRỞ LẠI','00039',N'Lee Child', N'Từ Nam Dakota tuyết trắng, Jack Reacher đã vượt qua cả quãng đường dài để đến Tây Bắc Virginia, gần Thủ đô Washington: trụ sở chính của Đội Đặc nhiệm 110, đơn vị anh từng chỉ huy. Anh lặn lội chỉ vì một mục đích: gặp mặt chỉ huy mới của Đội 110, Susan Turner. Nhưng chờ anh trong phòng chỉ huy không phải là Turner. Đột nhiên, chuyến về thăm đơn vị cũ bỗng chốc trở thành một cuộc chạy đua, với thời gian, với quân đội, FBI, cảnh sát Thủ đô và với bốn gã côn đồ không rõ danh tính, vừa để giải cứu Susan Turner và chính anh, đồng thời làm sáng tỏ một bí ẩn từ quá khứ.',
	141000,5,460,N'Hội nhà văn','2020-03-19');

insert into BookCategory
values 
	('00030','00003'),
	('00031','00003'),
	('00032','00003'),
	('00033','00003'),
	('00034','00003'),
	('00035','00003'),
	('00036','00003'),
	('00037','00003'),
	('00038','00003'),
	('00039','00003');

insert into Img
values
	('00030.jpg','00030'),
	('00031.jpg','00031'),
	('00032.jpg','00032'),
	('00033.jpg','00033'),
	('00034.jpg','00034'),
	('00035.jpg','00035'),
	('00036.jpg','00036'),
	('00037.jpg','00037'),
	('00038.jpg','00038'),
	('00039.jpg','00039');

--truyện tranh
insert into Book
values
	(N'THẮC MẮC NHỎ, NGỎ CÙNG EM- TÌNH YÊU VÀ TÌNH BẠN','00040',N'Astrid Dumontet , Julie Faulques', N'Thắc mắc nhỏ, ngỏ cùng em là bộ sách đến từ nước Pháp, dành cho trẻ từ 6 tuổi trở lên. Sách giải đáp cho những câu hỏi vừa ngây thơ, vừa hóc búa của các em theo cách cơ bản, dễ hiểu cùng minh họa sinh động. Bộ sách giúp các bé bước đầu khám phá những điều thú vị về cuộc sống, từ các khái niệm như Tốt và xầu; Chiến tranh và hòa bình; Giàu và nghèo cho tới các chủ đề gần gũi hơn như các cung bậc cảm xúc, tình cảm, tìm hiểu về giới tính và hệ bài tiết trong cơ thể. Đây là bộ sách rất lớn với gần 100 tựa sách của tập đoàn xuất bản Bayard Milan của Pháp, mỗi cuốn đều được viết và tư vấn bởi các chuyên gia giáo dục, cũng như chuyên gia trong các lĩnh vực mà cuốn sách nhắc đến.',
	39000,5,36,N'Hội nhà văn','2020-06-10');

insert into Book
values
	(N'KẺ DỊ BIỆT TẠI TRƯỜNG HỌC PHÉP THUẬT 5','00041',N'Sato Tsutomu', N'Kẻ dị biệt, tập đặc biệt, bao gồm những mẩu truyện ngắn chưa từng đăng tải trên mạng, hé lộ những sự kiện bất ngờ trong cuộc sống của các học sinh trường phép thuật. “Kỳ nghỉ hè” - Tatsuya cùng bạn bè đến thăm biệt thự nhà Shizuku. Trong khi cả bọn đang thư giãn tại khu nghỉ dưỡng sang trọng, thì Honoka - người đang thầm yêu Tatsuya - đã đưa ra một quyết định quan trọng...!? “Tình bạn, lòng tin và nghi vấn lolicon” - Ichijou Masaki là tộc trưởng đời tiếp theo của nhà Ichijou trong Thập Sư Tộc. Bí mật của cậu ta cùng với người bạn thân Kichijouji là gì? “Ký ức ngày hè” - Tatsuya và Miyuki cùng vào thành phố mua sắm. Trái tim Miyuki đập rộn ràng trước tình huống chẳng khác gì hẹn hò này, tuy nhiên... “Nữ hoàng và kỳ bầu cử hội trưởng” - Mayumi, vốn là học sinh năm ba, sắp phải rời khỏi vị trí hội trưởng Hội học sinh. Và cô đã chọn ra người sẽ thế chỗ mình...',
	108000,5,476,N'Hội nhà văn','2019-09-23');

insert into Book
values
	(N'PIKALONG – LONG YÊU VIỆT NAM','00042',N'Thăng Fly Comics', N'Đáng để đọc',
	60000,5,136,N'Hội nhà văn','2020-03-19');

insert into Book
values
	(N'NHỮNG NGƯỜI BẠN NGỘ NGHĨNH - MỘT NGÔI NHÀ VÀ MỘT VIÊN GẠCH','00043',N'Băng Ba', N'Bộ truyện tranh đồng thoại gồm 6 cuốn là sáu câu chuyện về các loài vật nhỏ đáng yêu trong rừng được minh họa sinh động với nét vẽ tay, mang lại cho các bạn nhỏ những câu chuyện cảm động và bổ ích về tình bạn, lòng trung thực, tinh thần chăm chỉ yêu lao động.',
	22000,5,28,N'Hội nhà văn','2019-07-31');

insert into Book
values
	(N'CẨM NANG BẰNG TRANH DẠY KỸ NĂNG ỨNG XỬ','00044',N'Lời Yokoyama Hiroyuki, tranh Akano Miru', N'Đáng để đọc',
	68000,5,144,N'Hội nhà văn','2020-03-19');

insert into Book
values
	(N'KHÓ KHĂN NHƯ CHĂN MÈO','00045',N'Sarah Andersen', N'Cuộc sống của một họa sĩ biếm họa nổi tiếng thế giới không dễ dàng tẹo nào. Những deadline dày đặc, hàng đống giấy gói đồ ăn nhanh lăn lóc dưới màn hình máy tính sáng xanh, và đàn thú nuôi gia tăng đến chóng mặt… ừmm, à không, thực ra vẫn từng ấy con mà thôi.',
	55000,5,112,N'Hội nhà văn','2019-07-17');

insert into Book
values
	(N'NHỮNG CÂU CHUYỆN ĐƯỢC YÊU THÍCH NHẤT TRONG KINH THÁNH','00046',N'Heather Amery kể lại Mandy Field và Maria Pearson minh họa', N'',
	110000,5,156,N'Thế Giới','2019-03-09');

insert into Book
values
	(N'NHỮNG NGƯỜI BẠN NGỘ NGHĨNH - SƯ TỬ HÓA TO HÓA NHỎ','00047',N'Hoàng Thu Hằng', N'Bộ truyện tranh đồng thoại gồm 6 cuốn là sáu câu chuyện về các loài vật nhỏ đáng yêu trong rừng được minh họa sinh động với nét vẽ tay, mang lại cho các bạn nhỏ những câu chuyện cảm động và bổ ích về tình bạn, lòng trung thực, tinh thần chăm chỉ yêu lao động.',
	22000,5,28,N'Hội nhà văn','2019-07-09');

insert into Book
values
	(N'NHỮNG NGƯỜI BẠN NGỘ NGHĨNH - CĂN NHÀ BIẾT ĐI','00048',N'Băng Ba', N'Bộ truyện tranh đồng thoại gồm 6 cuốn là sáu câu chuyện về các loài vật nhỏ đáng yêu trong rừng được minh họa sinh động với nét vẽ tay, mang lại cho các bạn nhỏ những câu chuyện cảm động và bổ ích về tình bạn, lòng trung thực, tinh thần chăm chỉ yêu lao động.',
	22000,5,28,N'Hội nhà văn','2019-07-09');

insert into Book
values
	(N'NHỮNG NGƯỜI BẠN NGỘ NGHĨNH - HỔ CON MÔNG TO','00049',N' Băng Ba', N'Bộ truyện tranh đồng thoại gồm 6 cuốn là sáu câu chuyện về các loài vật nhỏ đáng yêu trong rừng được minh họa sinh động với nét vẽ tay, mang lại cho các bạn nhỏ những câu chuyện cảm động và bổ ích về tình bạn, lòng trung thực, tinh thần chăm chỉ yêu lao động.',
	22000,5,28,N'Hội nhà văn','2019-07-09');



insert into BookCategory
values 
	('00040','00004'),
	('00041','00004'),
	('00042','00004'),
	('00043','00004'),
	('00044','00004'),
	('00045','00004'),
	('00046','00004'),
	('00047','00004'),
	('00048','00004'),
	('00049','00004');

insert into Img
values
	('00040.jpg','00040'),
	('00041.jpg','00041'),
	('00042.jpg','00042'),
	('00043.jpg','00043'),
	('00044.jpg','00044'),
	('00045.jpg','00045'),
	('00046.jpg','00046'),
	('00047.jpg','00047'),
	('00048.jpg','00048'),
	('00049.jpg','00049');

--lich sử

insert into Book
values
	(N'LỊCH TRIỀU TẠP KỶ','00050',N'Cao Lãng biên soạn , Xiển Trai bổ sung', N'Lịch triều tạp kỷ do Cao Lãng biên soạn, Xiển Trai con trai tác giả bổ sung, là một cuốn sử ghi chép khá toàn diện về giai đoạn lịch sử cuối thời Lê-Trịnh. Trong khoảng thời gian kéo dài hơn 100 năm, từ Lê Gia Tông năm Dương Đức thứ nhất (1672) đến Lê Mẫn đế năm Chiêu Thống thứ tư (1789), hầu hết các phương diện trong đời sống chính trị, xã hội ở Đàng ngoài đều được tác giả ghi nhận, từ các pháp lệnh được ban ra ở chính quyền trung ương, trong đó có vai trò chủ đạo của phủ chúa, đến các hoạt động của quan quân và dân chúng ở địa phương. Các sự kiện chính trị, kinh tế, văn hóa, giáo dục, quân sự được ghi chép một cách khá đầy đủ, kỹ lưỡng và sinh động.',
	188000,5,604,N'Hội nhà văn','2021-04-12');

insert into Book
values
	(N'CHUYỆN PHIẾM SỬ HỌC - BÌA CỨNG','00051',N'Tạ Chí Đại Trường', N'“Tạ Chí Đại Trường là một nhà sử học có tính độc lập và phong cách riêng trong nghiên cứu lịch sử. Ông có những công trình nghiên cứu sâu sắc trên phương pháp luận sử học nghiêm túc mà tiêu biểu là Lịch sử nội chiến Việt Nam từ 1771 đến 1802. Các tác phẩm của Tạ Chí Đại Trường mang nặng tính suy ngẫm lịch sử, gần như một thứ triết lý lịch sử, như Những bài dã sử Việt, hay Thần, người và đất Việt. Tạ Chí Đại Trường luôn nhìn lịch sử Việt Nam với tấm lòng của một con người Việt Nam.”',
	96000,5,284,N'Tri Thức','2021-04-06');

insert into Book
values
	(N'ĐẠI NAM DẬT SỰ VÀ SỬ TA SO VỚI SỬ TÀU','00052',N'Ứng Hòe Nguyễn Văn Tố', N'Đại Nam dật sự và Sử ta so với sử Tàu là tập hợp hai chuyên luận sử học tiêu biểu của học giả Nguyễn Văn Tố. Với hai công trình này, không quá lời để nói Nguyễn Văn Tố là nhà sử học đầu tiên đặt nền móng cho bộ môn sử liệu học ở Việt Nam thời hiện đại.',
	108000,5,490,N'Hội nhà văn','2020-03-19');

insert into Book
values
	(N'KINH TẾ VÀ XÃ HỘI VIỆT NAM DƯỚI CÁC VUA TRIỀU NGUYỄN','00053',N'Nguyễn Thế Anh', N'Ra đời trong những năm 60-70 của thế kỷ XX, thời điểm các sử gia vẫn dành nhiều mối quan tâm đến diễn biến chính trị qua các triều đại lịch sử, những sự kiện xoay quanh các nhân vật nổi tiếng như hoàng đế của các triều đại, mà thực sự đánh giá đúng mức tới các vấn đề kinh tế và xã hội cũng như đến chính người dân thường trong cuộc sống hằng ngày của họ, cuốn sách Kinh tế và xã hội Việt Nam dưới các vua triều Nguyễn được xem như tác phẩm tiên phong tiếp cận vấn đề kinh tế và xã hội trong nghiên cứu sử học.',
	110000,5,460,N'Hội nhà văn','2019-11-29');

insert into Book
values
	(N'VIỆT NAM PHONG TỤC (TB 2019)','00054',N'Phan Kế Bính', N'Giới thiệu sách
Từ Phong tục trong gia tộc, Phong tục xóm làng (hương đảng) đến các phong tục ngoài xã hội, VIỆT NAM PHONG TỤC của học giả PHAN KẾ BÍNH là một bộ biên khảo tương đối đầy đủ về các phong tục tập quán cũ của nước Việt. Là một nhà nho uyên bác mang tư tưởng tân tiến, tác giả không chỉ mô tả từng tập tục, mà còn về gốc tích, nguyên ủy cái tục ấy, nhìn nhận, đánh giá để xem nó hay hay dở, từ đó "xét điều gì quá tệ mà bỏ bớt đi, rồi lâu lâu mới đem cái tục hay mà bổ hết cho cái tục dở. Còn tục gì hay mà là quốc túy của ta thì cứ giữ lấy". Đến nay, tập sách gần một trăm năm tuổi này vẫn là một trong những công trình khảo cứu có giá trị bậc nhất về các phong tục tập quán trên đất nước ta và nhiều vấn đề được PHAN KẾ BÍNH nhắc tới vẫn nóng hổi tính thời đại.',
	72000,5,306,N'Hồng Đức','2019-08-12');

insert into Book
values
	(N'NHO GIÁO','00055',N'Trần Trọng Kim', N'Nho giáo của Trần Trọng Kim là một trong những bộ sách đầu tiên ở Việt Nam thời hiện đại nghiên cứu về Nho giáo Trung Hoa và những ảnh hưởng lớn lao của nó đến đời sống văn hóa Việt Nam. Không giấu giếm niềm ngưỡng mộ đối với một học thuyết từng là bệ đỡ tinh thần cho nhiều dân tộc Á Đông suốt hàng nghìn năm, Trần Trọng Kim đã tổng thuật và chứng minh tính hoàn chỉnh của một hệ thống triết học ở Nho giáo. Bằng phương pháp làm việc cẩn chỉ và nghiêm túc, Trần Trọng Kim đã đứng vững trên tư cách một nhà khoa học để thăm dò, miêu tả học thuyết phức tạp này, kể từ thời điểm nó ra đời, qua quá trình phái sinh, mở rộng bởi vô số học phái ở nhiều thời kỳ khác nhau, cho đến khi nó suy tàn vào đầu thế kỷ XX. Với việc cung cấp lượng tri thức uyên bác, khả tín, và bằng một văn phong giản dị, kết cấu mạch lạc, bộ sách của Lệ Thần Trần Trọng Kim là một công trình khảo cứu quyền uy và được tham khảo rộng rãi trong các nghiên cứu về Nho giáo ở Việt Nam.',
	156000,5,620,N'Thế Giới','2019-07-30');

insert into Book
values
	(N'BẮC KỲ TẠP LỤC','00056',N'Phạm Văn Tuân', N'“Sẽ hữu ích hơn cho xã hội nếu chúng tôi mang đến cho độc giả […] chiếc chìa khóa giúp họ len lỏi vào các ngóc ngách trong đời sống tinh thần của người An Nam, bằng cách lĩnh hội và thẩm thấu nhanh chóng những tập tục của họ. Việc len lỏi và thẩm thấu này chính là thứ vũ khí giúp độc giả chiến đấu, trên địa bàn của chính mình, với giới nho sĩ uyên bác, và trên hết, là bí quyết để yêu dân tộc này bằng cách hiểu họ nhiều hơn.”',
	159000,5,518,N'Hội nhà văn','2019-06-11');

insert into Book
values
	(N'CỔ HỌC TINH HOA (TB 2019)','00057',N'Ôn Như Nguyễn Văn Ngoc - Tử An Trần Lê Nhân', N'Một ông lão ở gần cửa ải có con ngựa tự nhiên đi sang nước Hồ mất. Người quen kẻ thuộc đều đến hỏi thăm. Ông lão nói: “Mất ngựa thế mà phúc cho tôi đấy biết đâu!”',
	76000,5,302,N'Hội nhà văn','2020-01-22');

insert into Book
values
	(N'VIỆT NAM SỬ LƯỢC','00058',N'Trần Trọng Kim', N'Cái nghĩa vụ làm sử, tưởng nên kê cứu cho tường tận, rồi cứ sự thực mà nổi, chứ không nên lấy lòng yêu ghét của mình mà xét đoán. Dẫu người mình ghét mà có làm điều phải, mình cũng phải khen; người mình yêu mà có làm điều trái, mình cũng phải chê"',
	103000,5,531,N'Văn học','2018-12-27');

insert into Book
values
	(N'VĂN MINH VIỆT NAM','00059',N'Đỗ Trọng Quang', N'Cuốn sách này có một đời sống riêng đặc biệt. Bản thảo của nó được hoàn thành năm 1939 bằng tiếng Pháp với tựa đề La civilisation annamite. Nhưng phải chờ hơn 5 năm sau, năm 1944, nó mới được xuất bản tại Hà Nội. Đó là 5 năm kiểm duyệt gắt gao của chính quyền thuộc địa, và cũng là 5 năm kháng cự bền bỉ của tác giả để bảo vệ cho quan điểm của mình. Và có những trang bản thảo đã không được xuất bản.',
	80000,5,322,N'Hội nhà văn','2018-12-27');



insert into BookCategory
values 
	('00050','00005'),
	('00051','00005'),
	('00052','00005'),
	('00053','00005'),
	('00054','00005'),
	('00055','00005'),
	('00056','00005'),
	('00057','00005'),
	('00058','00005'),
	('00059','00005');

insert into Img
values
	('00050.jpg','00050'),
	('00051.jpg','00051'),
	('00052.jpg','00052'),
	('00053.jpg','00053'),
	('00054.jpg','00054'),
	('00055.jpg','00055'),
	('00056.jpg','00056'),
	('00057.jpg','00057'),
	('00058.jpg','00058'),
	('00059.jpg','00059');

--triết học
insert into Book
values
	(N'TÔI TƯ DUY, VẬY THÌ TÔI VẼ','00060',N'Thomas Cathcart - Daniel Klein.', N'Vậy là, sau best seller Plato và con thú mỏ vịt bước vào quán bar… Thomas Cathcart và Daniel Klein một lần nữa dẫn dắt bạn đọc bước vào ngôi đền triết học linh thiêng bằng những tràng cười ngả nghiêng.',
	118000,5,364,N'Thế Giới','2020-09-21');

insert into Book
values
	(N'HEIDEGGER VÀ CON HÀ MÃ BƯỚC QUA CỔNG THIÊN ĐƯỜNG (TB 2020)','00061','Hà Gia Hân', N'Với Heidegger và con hà mã bước qua cổng Thiên đường, nếu Freud, Jung, Groucho Marx, Socrates, Woody Allen, Kierkegaard, Lily Tomlin, Đức Phật, Heidegger… gây xoắn não, đã có ngay những họa sĩ truyện tranh New York, xác sống, tất nhiên là cả hà mã và các truyện tiếu lâm độc đáo làm bạn phá lên cười, sáng cả óc. Hàn lâm và vui vẻ, cuốn sách này đúng là triết tếu để lĩnh hội triết – thật là hay, thật là nhộn, thật đấy!',
	84000,5,251,N'Thế Giới','2020-03-19');

insert into Book
values
	(N'TRIẾT HỌC NGHỆ THUẬT CỦA HEIDEGGER','00062',N'Như Huy, Bùi Văn Nam Sơn', N'“Nghệ thuật là gì?”, theo cách truyền thống, các triết gia đã trả lời câu hỏi này bằng cách tập trung vào kẻ sáng tạo nghệ thuật (như Nietzsche), hoặc vào kẻ tiếp nhận nghệ thuật (như Kant và Schopenhauer), và rồi từ các điểm nhìn đó họ suy ra bản chất của tác phẩm nghệ thuật. Tuy nhiên, Heidegger không chọn hai cách tiếp cận trên vì theo đó bản chất của nghệ thuật hoá ra lại là một trạng thái tâm lý học và triết học nghệ thuật sẽ bị thoái triển thành “mỹ học”. Mà nền tảng tối hậu cho mỹ học, quan điểm thẩm mỹ về nghệ thuật chính là sự thống trị hoàn toàn của lý tính, sự chiến thắng chung cuộc của quan điểm rằng khoa học và chỉ khoa học mới có thể đạt tới chân lý.',
	128000,5,376,N'Thế Giới','2020-01-03');

insert into Book
values
	(N'TÔI LÀ AI VÀ NẾU VẬY THÌ BAO NHIÊU','00063',N'Richard David Precht', N'Có rất nhiều cuốn sách về triết học, nhưng Tôi là ai – và nếu vậy thì bao nhiêu? là một sự khác biệt. Trước nay chưa từng có một ai dẫn dắt người đọc đến với những câu hỏi lớn của triết học bằng một cách am tường chuyên môn, đồng thời nhẹ nhàng tinh tế như vậy. Thông qua môn khoa học nghiên cứu não bộ, tâm lý học, lịch sử, và thậm chí văn hóa đại chúng (pop-culture), triết gia đương đại người Đức Richard David Precht đã khéo léo soi sáng những vấn đề ở tâm điểm của tồn tại con người như: Sự thật là gì? Cuộc sống có ý nghĩa gì? Tại sao tôi nên tốt? và trình bày chúng qua lối văn ngắn gọn, thông tuệ, cuốn hút. ',
	100000,5,506,N'Thế Giới','2019-12-29');

insert into Book
values
	(N'NÓI LUÔN CHO NÓ VUÔNG','00064',N'Trần Mạnh Hà', N'Sau thành công choáng váng của Cư xử như đàn bà, suy nghĩ như đàn ông, STEVE HARVEY, tác thông thái kiêm ngôi sao hài kịch, không thể cưỡng lại yêu cầu của độc giả muốn đọc thêm một cuốn sách nữa từ ông. Và Nói luôn cho vuông ra đời, lần này là để góp một câu trả lời sáng tỏ cho câu hỏi từng làm đau đầu không biết bao nhiêu người phụ nữ: Rốt cuộc thì trong các mối quan hệ, đàn ông thực sự nghĩ gì?',
	72000,5,300,N'Thế Giới','2018-09-30');

insert into Book
values
	(N'PLATO VÀ CON THÚ MỎ VỊT BƯỚC VÀO QUÁN BAR...','00065',N'Thomas Cathcart - Daniel Klein.', N'PLATO VÀ CON THÚ MỎ VỊT BƯỚC VÀO QUÁN BAR... dẫn dắt người đọc vào cuộc du hành vui vẻ và hài hước, qua truyện cười để hiểu lịch sử triết học cổ kim, đưa ra những câu trả lời đơn giản đến bất ngờ cho những ai muốn đi sâu vào bản chất Các Câu Hỏi Lớn mà không bị chìm nghỉm trong lý luận hàn lâm. Từ đây, các nhà tư tưởng lớn từ cổ chí kim như Aristotle, Plato, Descartes Kant, Hegel, Wittgenstein, Sartre... với ta không còn quá xa cách; siêu hình học, siêu triết học, nhận thức luận, triết học tôn giáo hay đạo đức học… với ta không còn nằm ngoài tầm hiểu. ',
	80000,5,272,N'Hội nhà văn','2020-07-29');

insert into Book
values
	(N'NỖI LO ÂU VỀ ĐỊA VỊ','00066',N'Alain de Botton', N'Trong đời sống hẳn ai cũng từng có nỗi lo lắng về địa vị, có thể là nỗi tự ti ngấm ngầm hay cảm giác thua thiệt; có thể là sự ghen tị hay mối lo bị thiên hạ coi như một kẻ thất bại. Dù xét trên bình diện nào, nỗi lo âu về địa vị vẫn luôn là chủ đề tươi mới, khi con người hoài mong và tìm kiếm cho mình một chỗ đứng giữa đồng loại. Con người dường như ngày càng nhiều nỗi lo âu hơn, khó thỏa mãn hơn, bất chấp sự phát triển nhanh chóng của nền kỹ nghệ và của xã hội tiêu dùng.',
	76000,5,352,N'Hội nhà văn','2017-06-01');

insert into Book
values
	(N'CHẾT CHO TƯ TƯỞNG - CUỘC ĐỜI NGUY HIỂM CỦA CÁC TRIẾT GIA','00067',N'Trần Ngọc Hiếu', N'Vào một ngày nào đó, đột nhiên, Socrates, Hypatia, Giordano Bruno, Thomas More và Jan Patocka đều phải đối diện với một trong những lựa chọn khó khăn nhất: hoặc trung thành với tư tưởng của mình và chết; hoặc khước từ chúng và tiếp tục sống. Thật trùng hợp, tất cả họ đều chọn chết. Những cái chết ngoạn mục của các triết gia này không chỉ trở thành một phần tiểu sử mà còn không thể tách rời tác phẩm của họ. Một “cái chết cho tư tưởng” hoàn toàn có tư cách của một tác phẩm triết học; Socrates có thể chưa từng viết một dòng nào song cái chết của ông là một trong số những tác phẩm triết học bán chạy mọi thời đại.',
	86000,5,424,N'Tri Thức','2017-05-05');

insert into Book
values
	(N'BIẾT TA ĐÍCH THỰC LÀ AI','00068',N'Alan Watts', N'Biết ta đích thực là ai – Cuốn sách về một cấm kỵ  – có lẽ là một trong những tác phẩm nổi tiếng và có ảnh hưởng nhất của học giả, triết gia Alan Watts. Trong đó, tác giả nghiền ngẫm về một cấm kỵ không được thừa nhận, nhưng đầy sức mạnh: sự thông đồng im lặng của chúng ta về câu hỏi ta thực sự là ai, hoặc là cái gì. Nỗ lực này là đi tìm lời đáp cho câu hỏi: Nếu cảm thức của chúng ta về mình dưới dạng ngã biệt lập trong chiếc bao da là ảo tưởng, không phù hợp cả với những khám phá của khoa học phương Tây lẫn với triết giáo phương Đông, vậy thì bản tính đích thực của chúng ta là gì?',
	141000,5,220,N'Lao động','2015-01-29');

insert into Book
values
	(N'SCHOPENHAUER NHÀ GIÁO DỤC','00069',N'Mạnh Tường', '"... Ai cảm được điều mà ở thời đại loài người hỗn tạp ngày nay ta đã bắt gặp một cá nhân toàn diện, thông suốt từ trong ra ngoài, được trang bị bằng những kết cấu đặc biệt, không ngại ngùng, không vấp váp, kẻ đó sẽ hiểu hạnh phúc và nỗi bàng hoàng của tôi khi khám phá ra Schopenhauer. Tôi có cảm giác mình đã tìm thấy nhà triết học, nhà giáo dục hằng bao lâu đã mỏi mòn con mắt đợi. Tôi gắng hết sức mình để lãnh hội những gì ở bên kia sách vở, để hình dung con người sinh động còn lưu lại cho tôi bản chúc thư vĩ đại, kẻ chỉ chọn lựa người thừa kế ở những ai muốn và có thể làm hơn một người đọc: là con và là học trò." ',
	28000,5,166,N'Văn học','2014-06-06');

insert into BookCategory
values 
	('00060','00006'),
	('00061','00006'),
	('00062','00006'),
	('00063','00006'),
	('00064','00006'),
	('00065','00006'),
	('00066','00006'),
	('00067','00006'),
	('00068','00006'),
	('00069','00006');

insert into Img
values
	('00060.jpg','00060'),
	('00061.jpg','00061'),
	('00062.jpg','00062'),
	('00063.jpg','00063'),
	('00064.jpg','00064'),
	('00065.jpg','00065'),
	('00066.jpg','00066'),
	('00067.jpg','00067'),
	('00068.jpg','00068'),
	('00069.jpg','00069');

--kinh tế

insert into Book
values
	(N'HOW BUSINESS WORKS - HIỂU HẾT VỀ KINH DOANH','00070','', N'Tại sao dòng tiền lại quan trọng? Sản xuất tinh gọn là gì? Marketing kỹ thuật số hoạt động ra sao? Thành viên hội đồng quản trị gồm những ai? Mua bán doanh nghiệp là gì? Cấu trúc doanh nghiệp ra sao? Khấu hao là gì? Trách nhiệm xã hội của doanh nghiệp ra sao? Làm thế nào để có thể thành công trong thị trường toàn cầu của thế kỷ 21?',
	304000,5,351,N'Thế Giới','2020-01-08');

insert into Book
values
	(N'ECONOMIX - CÁC NỀN KINH TẾ VẬN HÀNH (VÀ KHÔNG VẬN HÀNH) THẾ NÀO VÀ TẠI SAO?','00071',N'Michael Goodwin', N'Nếucác bạn từng tìm cách hiểu những khái niệm kinh tế qua việc đọc vô số giáo trình kinh tế học, nhưng vẫn thấy thật khó hình dung được bức tranh toàn cảnh về bộ môn này, thì cuốn sách sẽ cung cấp cho các bạnmột mảnh ghép hoàn chỉnh cho những mảnh nho nhỏ mà các bạn đã đọc qua.',
	121000,5, 310,N'Dân Trí','2020-01-02');

insert into Book
values
	(N'KID START-UP KHỞI NGHIỆP TỪ KHI LÊN 7','00072',N'Mark Cuban , Shaan Patel , Ian McCue', N'Nếu các em đang tìm cách để vừa kiếm ra tiền, vừa giúp đỡ được mọi người, thì tinh thần khởi nghiệp hoàn toàn phù hợp với các em rồi đấy. Các em có thể chỉ còn đang băn khoăn, không hiểu bắt đầu một công việc kinh doanh ở tuổi thiếu niên có sớm quá không, và liệu các em có thể thành công?',
	79000,5,164,N'Thế Giới','2019-09-26');

insert into Book
values
	(N'CHIẾN LƯỢC KINH DOANH','00073',N'The Economist & Jeremy Kourdi', N'Cuốn cẩm nang về xây dựng chiến lược kinh doanh này sẽ giúp các doanh nghiệp tránh được những hệ quả khốc liệt của việc đưa ra những quyết định kém hiệu quả. Với những minh họa rõ ràng, các nghiên cứu tình huống cụ thể, 18 chương của cuốn sách giúp người đọc có một tầm nhìn tổng quát về chiến lược: cách thức phát triển và thực thi chiến lược, phân bổ nguồn lực và dẫn dắt nhân sự cho chiến lược thế nào, đổi mới sáng tạo có vai trò ra sao trong chiến lược, làm thế nào để bán hàng và marketing một cách chiến lược.',
	119000,5,356,N'Hội nhà văn','2020-03-19');

insert into Book
values
	(N'HOW MONEY WORKS - HIỂU HẾT VỀ TIỀN','00074',N'Bùi Thị Quỳnh Chi', N'Đưa ra định nghĩa cho hàng trăm khái niệm, cùng với những kiến thức nền tảng nhất về các hệ thống tài chính, như trái phiếu, cổ phiếu, tiền mã hóa, bitcoin, quản lý nợ, tránh vỡ nợ trực tuyến và gọi vốn cộng đồng, cũng như cách tiền vận hành thế giới.',
	240000,5,257,N'Thế Giới','2019-08-17');

insert into Book
values
	(N'SỰ LÊN NGÔI CỦA CÁC NỀN TẢNG ĐA CHIỀU','00075',N' David S. Evans , Richard Schmalensee', N'Thế giới có lẽ chưa bao giờ nhỏ đến thế! Chúng ta có thể ngồi tại nhà và đặt phòng cho chuyến công tác vào 6 tháng sau ở tận bên kia bán cầu; nhân thể ta cũng đặt bàn ăn cùng đối tác luôn; thậm chí, nếu còn độc thân, ta có thể có cơ hội hẹn hò nhân dịp này… Tất cả đều được thực hiện trên chiếc điện thoại cầm tay của bạn, với những thao tác đơn giản, dựa trên các trang mạng kết nối người có nhu cầu với người cung cấp dịch vụ!',
	103000,5,308,N'Thế Giới','2019-07-15');

insert into Book
values
	(N'LỢI NHUẬN TỐT','00076',N'Charles G.Koch', N'Từ thực tế xuyên suốt hoạt động kinh doanh của tập đoàn Koch trên toàn thế giới trong gần một thế kỷ, tác giả cuốn sách và cũng là Chủ tịch kiêm CEO của tập đoàn Koch – Charles G. Koch – đã tiết lộ “bí mật” khiến công ty của ông tăng trưởng gấp 27 lần trong năm thập kỷ và trung bình cứ sáu năm một lần tăng gấp đôi giá trị doanh nghiệp.',
	112000,5,415,N'Hồng Đức','2019-04-09');

insert into Book
values
	(N'MỌI ĐIỀU BẠN CẦN BIẾT VỀ TẠO DỰNG THƯƠNG HIỆU','00077',N'Michiel Maandag , Liisa Puolakka', N'Một sản phẩm tốt là chưa đủ. Bạn không thể bán hay quảng bá bất cứ thứ gì mà không có một thương hiệu độc đáo và đặc biệt.',
	56000,5,150,N'Hội nhà văn','2018-11-30');

insert into Book
values
	(N'MARKETING MỞ ĐƯỜNG TĂNG TRƯỞNG','00078','Iain Ellwood', N'Cuốn cẩm nang này sẽ chỉ ra cách thức cũng như lý do tại sao marketing là tác nhân thúc đẩy tăng trưởng quan trọng nhất của doanh nghiệp hiện nay. Những người làm marketing (hay còn được gọi là các “marketer”) đóng vai trò quyết định trong việc tạo ra doanh thu, cũng như trong việc biến doanh thu thành lợi nhuận.Họ chính là những người đầu tiên nắm bắt được các hành vi và nhu cầu đang thay đổi của khách hàng và những động lực trên thị trường.',
	94000,5,336,N'Hội nhà văn','2018-11-16');

insert into Book
values
	(N'MASAYOSHI SON - TỈ PHÚ LIỀU ĂN NHIỀU','00079',N'Onishi Takahiro', N'Masayoshi Son là một giám đốc điều hành được coi là “điên” nhất Nhật Bản với triết lý kinh doanh “liều ăn nhiều” - ông đã gây dựng tập đoàn viễn thông đa quốc gia và Internet SoftBank với tổng tài sản vào khoảng 20,7 nghìn tỉ Yên (theo ước tính năm 2015).',
	96000,5,336,N'Thế Giới','2018-10-01');



insert into BookCategory
values 
	('00070','00007'),
	('00071','00007'),
	('00072','00007'),
	('00073','00007'),
	('00074','00007'),
	('00075','00007'),
	('00076','00007'),
	('00077','00007'),
	('00078','00007'),
	('00079','00007');

insert into Img
values
	('00070.jpg','00070'),
	('00071.jpg','00071'),
	('00072.jpg','00072'),
	('00073.jpg','00073'),
	('00074.jpg','00074'),
	('00075.jpg','00075'),
	('00076.jpg','00076'),
	('00077.jpg','00077'),
	('00078.jpg','00078'),
	('00079.jpg','00079');

--tâm lý học

insert into Book
values
	(N'ĐỪNG LẮM LỜI VỚI ĐÀN ÔNG – ĐỪNG ĐẤU LÝ VỚI PHỤ NỮ','00080',N'Iota Tatsunari', N'Sau nhiều năm đưa ra lời khuyên và tư vấn cho khách hàng trong công việc cũng như đời sống cá nhân như một chuyên gia tư vấn tâm lý, tác giả Iota Tatsunari cho rằng đó là vì “yếu tố cảm xúc” của mỗi người và mỗi giới đều có những đặc điểm phức tạp, thật khó có thể làm cho nhau hiểu nếu chỉ bằng lời nói hay thái độ.',
	87000,5,268,N'Thông Tấn','2019-09-18');

insert into Book
values
	(N'TÂM LÝ NGƯỜI AN NAM','00081',N'Nguyễn Tiến Văn', N'“Trên hết, người An Nam giữ mối hằn thù thâm sâu đối với bất cứ kẻ ngoại bang nào có thể tới để đánh bật họ ra khỏi tín ngưỡng, tập tục và định chế của họ. Dù cho người Trung Quốc hay người châu Âu đến xâm lăng xứ sở, sai khiến họ nhân danh một người chủ này hay người chủ kia, điều đó chẳng mấy quan trọng đối với họ, chừng nào người ta còn tôn trọng tôn giáo, luật lệ và tập quán của họ.”',
	72000,5,264,N'Hội nhà văn','2019-06-17');

insert into Book
values
	(N'BỐN THỎA ƯỚC ( TB 2018)','00082',N'Don Miguel Ruiz', N'Bốn thỏa ước - Chỉ dẫn thiết thực để đạt đến tự do cá nhân, cuốn sách 6 năm liền đứng trong top bestseller của The New York Times và bán được hơn 4 triệu bản trên toàn thế giới của tác gia người Mexico Don Miguel Ruiz vừa đến với độc giả Việt Nam qua bản dịch của dịch giả Nguyễn Trung Kỳ.',
	38000,5,179,N'Hội nhà văn','2019-03-04');

insert into Book
values
	(N'DÁM HẠNH PHÚC','00083',N'Kishimi Ichiro , Koga Fumitake', N'Ai cũng có thể hạnh phúc ngay từ giây phút này. [...]Chỉ có điều, chúng ta không thể hưởng thụ hạnh phúc nếu chỉ đứng yên tại chỗ. Cần phải tiếp tục tiến bước trên con đường mình đã đặt chân lên. Cậu đã tiến một bước đầu tiên. Đã tiến một bước dài. Tuy nhiên, cậu đang nhụt chí, định thoái lui chứ không chỉ dừng lại. Cậu có biết tại sao không?',
	88000,5,299,N'Lao động','2019-01-07');

insert into Book
values
	(N'ĐẮC NHÂN TÂM','00084',N'Dale Carnegie', N'Đắc nhân tâm, nghĩa là sống sao cho đẹp lòng người, nhằm tạo dựng một cuộc sống an vui trong đời tư, thiện chí và đầy tinh thần hợp tác trong công việc. Lẽ thường sẽ chẳng bao giờ có một chiếc chìa khóa vạn năng mở ra mọi thành công. Bạn phải thông minh, đắc lực, nhiệt huyết và dấn thân. Nhưng Dale Carnegie sẽ nói rằng còn một điều cốt yếu nữa mà ta phải học: kỹ năng thu phục lòng người.',
	78000,5,343,'','2019-01-06');

insert into Book
values
	(N'NUÔI DƯỠNG MỘT NGƯỜI ĐỌC TÍ HON','00085',N'Nguyễn Thị Ngọc Minh', N'Ngày nay, lũ trẻ bị bủa vây bởi các thiết bị nghe nhìn thông minh, và giờ học chính khóa lẫn ngoại khóa chiếm trọn thời gian của chúng. Hình ảnh một đứa trẻ chăm chú bên trang sách quên thời gian bỗng trở thành điều xa xỉ. Nhưng nếu cha mẹ biết rằng đọc sách mang lại những lợi ích lớn lao thế nào: việc đọc giúp con phát triển ngôn ngữ, rèn luyện khả năng tập trung và tư duy, nuôi dưỡng ý chí sáng tạo, bồi dưỡng lòng thấu cảm…',
	80000,5,283,N'Hội nhà văn','2018-12-19');

insert into Book
values
	(N'BẢY QUY LUẬT TINH THẦN CỦA THÀNH CÔNG (TÁI BẢN 2018)','00086',N'Deepak Chopra', '',
	44000,5,144,N'Thế Giới','2018-08-26');

insert into Book
values
	(N'SỰ SỐNG SAU CÁI CHẾT','00087',N' Deepak Chopra', N'Trong Sự sống sau cái chết, Deepack Chopra, tác gia danh tiếng thế giới về tâm linh và triết lý sống, đã đặt ra một câu hỏi có tầm quan trọng tối hậu về nền tảng sự tồn tại của chúng ta. Bằng kinh nghiệm cá nhân, trí tuệ của triết học Veda cổ đại và vật lý hạt cơ bản, Chopra xem xét các khả năng phi thường chờ đợi chúng ta ở cõi sau sự sống. Ông xem xét những lý thuyết coi cái chết là ảo ảnh của các cảm giác và cho rằng linh hồn sống sót trong vòng xoáy liên tục của sự thanh lọc, kết thúc nơi cõi Niết bàn. Đi kèm với đó còn là những bài tập kích thích tư duy, cung cấp kinh nghiệm trực tiếp của các tư tưởng, giúp bạn sáng tỏ tâm linh của mình bất kể bạn chọn con đường nào để đi, cho bạn thấy bản đồ của chính bạn trong cõi vĩnh hằng. ',
	70000,5,372,N'','2020-03-19');

insert into Book
values
	(N'CÓ PHẢI TẠI CON ĐÂU!','00088',N' Isabelle Filliozat', N'Khi trẻ đã lên 6, các bậc cha mẹ tưởng như được dễ thở hơn bởi không còn phải đối mặt với những trận ăn vạ, những cơn gào khóc nhưng thay vì thế thì: chạy nhảy khắp nơi, quên đồ đạc, không tập trung nổi, mất lòng tin, nổi khùng lên trước một việc nhỏ nhặt, hung hăng khi ở trường, khó chịu nơi bàn ăn, tè dầm ra giường,… - Những thử thách mới trong một chặng đường mới! Và liệu những la hét, quát mắng hay hình phạt có phải là giải pháp hay chỉ càng đổ thêm dầu vào lửa?',
	60000,5,176,N'Hội nhà văn','2018-06-26');

insert into Book
values
	(N'THIÊNG VÀ PHÀM','00089',N'Mircea Eliade', N'Có thể nói rằng lịch sử các tôn giáo, từ những tôn giáo sơ khởi nhất đến những tôn giáo hoàn chỉnh nhất, được tạo nên nhờ tích lũy những sự linh hiển, bằng các biểu hiện của những hiện thực thiêng liêng. Từ sự linh hiển sơ đẳng nhất, chẳng hạn, tính thiêng biểu hiện ở một vật nào đó, một hòn đá hay một cái cây; cho đến tính thiêng biểu hiện ở mức cao siêu nhất, chẳng hạn, đối với một người Kitô giáo, sự hóa thân của Thượng đế vào Jesus Kitô, không tồn tại giải pháp nối tiếp liên tục giữa cái thiêng và cái phàm.',
	56000,5,225,N' Tri Thức','2020-03-19');

insert into BookCategory
values 
	('00080','00008'),
	('00081','00008'),
	('00082','00007'),
	('00083','00008'),
	('00084','00008'),
	('00085','00008'),
	('00086','00008'),
	('00087','00008'),
	('00088','00008'),
	('00089','00008');

insert into Img
values
	('00080.jpg','00080'),
	('00081.jpg','00081'),
	('00082.jpg','00082'),
	('00083.jpg','00083'),
	('00084.jpg','00084'),
	('00085.jpg','00085'),
	('00086.jpg','00086'),
	('00087.jpg','00087'),
	('00088.jpg','00088'),
	('00089.jpg','00089');

--tham khảo

insert into Book
values
	(N'CÔNG THỨC HẠNH PHÚC','00090',N' Manfred F. R. Kets de Vries', N'Trong cuốn sách này, Kets de Vries nỗ lực giải cấu trúc khái niệm trừu tượng ấy. Ông đi từ quan điểm sinh học, thống kê học, tâm lý học, triết học tự cổ chí kim đến cả các trích dẫn từ nhà văn, nhà thơ, nghệ sĩ, và trên hết, những trải nghiệm cá nhân, nhằm tìm ra một "đơn thuốc" giúp tăng cường khả năng đạt được hạnh phúc. Đơn thuốc ấy có hiệu quả hay không tùy thuộc ở mỗi người, nhưng có một điều chắc chắn: hạnh phúc luôn ở đâu đó, trong hiện tại và trong tương lai, và ta không bao giờ được mất hy vọng.',
	70000,5,164,N'Thế Giới','2020-08-10');

insert into Book
values
	(N'SỔ TAY ĂN DẶM CỦA MẸ (TB 99.000)','00091',N'BS Lê Thị Hải', N'“Trong quá trình khám chữa bệnh, tôi gặp nhiều trường hợp các em bé bị suy dinh dưỡng, còi xương không phải vì gia đình không có điều kiện mà do… quá có điều kiện. Tôi gặp những em bé khá bụ bẫm nhưng bố mẹ vẫn đưa đi khám vì thấy con không tăng cân và cho là con biếng ăn. Trong khi đó cũng có những trường hợp bố mẹ nói rằng con ăn rất được nhưng thực ra khẩu phần dinh dưỡng lại không đủ hoặc không cân đối. Nhưng biếng ăn là câu chuyện tôi gặp nhiều nhất. Chưa bao giờ câu chuyện cho bé ăn gì và ăn như thế nào lại khiến các bố mẹ lo lắng nhiều như vậy.',
	79000,5,267,N'Hội nhà văn','2020-03-23');

insert into Book
values
	(N'NHÂN VẬT NỔI TIẾNG THẾ GIỚI – KHOA HỌC VÀ PHÁT MINH','00092',N'Renzo Barsotti , Eleonora Barsotti', N'Nhắc đến khoa học, hẳn chúng ta sẽ nghĩ ngay đến kiến thức. Nhưng cuốn sách này không chỉ chứa những kiến thức khô cứng. Sách mở ra cho bạn thấy nhân sinh quan tươi sáng và tinh thần vươn lên của các vĩ nhân, sách còn kể lại những trải nghiệm xây đắp nên sự vĩ đại của họ.',
	119000,5,126,N'Hà Nội','2020-03-02');

insert into Book
values
	(N'NHÂN VẬT NỔI TIẾNG THẾ GIỚI – VĂN HÓA VÀ NGHỆ THUẬT','00093',N' Renzo Barsotti , Eleonora Barsotti', '',
	119000,5,126,N'Hà Nội','2020-03-02');

insert into Book
values
	(N'SỐNG KHỎE KHÔNG RỦI RO','00094',N'Frédéric Saldmann', N'Nên rửa tay trước hay sau khi đi vệ sinh, đá lạnh có thể giúp giảm cân, ôm giúp cắt cơn đói, tiểu đứng hay tiểu ngồi có lợi, đạp xe nhiều làm giảm nhu cầu tình dục,...? Bằng cách cung cấp những quy tắc vệ sinh đáng ngạc nhiên, những cách cắt cơn đói tự nhiên, danh sách những loại thực phẩm chống tăng cân,... Sống khỏe không rủi ro sẽ trang bị cho độc giả bí kíp để có được bụng phẳng, eo theo, đời sống tình dục hoàn hảo và những giấc ngủ trên cả tuyệt vời! Hãy cùng bác sĩ kiêm tác giả best-seller Frédéric Saldmann học cách trở thành bác sĩ của chính bản thân bạn để có được một sức khỏe hoàn hảo mà không tốn một xu!',
	94000,5,460,N'Hội nhà văn','2019-12-19');

insert into Book
values
	(N'LỊCH LÃM NHƯ MỘT QUÝ ÔNG','00095',N'Élisabeth Jammes , Étienne Pihouée', N'Lịch lãm luôn là yếu tố tiên quyết tạo nên sức hấp dẫn cho phái mạnh. Với tất cả những ai đang loay hoay tìm kiếm phong cách, hoặc xây dựng hình ảnh người đàn ông hiện đại, thành công và thu hút, Lịch lãm như một quý ông chắc chắn là cuốn sách không thể bỏ qua.',
	86000,5,128,N'Thế Giới','2019-12-04');

insert into Book
values
	(N'CHÓ VÀ MÈO DƯỚI LĂNG KÍNH KHOA HỌC','00096',N'Antonio Fischetti', N'Bạn có nuôi chó hoặc mèo? Chắc hẳn là bạn rất thân thiết với người bạn bốn chân ấy. Vậy bạn có hiểu những hành vi, cử chỉ của “boss”? Chẳng hạn, tại sao chó lại vẫy đuôi cả khi vui mừng lẫn khi căng thẳng? Có nên nhìn thẳng vào mắt một con chó đang giận dữ? Những tiếng gừ gừ của mèo có ý nghĩa gì? Tại sao mèo lại khó tính với đồ ăn đến thế?',
	100000,5,62,N'Thế Giới','2019-11-28');

insert into Book
values
	(N'ĐỊA CHÍNH TRỊ CỦA LOÀI MUỖI - KHÁI LƯỢC VỀ TOÀN CẦU HÓA','00097',N'Erik Orsenna', N'Từ 250 triệu năm trước, muỗi đã có mặt trên Trái đất, vậy nhưng chúng chẳng nán lại lâu la gì: vòng đời trung bình của một con muỗi là 30 ngày. Rất đông đúc (3564 loài), có mặt trên khắp các châu lục, chúng giết người vô tội vạ (750 000 người mỗi năm)! Khi chúng vo ve bên tai ta thì không phải chỉ là để quấy rầy giấc khuya của ta, mà còn là để kể cho chúng ta một câu chuyện : câu chuyện về những đường biên giới bị xóa nhòa, về những đột biến không ngừng, về những cuộc chiến đấu để sinh tồn. Và đặc biệt là câu chuyện tay ba giữa muỗi, ký sinh trùng và con mồi (chính là chúng ta).',
	86000,5,328,N'Hội nhà văn','2020-03-19');


insert into Book
values
	(N'NHÂN VẬT NỔI TIẾNG THẾ GIỚI– CÁC LÃNH TỤ LẪY LỪNG','00098',N'Renzo Barsotti , Eleonora Barsotti',N'Mong muốn được sống tử tế và sống có ích là điều then chốt tạo nên một cuộc sống hạnh phúc cho bạn trong tương lai. Các nhà lãnh đạo tự cổ chí kim đều mang trong mình những tố chất khơi gợi cảm hứng ấy và truyền cho bạn động lực bước lên những nấc thang mới.',
	119000,5,126,N'Hội nhà văn','2019-09-20');

insert into Book
values
	(N'NGHỆ THUẬT SỐNG HẠNH PHÚC GẶT THÀNH CÔNG','00099',N'Rolf Dobelli', N'Từ xưa tới nay, con người vẫn luôn tự hỏi thế nào là một đời hạnh phúc? Con người ta nên sống ra sao? Điều gì rạo nên một cuộc sống hạnh phúc? Hạnh phúc tại tâm hay vì đạt được những mục tiêu trong đời? Sẽ tốt hơn nếu chủ động tìm kiếm hạnh phúc hay chủ động né tránh những điều khiến ta không hạnh phúc? Có người dành cả đời mải miết đi tìm câu trả lời cho những câu hỏi này, và vì một lẽ nào đó chỉ luôn nhận lại thất vọng. Vì sao ư? Phải chăng vì họ cứ kiếm tìm một nguyên tắc duy nhất, một nguyên lý duy nhất, một quy luật duy nhất, trong khi chén thánh đó của cuộc sống hạnh phúc đâu có tồn tại.',
	103000,5, 396,N'Hội nhà văn','2019-07-09');

insert into BookCategory
values 
	('00090','00009'),
	('00091','00009'),
	('00092','00009'),
	('00093','00009'),
	('00094','00009'),
	('00095','00009'),
	('00096','00009'),
	('00097','00009'),
	('00098','00009'),
	('00099','00009');

insert into Img
values
	('00090.jpg','00090'),
	('00091.jpg','00091'),
	('00092.jpg','00092'),
	('00093.jpg','00093'),
	('00094.jpg','00094'),
	('00095.jpg','00095'),
	('00096.jpg','00096'),
	('00097.jpg','00097'),
	('00098.jpg','00098'),
	('00099.jpg','00099');


insert into Customer
values
	('00000', 'Tri Cao','cttri19','abc','cttri19@apcs.vn','0334229447',N'Số nhà 18, đường số 20, ấp 2, xã Bình Hưng, huyện Bình Chánh, TPHCM',null),
	('00001', 'Khoa Duong','dvkhoa19','abc','dvkhoa19@apcs.vn','0977218954',N'Số nhà 21, đường Đinh Bộ Lĩnh, phường Ninh Bình, quận 1, TPHCM',null),
	('00002', 'Ha Pham','ptnha19','abc','ptnha19@apcs.vn','0343628811',N'Số nhà 18, đường CMT8, quận 3, TPHCM',null),
	('00003', 'Tuan Vu','vntuan19','abc','vntuan19@apcs.vn','0943353434',N'Số nhà 20, đường Nam Kỳ Khởi Nghĩa, quận Hoàn Kiếm, Hà Nội',null),
	('00004', 'A Nguyen','anguyenahihi','abc','nguyenan@gmail.vn','0916273741',N'Số nhà 129, ấp Thôn Rôn, xã Vinh Kim, huyện Cầu Ngang, Trà Vinh',null),
	('00005', 'Dung Nguyen','dungnguyen','abc','dungnguyen@gmail.vn','056922222',N'Số nhà 12, ấp Mai Hương, xã Vinh Kim, huyện Cầu Ngang, Trà Vinh',null),
	('00006', 'Dinh Tran','dinhtran','abc','dinhtran@gmail.vn','0943353443',N'Số nhà 14, ấp Lô Hội, xã Ngũ Lạc, huyện Duyên Hải, Trà Vinh',null)

insert into FAQ
values
	('00000',N'Hệ thống BookHouse được tạo thành bởi tổ chức nào?',N'Hệ thống BookHouse với mục đích phân phối sách, đưa văn hoá đọc đến gần với người đọc trên toàn quốc. Được xây dựng bởi đội ngũ kĩ thuật phần mềm dày dặn kinh nghiệm và có sức sáng tạo. Đội ngũ gồm 5 sinh viên năm 3 trẻ và đầy hứa hẹn về tương lai tươi sáng, hiện đang theo đuổi phát triển Software Engineering.'),
	('00001',N'Hệ thống BookHouse hướng tới văn hoá đọc như thế nào?',N'Hệ thống BookHouse hiện tại đang hướng tới những cuốn sách với nội dung gần gũi với người đọc như văn học đạo đức, triết học, tâm lý học, thơ ca nước ngoài,... Hệ thống BookHouse đồng thời hướng tới các đối tượng trẻ tuổi, thúc đẩy sở thích đọc sách ở các bạn trẻ với các thể loại như tiểu thuyết trinh thám, tiểu thuyết kinh dị, ngôn tình lãng mạn, truyện ngắn nhân văn,... Hệ thống BookHouse hi vọng mạng lại niềm vui thích đọc sách cho mọi đối tượng yêu thích sách.'),
	('00002',N'Hệ thống BookHouse có trụ sở chính ở đâu?',N'Hệ thống BookHouse hiện tại là hệ thống phân phối sách, thuộc phạm vi quản lý quy mô nhỏ, với cơ sở vật chất trung bình ở địa chỉ 227 Nguyễn Văn Cừ, P4, Q5, TP HCM. Hệ thống BookHouse đang hướng tới tương lai quy mô lớn hơn và xây dựng một cơ sở vật chất hiện đại hơn, cung cấp dịch vụ tốt hơn cho người dùng.'),
	('00003',N'Liệu hệ thống BookHouse có gây ảnh hưởng đến người dùng khi bị tấn công mạng?',N'Hệ thống BookHouse vẫn đang trong giai đoạn mầm non, đang được cải thiện từng ngày với cấu trúc đơn giản nhầm tăng hiệu quả tương tác với người dùng. Hệ thống BookHouse có thể xảy ra những sai sót hoặc không phản hồi đúng với yêu cầu người dùng. Khi gặp lỗi, hệ thống sẽ thông tin cho người dùng ngay lặp tức và tạm hoãn liên kết với người dùng để không gây ra thiệt hại đối với khách hàng.'),
	('00004',N'Liệu hệ thống BookHouse sẽ giải quyết ra sao đối với quyền lợi người dùng bị ảnh hưởng ?',N'Hệ thống BookHouse với hi vọng mang đến sự trải nghiệm tuyệt vời cho người dùng, sẽ không khiến người dùng chịu thiệt hại đối với sự không chuyên nghiệp của hệ thống. Hệ thống BookHouse sẽ bồi thường thiệt hại về vật chất đối với người dùng nếu xảy ra sai sót về vật chất. Trường hợp thông tin hay đơn hàng của người dùng xảy ra sai sót, hệ thống sẽ hỗ trợ sửa chữa nhanh chóng để người dùng có thể tiếp tục trải nghiệm dịch vụ. Trường hợp xảy ra rò rỉ thông tin cá nhân người dùng, hệ thống không thể đảm bảo vì hacker bây giờ rất yang lake, hệ thống không lường trước được.')

insert into CommentBook
values
	('00000','00000', '00000', N'Cuốn sách này rất hay'),
	('00001','00001', '00000', N'Cuốn sách này khá hay'),
	('00002','00002', '00000', N'Cuốn sách này khá hay'),
	('00003','00003', '00000', N'Cuốn sách này rất hay'),
	('00004','00004', '00000', N'Cuốn sách này khá hay'),
	('00005','00005', '00000', N'Cuốn sách này khá hay'),
	('00006','00000', '00001', N'Cuốn sách này tạm ổn'),
	('00007','00001', '00001', N'Cuốn sách này không hay'),
	('00008','00002', '00001', N'Cuốn sách này khá hay'),
	('00009','00003', '00001', N'Cuốn sách này rất hay'),
	('00010','00004', '00001', N'Cuốn sách này rất hay'),
	('00011','00005', '00001', N'Cuốn sách này rất hay'),
	('00012','00006', '00002', N'Cuốn sách này không hay'),
	('00013','00007', '00002', N'Cuốn sách này khá hay'),
	('00014','00008', '00002', N'Cuốn sách này rất hay'),
	('00015','00009', '00002', N'Cuốn sách này khá hay'),
	('00016','00010', '00002', N'Cuốn sách này khá hay'),
	('00017','00011', '00003', N'Cuốn sách này khá hay'),
	('00018','00012', '00003', N'Cuốn sách này khá hay'),
	('00019','00013', '00003', N'Cuốn sách này khá hay'),
	('00020','00014', '00003', N'Cuốn sách này khá hay'),
	('00021','00015', '00004', N'Cuốn sách này khá hay'),
	('00022','00001', '00004', N'Cuốn sách này rất hay'),
	('00023','00002', '00004', N'Cuốn sách này tạm ổn')

insert into Rating
values
	('00000','00000', '00000', 5),
	('00001','00001', '00000', 4),
	('00002','00002', '00000', 4),
	('00003','00003', '00000', 5),
	('00004','00004', '00000', 4),
	('00005','00005', '00000', 4),
	('00006','00000', '00001', 3),
	('00007','00001', '00001', 2),
	('00008','00002', '00001', 4),
	('00009','00003', '00001', 5),
	('00010','00004', '00001', 5),
	('00011','00005', '00001', 5),
	('00012','00006', '00002', 2),
	('00013','00007', '00002', 4),
	('00014','00008', '00002', 5),
	('00015','00009', '00002', 4),
	('00016','00010', '00002', 4),
	('00017','00011', '00003', 4),
	('00018','00012', '00003', 4),
	('00019','00013', '00003', 4),
	('00020','00014', '00003', 4),
	('00021','00015', '00004', 4),
	('00022','00001', '00004', 5),
	('00023','00002', '00004', 3)

go

insert into [Order]
values 
('00000','00000',N'Số nhà 18, đường số 20, ấp 2, xã Bình Hưng, Bình Chánh, TPHCM','0334229447',N'Đã nhận hàng', 1445000,Null,'2021-12-12','2021-12-24',N'Trí Cao','COD',20000,1425000),
('00001','00001',N'Số nhà 21, đường Đinh Bộ Lĩnh, phường Ninh Bình, quận 1, TPHCM','0977218954',N'Đã nhận hàng', 1326000,Null,'2021-12-12','2021-12-24',N'Dương Khoa','COD',30000,1296000),
('00002','00002',N'Số nhà 18, đường CMT8, quận 3, TPHCM','0943353443',N'Đã nhận hàng', 853400,Null,'2021-12-12','2021-12-24',N'Hà Phạm','COD',30000,823400),
('00003','00003',N'Số nhà 20, đường Nam Kỳ Khởi Nghĩa, quận Hoàn Kiếm, Hà Nội','0943353434',N'Đã nhận hàng', 618000,Null,'2021-12-12','2021-12-24',N'Tuấn Vũ','COD',20000,598000),
('00004','00004',N'Số nhà 129, ấp Thôn Rôn, xã Vinh Kim, huyện Cầu Ngang, Trà Vinh','0916273741',N'Đã nhận hàng', 248000,Null,'2021-12-12','2021-12-24',N'An Nguyễn','COD',20000,228000)
go



insert into OrderDetail
values
('00000','00000','00000',5,305000,1),
('00001','00000','00001',1,84000,1),
('00002','00000','00002',2,152000,1),
('00003','00000','00003',3,228000,1),
('00004','00000','00004',4,368000,1),
('00005','00000','00005',6,288000,1),
('00006','00001','00000',4,244000,1),
('00007','00001','00001',2,168000,1),
('00008','00001','00002',1,76000,1),
('00009','00001','00003',2,152000,1),
('00010','00001','00004',4,368000,1),
('00011','00001','00005',6,288000,1),
('00012','00002','00006',1,56000,1),
('00013','00002','00007',2,110400,1),
('00014','00002','00008',3,165000,1),
('00015','00002','00009',4,216000,1),
('00016','00002','00010',5,276000,1),
('00017','00003','00011',2,174000,1),
('00018','00003','00012',2,140000,1),
('00019','00003','00013',3,204000,1),
('00020','00003','00014',2,80000,1),
('00021','00004','00015',1,68000,1),
('00022','00004','00001',1,84000,1),
('00023','00004','00002',1,76000,1)


insert into CartDetail
values
('00000','00000','00014',2,80000),
('00001','00000','00015',1,68000),
('00002','00000','00001',1,84000),
('00003','00000','00002',1,76000),
('00004','00001','00006',1,56000),
('00005','00001','00007',2,110400),
('00006','00001','00008',3,165000),
('00007','00001','00009',4,216000)

go



CREATE OR ALTER PROCEDURE sp_checklogin(@username nchar(30), @pass nchar(30), @result INT OUT)
AS
BEGIN TRANSACTION
		set @result=2
        if not exists(
            select *
            from Customer
            where UserName = @username
        )
        BEGIN
            Set @result=0
        END
		ELSE
		BEGIN
			if not exists(
            select *
            from Customer
            where Password = @pass)
			BEGIN
				Set @result=1
			END
		END
       
COMMIT TRANSACTION
    
GO

declare @result INT
exec sp_checklogin 'cttri19','abc', @result OUT
print(@result)

go
-----------------------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_createAccountCustomer(@name nvarchar(200), @username nchar(30), @pass nchar(30), @email nchar(100), @phone nchar(11), @address nvarchar(200),@result INT OUT)
AS
BEGIN TRANSACTION
		set @result=2
        if not exists(
            select *
            from Customer
            where UserName = @username
        )
        BEGIN
			Declare @count int
			Set @count=(
				select top(1) c.CustomerID
				from Customer as c
				order by c.CustomerID desc
			)
			Set @count=CAST(@count AS int)
			Set @count=@count+1
			Declare @tmp char(5)
			Set @tmp=RIGHT('00000'+CAST(@count as varchar(5)) ,5)
			insert into Customer (CustomerID, CustomerName ,UserName ,Password,CustomerEmail,CustomerPhone,Address)
			values (@tmp, @name, @username, @pass,@email,@phone,@address);
			Set @result=1
			
        END
		ELSE
		BEGIN
			Set @result=0
		END
       
COMMIT TRANSACTION
    
GO

create or alter function fn_getcurrentOid()
returns char(5)
as
begin
	        Declare @count int
			Set @count=(
				select top(1) o.OrderID
				from [Order] as o
				order by o.OrderID desc
			)
			Set @count=CAST(@count AS int)
			Set @count=@count+1
			Declare @tmp char(5)
			Set @tmp=RIGHT('00000'+CAST(@count as varchar(5)) ,5)
			return @tmp - 1
end
go

select dbo.fn_getcurrentOid()
/*
declare @result INT
exec sp_createAccountCustomer 'Khoa Duong','dvkhoa19','abc', @result OUT
print(@result)

select* from Customer
*/
go

--BOOK INFORMATION
-----------------------------------------------------------------------------

CREATE OR ALTER FUNCTION BookInfor(@bookid char(5))
RETURNS TABLE
AS
RETURN
(
    select b.BookName, b.BookID,b.AuthorName, b.Description, b.Price, b.Stock,b.NumOfPage,b.PublishingCom,b.ReleaseDate, c.CategoryName , AVG(cast((r.RatingStar) as float)) as Rating, i.ImagePath, sum(ocd.Quatity) as Soluongban
	from Book as b join BookCategory as bc on b.BookID=bc.BookID join Category as c on bc.CategoryID=c.CategoryID left join Rating as r on b.BookID=r.BookID join img as i on i.BookID=b.BookID left join OrderDetail ocd on ocd.BookID=b.BookID
	where b.BookID=@bookid
	group by b.BookName, b.BookID,b.AuthorName, b.Description, b.Price, b.Stock,b.NumOfPage,b.PublishingCom,b.ReleaseDate, c.CategoryName, i.ImagePath
)
GO

SELECT * FROM BookInfor('00001')
go
-----------------------------------------------------------------------------

CREATE OR ALTER FUNCTION BookComment(@bookid char(5))
RETURNS TABLE
AS
RETURN
(
    select * from CommentBook where BookID=@bookid
)
GO

SELECT * FROM BookComment('00001')
go
-----------------------------------------------------------------------------


--Add comment
-----------------------------------------------------------------------------
go

CREATE OR ALTER PROCEDURE sp_addcomment(@bookid char(5), @customerID char(5), @content nvarchar(2000), @result INT OUT)
AS
BEGIN TRANSACTION
		set @result=2
        if not exists(
            select *
            from Book
            where BookID = @bookid
        )
        BEGIN
			Set @result=1
        END
		ELSE
		BEGIN
			if not exists(
            select *
            from Customer
            where CustomerID = @customerID)
			BEGIN
				Set @result=0
			END
			ELSE
			BEGIN
				Declare @count int
				Set @count=(
					select top(1) cb.CommentID
					from CommentBook as cb
					order by cb.CommentID desc
				)
				Set @count=CAST(@count AS int)
				Set @count=@count+1
				Declare @tmp char(5)
				Set @tmp=RIGHT('00000'+CAST(@count as varchar(5)) ,5)
				insert into CommentBook(CommentID, BookID,CustomerID,Content)
				values (@tmp, @bookid, @customerID , @content );
			END
		END
       
COMMIT TRANSACTION
    
GO

--add to cart
CREATE OR ALTER PROCEDURE sp_addtocart(@uid char(5), @bookid char(5), @quantity smallint, @result INT OUT)
AS
BEGIN TRANSACTION
		set @result=2
        if not exists(
            select *
            from Book
            where BookID = @bookid
        )
        BEGIN
			Set @result=1
        END
		ELSE
		BEGIN
			if not exists(
            select *
            from Customer
            where CustomerID = @uid)
			BEGIN
				Set @result=0
			END
			ELSE
			BEGIN
				Declare @price int
				Set @price=(
				select b.Price from Book as b where b.BookID=@bookid
				)
				Set @price=@price*@quantity
				if exists(
					select* 
					from CartDetail
					where CartDetail.BookID=@bookid and CartDetail.CustomerID=@uid
					)
				BEGIN
						Update CartDetail
						set Quatity=@quantity, Price=@price
						where CartDetail.BookID=@bookid and CartDetail.CustomerID=@uid
				END
				else
				begin
				Declare @count int
				Set @count=(
					select top(1) c.CartDetailID
					from CartDetail as c
					order by c.CartDetailID desc
				)
				Set @count=CAST(@count AS int)
				Set @count=@count+1
				Declare @tmp char(5)
				Set @tmp=RIGHT('00000'+CAST(@count as varchar(5)) ,5)
				
				insert into CartDetail(CartDetailID, CustomerID ,BookID ,Quatity,Price)
				values (@tmp, @uid,@bookid,@quantity, @price );
				end
			END
        
		END
       
COMMIT TRANSACTION
    
GO


--delete cart detail
CREATE OR ALTER PROCEDURE sp_deletecartdetail(@uid char(5), @bookid char(5), @result INT OUT)
AS
BEGIN TRANSACTION
		set @result=1
        if not exists(
            select *
            from CartDetail
            where BookID = @bookid AND CustomerID=@uid
        )
        BEGIN
			Set @result=0
        END
		ELSE
		BEGIN
			DELETE FROM CartDetail WHERE BookID = @bookid AND CustomerID=@uid
		END
       
COMMIT TRANSACTION
    
GO

CREATE OR ALTER PROCEDURE sp_deleteallcartdetail(@uid char(5), @result INT OUT)
AS
BEGIN TRANSACTION
		set @result=1
        if not exists(
            select *
            from CartDetail
            where CustomerID=@uid
        )
        BEGIN
			Set @result=0
        END
		ELSE
		BEGIN
			DELETE FROM CartDetail WHERE CustomerID=@uid
		END
       
COMMIT TRANSACTION
    
GO

declare @result smallint
exec sp_deleteallcartdetail '00001', @result out
/*
declare @result smallint 
declare @a char(5)
set @a='00001'
exec sp_addtocart @a,'00011',3,@result OUT
print(@result)
*/
--add order

CREATE OR ALTER PROCEDURE sp_createnewOrder(@customerID char(5), @address nvarchar(100), @phone nchar(11), 
	@TotalPrice int, @NoteForOrder nvarchar(200),@OrderDate date,
	@RecipientName nvarchar(200),@DeliveryMethod nvarchar(100),@DeliveryCharge int,@GoodsPrice int, @result INT OUT, @orderID char(5) out)
AS
BEGIN TRANSACTION
		set @orderID=''
		set @result=1
		if not exists(
        select *
        from Customer
        where CustomerID = @customerID)
		BEGIN
			Set @result=0
		END
		ELSE
		BEGIN
			Declare @count int
			Set @count=(
				select top(1) o.OrderID
				from [Order] as o
				order by o.OrderID desc
			)
			Set @count=CAST(@count AS int)
			Set @count=@count+1
			Declare @tmp char(5)
			Set @tmp=RIGHT('00000'+CAST(@count as varchar(5)) ,5)
			Set @orderID=@tmp
			insert into [Order](OrderID,CustomerID ,Address,Phone,OrderState,TotalPrice,NoteForOrder,OrderDate, ReceivedDate,RecipientName,DeliveryMethod,DeliveryCharge,GoodsPrice)
			values (@tmp,@customerID, @address, @phone, N'Đang chờ xác nhận',@TotalPrice, @NoteForOrder,@OrderDate , Null,@RecipientName ,@DeliveryMethod ,@DeliveryCharge ,@GoodsPrice );
		END
        
COMMIT TRANSACTION
    
GO
/*
declare @result smallint
declare @orderid char(5)
exec sp_createnewOrder '00004',N'Số nhà 129, ấp Thôn Rôn, xã Vinh Kim, huyện Cầu Ngang, Trà Vinh','0916273741', 248000,Null,'2021-12-12',N'An Nguyễn','COD',20000,228000, @result OUT, @orderid OUT
print(@result)
print(@orderid)
go
*/

CREATE OR ALTER PROCEDURE sp_addOrderDetail(@orderID char(5), @bookid char(5), @quantity smallint, @result INT OUT )
AS
BEGIN TRANSACTION
		set @result=1
		if not exists(
        select *
        from [Order] as O
        where O.OrderID = @orderID)
		BEGIN
			Set @result=0
		END
		ELSE
		BEGIN
			Declare @count int
			Set @count=(
				select top(1) od.DetailID
				from OrderDetail as od
				order by od.DetailID desc
			)
			Set @count=CAST(@count AS int)
			Set @count=@count+1
			Declare @tmp char(5)
			Set @tmp=RIGHT('00000'+CAST(@count as varchar(5)) ,5)

			Declare @price int
			Set @price=(
			select b.Price from Book as b where b.BookID=@bookid
			)
			Set @price=@price*@quantity
			insert into OrderDetail(DetailID ,OrderID  ,BookID ,Quatity ,PriceForDetail ,IsRating )
			values (@tmp,@orderID,@bookid,@quantity,@price,0);
		END
        
COMMIT TRANSACTION
    
GO

/*

declare @result smallint
declare @orderid char(5)
exec sp_addOrderDetail '00004', '00010', 5, @result OUT
print(@result)
select* from OrderDetail where OrderDetail.OrderID='00004'
*/





--Add rating
-----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_addrating(@bookid char(5), @customerID char(5), @star smallint, @result INT OUT)
AS
BEGIN TRANSACTION
		set @result=2
        if not exists(
            select *
            from Book
            where BookID = @bookid
        )
        BEGIN
			Set @result=1
        END
		ELSE
		BEGIN
			if not exists(
            select *
            from Customer
            where CustomerID = @customerID)
			BEGIN
				Set @result=0
			END
			ELSE
			BEGIN
				Declare @count int
				Set @count=(
					select top(1) r.RatingID
					from Rating as r
					order by r.RatingID desc
				)
				Set @count=CAST(@count AS int)
				Set @count=@count+1
				Declare @tmp char(5)
				Set @tmp=RIGHT('00000'+CAST(@count as varchar(5)) ,5)
				insert into Rating(RatingID, CustomerID ,BookID ,RatingStar)
				values (@tmp, @bookid, @customerID , @star );
			END
        
		END
       
COMMIT TRANSACTION
    
GO



--sách bán chạy, sách bán chạy theo thể loai 




go
CREATE OR ALTER FUNCTION BestSellerGenneral()
RETURNS TABLE
AS
RETURN
(
    select top(200) b.BookID, b.BookName,b.Price, AVG(cast((r.RatingStar) as float)) as Rating, i.ImagePath
	from Category c join BookCategory bc on c.CategoryID=bc.CategoryID join Book b on b.BookID=bc.BookID left join OrderDetail ocd on ocd.BookID=b.BookID left join Rating as r on b.BookID=r.BookID join Img as i on i.BookID=b.BookID
	group by b.BookID, b.BookName, b.Price,i.ImagePath
	Order by sum(ocd.Quatity) DESC
	
)
GO 

select * from BestSellerGenneral()


go

CREATE OR ALTER FUNCTION BestSellerCategory(@bookcategoryName nvarchar(200))
RETURNS TABLE
AS
RETURN
(
    select top(200) b.BookID, b.BookName,b.Price, AVG(cast((r.RatingStar) as float)) as Rating, sum(ocd.Quatity) as quantitysold, i.ImagePath
	from Category c join BookCategory bc on c.CategoryID=bc.CategoryID join Book b on b.BookID=bc.BookID left join OrderDetail ocd on ocd.BookID=b.BookID left join Rating as r on b.BookID=r.BookID join Img as i on i.BookID=b.BookID
	where c.CategoryName=@bookcategoryName
	group by b.BookID, b.BookName, b.Price,i.ImagePath
	Order by sum(ocd.Quatity) DESC
)
GO 

select * from BestSellerCategory(N'Tiểu thuyết')
go

CREATE OR ALTER FUNCTION BestSellerPrice(@lowerBound int, @uperBound int)
RETURNS TABLE
AS
RETURN
(
    select top(200) b.BookID, b.BookName,b.Price, AVG(cast((r.RatingStar) as float)) as Rating, sum(ocd.Quatity) as quantitysold, i.ImagePath
	from Category c join BookCategory bc on c.CategoryID=bc.CategoryID join Book b on b.BookID=bc.BookID left join OrderDetail ocd on ocd.BookID=b.BookID left join Rating as r on b.BookID=r.BookID join Img as i on i.BookID=b.BookID
	where @lowerBound<b.Price and b.Price < @uperBound
	group by b.BookID, b.BookName, b.Price,i.ImagePath
	Order by sum(ocd.Quatity) DESC
	
)
GO 

select* from BestSellerPrice(10000,100000)

go

CREATE OR ALTER FUNCTION BestSellerName(@name nvarchar(2000))
RETURNS TABLE
AS
RETURN
(
    select top(200) b.BookID, b.BookName,b.Price, AVG(cast((r.RatingStar) as float)) as Rating, sum(ocd.Quatity) as quantitysold, i.ImagePath
	from Category c join BookCategory bc on c.CategoryID=bc.CategoryID join Book b on b.BookID=bc.BookID left join OrderDetail ocd on ocd.BookID=b.BookID left join Rating as r on b.BookID=r.BookID join Img as i on i.BookID=b.BookID
	where b.BookName like N'%'+@name+'%'
	group by b.BookID, b.BookName, b.Price,i.ImagePath
	Order by sum(ocd.Quatity) DESC
	
)
GO 

select* from BestSellerName('Thơ')

go

CREATE OR ALTER FUNCTION BestSellerNamePrice(@name nvarchar(2000),@lowerBound int, @uperBound int)
RETURNS TABLE
AS
RETURN
(
    select top(200) b.BookID, b.BookName,b.Price, AVG(cast((r.RatingStar) as float)) as Rating, sum(ocd.Quatity) as quantitysold, i.ImagePath
	from Category c join BookCategory bc on c.CategoryID=bc.CategoryID join Book b on b.BookID=bc.BookID left join OrderDetail ocd on ocd.BookID=b.BookID left join Rating as r on b.BookID=r.BookID join Img as i on i.BookID=b.BookID
	where b.BookName like N'%'+@name+'%' and @lowerBound<b.Price and b.Price < @uperBound
	group by b.BookID, b.BookName, b.Price,i.ImagePath
	Order by sum(ocd.Quatity) DESC
	
)
GO 

select* from BestSellerNamePrice('Thơ',10000,50000)
go

CREATE OR ALTER FUNCTION BestSellerNameCategory(@name nvarchar(200),@bookcategoryName nvarchar(200))
RETURNS TABLE
AS
RETURN
(
    select top(200) b.BookID, b.BookName,b.Price, AVG(cast((r.RatingStar) as float)) as Rating, sum(ocd.Quatity) as quantitysold, i.ImagePath
	from Category c join BookCategory bc on c.CategoryID=bc.CategoryID join Book b on b.BookID=bc.BookID left join OrderDetail ocd on ocd.BookID=b.BookID left join Rating as r on b.BookID=r.BookID join Img as i on i.BookID=b.BookID
	where b.BookName like N'%'+@name+'%' and c.CategoryName=@bookcategoryName
	group by b.BookID, b.BookName, b.Price,i.ImagePath
	Order by sum(ocd.Quatity) DESC
	
)
GO

select* from BestSellerNameCategory('Thơ',N'Thơ')
go

CREATE OR ALTER FUNCTION BestSellerPriceCategory(@lowerBound int, @uperBound int,@bookcategoryName nvarchar(200))
RETURNS TABLE
AS
RETURN
(
    select top(200) b.BookID, b.BookName,b.Price, AVG(cast((r.RatingStar) as float)) as Rating, sum(ocd.Quatity) as quantitysold, i.ImagePath
	from Category c join BookCategory bc on c.CategoryID=bc.CategoryID join Book b on b.BookID=bc.BookID left join OrderDetail ocd on ocd.BookID=b.BookID left join Rating as r on b.BookID=r.BookID join Img as i on i.BookID=b.BookID
	where @lowerBound<b.Price and b.Price < @uperBound and c.CategoryName=@bookcategoryName
	group by b.BookID, b.BookName, b.Price,i.ImagePath
	Order by sum(ocd.Quatity) DESC
)
GO

select* from BestSellerPriceCategory(10000,50000,N'Thơ')
go

CREATE OR ALTER FUNCTION BestSellerNamePriceCategory(@name nvarchar(200),@lowerBound int, @uperBound int,@bookcategoryName nvarchar(200))
RETURNS TABLE
AS
RETURN
(
    select top(200) b.BookID, b.BookName,b.Price, AVG(cast((r.RatingStar) as float)) as Rating, sum(ocd.Quatity) as quantitysold, i.ImagePath
	from Category c join BookCategory bc on c.CategoryID=bc.CategoryID join Book b on b.BookID=bc.BookID left join OrderDetail ocd on ocd.BookID=b.BookID left join Rating as r on b.BookID=r.BookID join Img as i on i.BookID=b.BookID
	where b.BookName like N'%'+@name+'%' and @lowerBound<b.Price and b.Price < @uperBound and c.CategoryName=@bookcategoryName
	group by b.BookID, b.BookName, b.Price,i.ImagePath
	Order by sum(ocd.Quatity) DESC
)
GO

select* from BestSellerNamePriceCategory('Ten sach',10000,50000,N'Thơ')
go


CREATE OR ALTER FUNCTION BookInforSmall(@bookid char(5))
RETURNS TABLE
AS
RETURN
(
    select b.BookID , AVG(cast((r.RatingStar) as float)) as Rating, i.ImagePath, sum(ocd.Quatity) as Sold
	from Book as b join BookCategory as bc on b.BookID=bc.BookID join Category as c on bc.CategoryID=c.CategoryID left join Rating as r on b.BookID=r.BookID join img as i on i.BookID=b.BookID left join OrderDetail ocd on ocd.BookID=b.BookID
	where b.BookID=@bookid
	group by b.BookName, b.BookID,b.AuthorName, b.Description, b.Price, b.Stock,b.NumOfPage,b.PublishingCom,b.ReleaseDate, c.CategoryName, i.ImagePath
)
GO

select * from BookInforSmall('00001')

go

CREATE or ALTER FUNCTION MyCart(@uid char(5))
RETURNS TABLE
AS
RETURN
(
SELECT CD.BookID, CD.Quatity, CD.Price
FROM CartDetail CD
WHERE CD.CustomerID = @uid 
)
GO

select * from MyCart('00001')

go

CREATE or ALTER FUNCTION ViewOrderDetail(@oid char(5))
RETURNS TABLE
AS
RETURN
(
SELECT OD.BookID, OD.Quatity, OD.PriceForDetail, OD.isRating
FROM OrderDetail as OD
WHERE OD.OrderID = @oid
)

GO


select * from ViewOrderDetail('00000')
/*
use master
drop database BookHouseSE
*/
