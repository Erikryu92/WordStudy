import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 나중에 진짜 데이터로 교체할 '가짜 데이터(Dummy Data)'
  final List<Map<String, dynamic>> words = [
    {'word': 'Ephemeral', 'mean': '일시적인, 덧없는', 'isMemorized': false},
    {'word': 'Ubiquitous', 'mean': '어디에나 있는', 'isMemorized': true},
    {'word': 'Serendipity', 'mean': '뜻밖의 행운', 'isMemorized': false},
    {'word': 'Eloquent', 'mean': '웅변을 잘하는', 'isMemorized': false},
    {'word': 'Resilience', 'mean': '회복탄력성', 'isMemorized': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 5. 상단 AppBar 설정
      appBar: AppBar(
        title: const Text('나만의 단어장', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo[50],
      ),
      
      // 6. 왼쪽 메뉴 (Drawer - 단어장 목록)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text('단어장 목록', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(title: const Text('토익 필수 단어'), onTap: () { Navigator.pop(context); }),
            ListTile(title: const Text('수능 영단어'), onTap: () {}),
            ListTile(title: const Text('일상 회화'), onTap: () {}),
            
          ],
        ),
      ),

      // 7. 본문 (Body) 설정
      body: Column(
        children: [
          // 상단 기능 버튼들 (검색, 퀴즈, 필터)
          _buildFilterButtons(),
          
          const Divider(height: 1), 

          // 단어 리스트 영역
          Expanded(
            child: ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, index) {
                final word = words[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: CheckboxListTile(
                    title: Text(word['word'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(word['mean']),
                    value: word['isMemorized'],
                    activeColor: Colors.indigo,
                    onChanged: (bool? value) {
                      setState(() {
                        // 체크박스 누르면 상태 변경 및 화면 갱신
                        words[index]['isMemorized'] = value;
                      });
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

  // 상단 필터 버튼을 모아놓은 위젯 함수
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
          _buildFilterButton("전체", true),
          const SizedBox(width: 8),
          _buildFilterButton("외운 단어", false),
          const SizedBox(width: 8),
          _buildFilterButton("안 외운 단어", false),
        ],
      ),
    );
  }

  // 액션 버튼 스타일
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

  // 필터 버튼 스타일
  Widget _buildFilterButton(String label, bool isSelected) {
    return OutlinedButton(
      onPressed: () {},
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