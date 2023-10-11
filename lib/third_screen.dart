import 'package:flutter/material.dart';
import '4_screen.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('投稿する'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9, // 幅を制限する
                height: MediaQuery.of(context).size.height * 0.5, // 高さを制限する
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          '注意事項',
                          style: TextStyle(fontSize: 50, color: Colors.red),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'スクロールで表示',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '↓',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '1.個人情報の投稿の禁止',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '自動販売機の画像を投稿する際には、誰でもが確認できる範囲のものに限ります。例えば、顔や氏名、電話番号などの特定される恐れのある個人情報は絶対に投稿しないようにしましょう。',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '2.誹謗中傷の禁止',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '投稿する際には、敬語やマナーを守って投稿するようにしましょう。また、他人を中傷したり、差別的な発言を行ったりすることは絶対にやめましょう。',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '3.迷惑行為の禁止',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '自動販売機に対して迷惑行為を行うことは、法律に違反する可能性があるので絶対にやめましょう。',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                ),
                child: Text(
                  '投稿する',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForScreen()),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
