import 'package:flutter/material.dart';
import '../data/word_list.dart'; // <--- 1. 방금 만든 데이터 파일 가져오기

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2. 현재 화면에 보여줄 단어 리스트 변수 (처음엔 중학 단어로 시작)
  List<Map<String, dynamic>> currentWords = middleSchoolWords;
  String currentTitle = "중학 필수 단어"; // 현재 제목
  int _filterIndex = 2;

  // 단어장을 바꾸는 함수
  void _changeWordList(String title, List<Map<String, dynamic>> newList) {
    setState(() {
      currentTitle = title;
      currentWords = newList;
    });
    Navigator.pop(context); // 서랍(Drawer) 닫기
  }

List<Map<String, dynamic>> get _filteredWords {
    if (_filterIndex == 1) {
      // 외운 단어만(true) 골라서 리턴
      return currentWords.where((w) => w['isMemorized'] == true).toList();
    } else if (_filterIndex == 2) {
      // 안 외운 단어만(false) 골라서 리턴
      return currentWords.where((w) => w['isMemorized'] == false).toList();
    }
    // 0이면 전체 리턴
    return currentWords;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 3. 제목을 변수로 변경
        title: Text(currentTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo[50],
      ),
      
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text('단어장 목록', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            // 4. 메뉴 클릭 시 단어장 교체 기능 연결
            ListTile(
              title: const Text('중학 필수 단어 (1800)'),
              onTap: () => _changeWordList("중학 필수 단어", middleSchoolWords),
            ),
            ListTile(
              title: const Text('고교 필수 단어 (2200)'),
              onTap: () => _changeWordList("고교 필수 단어", highSchoolWords),
            ),
            ListTile(
              title: const Text('토익 빈출 단어'),
              onTap: () {
                // 토익 데이터는 나중에 추가하면 됨
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          _buildFilterButtons(), // 기존 필터 버튼 유지
          const Divider(height: 1), 

          Expanded(
            child: ListView.builder(
              // 5. words 대신 currentWords 사용
              itemCount: _filteredWords.length,
              itemBuilder: (context, index) {
                final word = _filteredWords[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: CheckboxListTile(
                    title: Text(word['word'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(word['mean']),
                    value: word['isMemorized'],
                    activeColor: Colors.indigo,
                    onChanged: (bool? value) {
                      setState(() {
                        // 1. 일단 상태를 변경해서 리스트에서 사라지게 함
                        word['isMemorized'] = value;
                      });
                      // 2. 만약 '외운 단어'로 체크했다면, 안내 메시지 띄우기
                      if (value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('"${word['word']}" 단어를 외웠어요! 🎉'),
                            duration: const Duration(milliseconds: 1500), // 1.5초 동안만 보여줌
                            action: SnackBarAction(
                              label: '취소', // 실수했을 때 누를 버튼
                              onPressed: () {
                                // 3. 취소 버튼 누르면 다시 원상복구 (안 외운 상태로)
                                setState(() {
                                  word['isMemorized'] = false;
                                });
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ... (필터 버튼 관련 코드는 그대로 두시면 됩니다) ...
  Widget _buildFilterButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _buildActionButton(Icons.search, "검색"),
          const SizedBox(width: 8),
          _buildActionButton(Icons.quiz, "퀴즈"),
          const SizedBox(width: 8),
          const VerticalDivider(width: 20, thickness: 1, color: Colors.grey),
          _buildFilterButton("학습중", 2),
          const SizedBox(width: 8),
          _buildFilterButton("암기 완료", 1),
          const SizedBox(width: 8),
          _buildFilterButton("전체보기", 0),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }

  Widget _buildFilterButton(String label, int index) {
    bool isSelected = _filterIndex == index;
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _filterIndex = index;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? Colors.indigo[100] : null,
        side: BorderSide(color: isSelected ? Colors.indigo : Colors.grey),
      ),
      child: Text(
        label, 
        style: TextStyle(color: isSelected ? Colors.indigo[900] : Colors.black87),
      ),
    );
  }
}