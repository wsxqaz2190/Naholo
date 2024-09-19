// diary_writing.dart
import 'package:flutter/material.dart';
import 'diary_text.dart'; // 나홀로일지 글 상세보기
import 'package:flutter_application_1/size_scaler.dart'; // 크기 조절

class DiaryWriting extends StatefulWidget {
  @override
  _DiaryWritingState createState() => _DiaryWritingState();
}

class _DiaryWritingState extends State<DiaryWriting> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 페이지 배경색을 하얀색으로 설정
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: SizeScaler.scaleSize(context, 25, 50),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black, size: SizeScaler.scaleSize(context, 10, 20)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            '일지 작성',
            style: TextStyle(
              fontSize: SizeScaler.scaleSize(context, 8, 16),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.only(right: SizeScaler.scaleSize(context, 8, 16)),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // 작성 버튼 눌렀을 때의 동작
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiaryText(
                        postTitle: _titleController.text,
                        postContent: _contentController.text,
                        author: '작성자', // 작성자를 고정값으로 설정
                        createdAt: DateTime.now(), // 현재 시간을 작성 시간으로 설정
                      ),
                    ),
                  );
                },
                child: Text(
                  '작성',
                  style: TextStyle(
                    fontSize: SizeScaler.scaleSize(context, 8, 16),
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(SizeScaler.scaleSize(context, 0.5, 1)),
          child: Container(
            color: const Color(0xFFBABABA), // 구분선 색상
            height: SizeScaler.scaleSize(context, 0.5, 1), // 구분선 두께
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: SizeScaler.scaleSize(context, 11, 22),
                  top: SizeScaler.scaleSize(context, 3, 6),
                  bottom: SizeScaler.scaleSize(context, 3, 6)),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: '제목을 입력하세요.',
                  hintStyle: TextStyle(
                      color: const Color(0xFFABABAB),
                      fontSize: SizeScaler.scaleSize(context, 11, 22),
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
              ),
            ),
            // 제목 입력창 아래의 구분선
            Container(
              color: const Color(0xFFBABABA), // 구분선 색상
              height: SizeScaler.scaleSize(context, 0.5, 1), // 구분선 두께
            ),
            // 주제 선택란
            Padding(
              padding:
                  EdgeInsets.all(SizeScaler.scaleSize(context, 11, 22), ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '주제를 선택하세요!',
                      style: TextStyle(
                        fontSize: SizeScaler.scaleSize(context, 5, 10),
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeScaler.scaleSize(context, 8, 16)),
                  Wrap(
                    spacing: SizeScaler.scaleSize(context, 5, 10), // 버튼 사이 간격
                    runSpacing: SizeScaler.scaleSize(context, 5, 10), // 줄 간격
                    children: [
                      '# 혼캎',
                      '# 혼영',
                      '# 혼놀',
                      '# 혼밥',
                      '# 혼박',
                      '# 혼술',
                      '# 기타'
                    ].map((topic) {
                      return ElevatedButton(
                        onPressed: () {
                          // 버튼 클릭 시 동작
                        },
                        child: Text(
                          topic,
                          style: TextStyle(
                            fontSize: SizeScaler.scaleSize(context, 7, 14),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // 버튼 배경색
                          foregroundColor: Color(0xFF646464), // 버튼 텍스트 색
                          padding: EdgeInsets.zero, // 내부 패딩 제거
                          minimumSize: Size(
                            SizeScaler.scaleSize(context, 40, 80), // 버튼 크기
                            SizeScaler.scaleSize(context, 18, 36),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SizeScaler.scaleSize(context, 33, 66), // 둥글기 정도
                            ),
                            side: BorderSide(
                              color: Color(0xFF646464), // 윤곽선 색상
                              width: SizeScaler.scaleSize(context, 0.3, 0.6), // 윤곽선 두께
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // 주제 선택란 아래의 구분선
            Container(
              color: const Color(0xFFBABABA), // 구분선 색상
              height: SizeScaler.scaleSize(context, 0.5, 1), // 구분선 두께
            ),
            // 내용 입력 부분
            Padding(
              padding:
                  EdgeInsets.only(left: SizeScaler.scaleSize(context, 11, 22)),
              child: TextField(
                controller: _contentController,
                maxLines: null, // 제한 없는 줄 수
                decoration: InputDecoration(
                  hintText: '내용을 입력하세요.',
                  hintStyle: TextStyle(
                      color: const Color(0xFFABABAB),
                      fontSize: SizeScaler.scaleSize(context, 7, 14),
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
