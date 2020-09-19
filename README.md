# flutter_brunch_challenge

這是 Flutter Brunch 現場小挑戰活動 使用的初始專案，
從 2020/08/29 開始。


## Flutter Brunch 2020/09 小挑戰

8月小挑戰我們練習了一些基本 Widget，最後兜岀一個有首頁 Drawer 的畫面，    
這次來玩小遊戲吧！    
來挑戰社團分享中，有蠻多留言，也有人跟著做了分享出來的 PACMAN！    
原作者實作影片連結（長度約 45 分鐘）：     
https://www.youtube.com/watch?v=PbIlXoijRvM      
    
這次小挑戰的實作頁面位置在 lib/ui/pacman/pacman_screen.dart，    
（範例在 branch feature/20200919_pacman_sample）    
TODO 畫面  和 完成後畫面 如下：    
<img src="https://github.com/flutterTaipei/FlutterBrunchChallenge/blob/feature/20200919_pacman/readme/challenge202009/20200919_pacman_todo_1.gif" width="300">
<img src="https://github.com/flutterTaipei/FlutterBrunchChallenge/blob/feature/20200919_pacman/readme/challenge202009/20200919_pacman_done.gif" width="300">

#### 最終樣貌
<img src="https://github.com/hl3hl3/FlutterBrunchChallenge/blob/feature/20200919_pacman/readme/challenge202009/20200919_pacman_0_final.png" width="600">
需要處理的大致有：

- 作為地圖的表格
- 地圖上的元素
- 供操作的角色      

#### 1. 先做出地圖    
<img src="https://github.com/hl3hl3/FlutterBrunchChallenge/blob/feature/20200919_pacman/readme/challenge202009/20200919_pacman_1_map.png" width="600">
Tips：

- 使用 GridView 顯示表格
- 宣告 numberInRow 紀錄一行中要顯示幾格
- 宣告 numberOfSquares 紀錄整個 Grid 總共要顯示幾格
- 宣告 barrierList 紀錄路障的位置
- GridView 產 widget 時，可以走的路徑 和 路障，顯示不同 widget

#### 2. 調整地圖顯示元素    
<img src="https://github.com/hl3hl3/FlutterBrunchChallenge/blob/feature/20200919_pacman/readme/challenge202009/20200919_pacman_2_barrier.png" width="600">    
<img src="https://github.com/hl3hl3/FlutterBrunchChallenge/blob/feature/20200919_pacman/readme/challenge202009/20200919_pacman_3_map_ui.png" width="600">
<img src="https://github.com/hl3hl3/FlutterBrunchChallenge/blob/feature/20200919_pacman/readme/challenge202009/20200919_pacman_4_path.png" width="600">
Tips：

- 抽出 顯示路障用的 Widget
- 抽出 顯示路徑用的 Widget

#### 3. 加上角色和動作！可以玩啦！！
<img src="https://github.com/hl3hl3/FlutterBrunchChallenge/blob/feature/20200919_pacman/readme/challenge202009/20200919_pacman_5_player.png" width="600">
Tips：

- 加入角色使用的圖檔
- 宣告變數紀錄角色目前的位置
- 新增 點擊後能開始遊戲的按鈕事件
- 使用 Timer.periodic 定時更新內容
- 往右走 = 只要不撞到路障，即可角色位置 index + 1 後 setState
- 透過手勢操作改變角色行進方向，使用 GestureDetecture，onVerticalDragUpdate、onHorizontalDragUpdate (宣告一個變數紀錄要走的方向）
- 往左走 = 角色 index - 1
- 往上走 = index - numberInRow
- 往下走 = index + numberInRow
- 讓角色跟著行進方向轉動（Transform.rotate，angle 可用 pi & pi/2 兜出來）
- 宣告一個 List 紀錄有食物的路徑，並判斷角色 index 與食物的位置相符時，移除 List 中的食物（代表吃掉了）

還有 Ghost 的部分，不過到了這邊，也差不多可以玩啦！！    
    
    
    

# 過去的小挑戰
## Flutter Brunch 2020/08 小挑戰
#### 1. Widget 練習：Drawer
- 幫頁面加上 Drawer。參考： https://flutter.dev/docs/cookbook/design/drawer
- 可能用到的 Widget：Drawer、ListView、DrawerHeader、ListTile、Text、Icon、BoxDecoration
<img src="https://github.com/hl3hl3/FlutterBrunchChallenge/blob/develop/readme/challenge_202008_3.png" width="300">

#### 2. 動畫練習：幫 App 介紹區塊加上動畫效果
- 參考：https://flutter.dev/docs/cookbook/animation/opacity-animation
- 先把所在 Widet 轉成 StatefulWidget
- 幫介紹區塊加上點擊事件
- 點擊時修改狀態並 setState

#### 3. 點擊開啟 Drawer
- 宣告一個型別為 GlobalKey<ScaffoldState> 的變數，建議名稱：_scaffoldKey
- 將 Scaffold 的 key 設定為宣告的 _scaffoldKey
- 幫 小挑戰區塊文字 加上點擊事件（用 GestureDetector？ 或整塊換成 RaisedButton? 或其他？）
- 點擊事件中  `_scaffoldKey.currentState.openDrawer();` 
- setState()   
<img src="https://github.com/hl3hl3/FlutterBrunchChallenge/blob/develop/readme/challenge_202008_0.gif" width="300">
  
#### 4. 換成自己喜歡的顏色吧！
<img src="https://github.com/hl3hl3/FlutterBrunchChallenge/blob/develop/readme/challenge_202008_2.png" width="300">
