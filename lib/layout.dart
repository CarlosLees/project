import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My AppBar"),
          leading: Container(
            color: Colors.amber,
            child: const Text("leading"),
            alignment: Alignment.center,
          ),
          actions: List.generate(3, (index){
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Icon(Icons.person)
            );
          })
        ),
        body: const Center(
          child: MyTextField(),
        ),

        //bottomNavigationBar中可以使用BottomAppBar
        bottomNavigationBar: const BottomAppBar(
          child: SizedBox(
            height: 30,
          ),
          shape: CircularNotchedRectangle(),
          color: Colors.amber,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}


///页面框架
class MyScaffold extends StatefulWidget {
  const MyScaffold({Key? key}) : super(key: key);

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Flutter",
      theme: ThemeData(
          primaryColor:Colors.orangeAccent
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AppBar"),
        ),
        body: Container(
          color: Colors.amber,
          alignment: Alignment.center,
          child: const Text("Body"),
        ),
        bottomSheet: Container(
          width: double.infinity,
          color: Colors.blue,
          child: const Text("bottomSheet"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.print),label: "打印"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "我的"),
          ],
        ),
        drawer: const SizedBox(
          width: 150,
          child: Drawer(
            child: Center(
              child: SizedBox(
                child: Text("Drawer"),
                width: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///弹出通知 根据Builder创建 可以获取当前的context上下文
///Text.rich配合TextSpan实现一行文字的多段效果
class MySnackBar extends StatefulWidget {
  const MySnackBar({Key? key}) : super(key: key);

  @override
  State<MySnackBar> createState() => _MySnackBarState();
}

class _MySnackBarState extends State<MySnackBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Widget"),
        ),
        body: Builder(
          builder: (ctx){
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
              child: Column(
                children: [
                  Ink(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                        gradient:const LinearGradient(
                            colors: [Colors.orange,Colors.deepOrange,Colors.orangeAccent]
                        )
                    ),
                    child: InkWell(
                      onTap: (){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('这是一个 SnackBar'),
                          backgroundColor: Colors.black26,
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                              label: '我是按钮',
                              onPressed: () {
                                print('点击了按钮');
                              }),
                        ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "确定",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Text.rich(
                      TextSpan(
                          text:'我已阅读并同意遵守',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff999999)
                          ),
                          children: [
                            TextSpan(
                                text: '《服务许可协议》',
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff333333)
                                ),
                            )
                          ]
                      )),
                ],
              ),
            );
          },
        )
      ),
    );
  }
}

/// 使用Stack布局实现滑块滚动效果 获取全局Key 从全局Key中得到屏幕宽高
class ElementMove extends StatefulWidget {
  const ElementMove({Key? key}) : super(key: key);

  @override
  State<ElementMove> createState() => _ElementMoveState();
}

class _ElementMoveState extends State<ElementMove> {
  double _left = 0.0;
  double _top = 0.0;

  double maxWidth = 0.0;
  double maxHeight = 0.0;

  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      maxWidth = (globalKey.currentContext?.size?.width ?? 0.0);
      maxHeight = (globalKey.currentContext?.size?.height ?? 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ElementMove"),
          backgroundColor: Colors.orangeAccent,
        ),
        body: Container(
          child: GestureDetector(
            onPanUpdate: (DragUpdateDetails details){
              setState(() {
                if(_left + 200 > maxWidth) {
                  _left = maxWidth - 200;
                }else if (_left < 0){
                  _left = 0;
                }else{
                  _left += details.delta.dx;
                }

                if(_top + 200 > maxHeight){
                  _top = maxHeight - 200;
                }else if(_top < 0){
                  _top = 0;
                }else{
                  _top += details.delta.dy;
                }
              });
            },
            child: Stack(
              key: globalKey,
              children: [
                Positioned(
                    width: 200,
                    height: 200,
                    left: _left,
                    top: _top,
                    child: Container(
                      color: Colors.redAccent,
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


///使用Container实现一个按钮效果
///要想水波纹效果出现在已设置的颜色上 必须使用InkWell控件在InkWell中实现时间 并且将颜色等设置在InkWell的上层组件Ink的decoration中
///如果要调整Ink的位置等 必须要在Ink外层再包裹一个能修改位置的空间 如Container
class MyTextField extends StatefulWidget {
  const MyTextField({Key? key}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  bool beClick = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Widget"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          child: Ink(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
                gradient:const LinearGradient(
                    colors: [Colors.orange,Colors.deepOrange,Colors.orangeAccent]
                )
            ),
            child: InkWell(
              onTap: (){
                setState(() {
                  beClick = !beClick;
                });
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  beClick?"确定":"取消",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///单选框和复选框
///复选框根据value的值来确定是否选中 true和false
///单选框根据value的值和groupValue的值是否相等来确定是否选中
class BasicControl extends StatefulWidget {
  const BasicControl({Key? key}) : super(key: key);

  @override
  State<BasicControl> createState() => _BasicControlState();
}

class _BasicControlState extends State<BasicControl> {

  bool _beCheck = false;
  int _groupVal = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Widget"),
          backgroundColor: Colors.amber,
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              //多选框
              Row(
                children: [
                  const Text("唱歌"),
                  Checkbox(value: _beCheck, onChanged: (val){
                    setState(() {
                      _beCheck = !_beCheck;
                    });
                  }),
                  Text("$_beCheck")
                ],
              ),
              Row(
                children: [
                  //单选框 value和groupValue相等时 单选框是选中状态
                  const Text("性别"),
                  const Text("男"),
                  Radio(value: 1, groupValue: _groupVal, onChanged: (val){
                    setState(() {
                      _groupVal = val as int;
                    });
                  }),
                  const Text("女"),
                  Radio(value: 2, groupValue: _groupVal, onChanged: (val){
                    setState(() {
                      _groupVal = val as int;
                    });
                  }),
                  Text("$_groupVal")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 栈布局IndexedStack 元素覆盖 可以指定具体哪个元素在最上面 可以做一个选项卡
class MyIndexedStack extends StatefulWidget {
  const MyIndexedStack({Key? key}) : super(key: key);

  @override
  State<MyIndexedStack> createState() => _MyIndexedStackState();
}

class _MyIndexedStackState extends State<MyIndexedStack> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            //第一个元素
            Expanded(
              child: IndexedStack(
                index: _index,
                children: [
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                  Container(
                    color: Colors.green,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () => onClick(0), icon: const Icon(Icons.looks_one),),
                  IconButton(onPressed: () => onClick(1), icon: const Icon(Icons.looks_two),),
                  IconButton(onPressed: () => onClick(2), icon: const Icon(Icons.looks_3),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onClick(index){
    setState(() {
      _index = index;
    });
  }
}

/// GridView创建网格类型列表 3种创建方式
/// count可以指定横轴的数量
/// extent可以指定每个元素大小来根据屏幕大小动态创建
/// build 性能最好的创建方式 可以使用以上两种方式
class MyGridView extends StatefulWidget {
  const MyGridView({Key? key}) : super(key: key);

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {

  List<Color> bgColors = [Colors.red,Colors.green,Colors.blue,Colors.deepPurple];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
        ),
        // body: GridView.count(
        //   crossAxisCount: 3, //每一列的元素个数
        //   crossAxisSpacing: 5, //交叉轴元素之间的间距 默认纵轴为主轴 横轴为交叉轴
        //   mainAxisSpacing: 5, //主轴之间元素的间距
        //   children: List.generate(120, (index){ //12个色块元素
        //     return Container(
        //       color: Colors.green,
        //     );
        //   }),
        // ),
        // body: GridView.extent(
        //   maxCrossAxisExtent: 150,//代表每个元素所占位置大小 会自动根据屏幕大小和所占大小来分配元素个数 动态计算
        //   crossAxisSpacing: 4,
        //   mainAxisSpacing: 4,
        //   children: List.generate(10, (index) {
        //     return Container(
        //       color: Colors.green,
        //     );
        //   })
        // ),

        body: GridView.builder( //性能最好的创建方式 gridDelegate可以使用count和extent两种类型创建
            itemCount: 199,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context,index){
              return Container(
                alignment: Alignment.center,
                color: bgColors[index%4],
                child: Text("$index"),
              );
            }
        ),
      ),
    );
  }
}

/// 创建可滚动列表 ListView 通过ListView.builder创建 性能好
/// ListView.separated 创建分割线
class ListBuilder extends StatefulWidget {
  const ListBuilder({Key? key}) : super(key: key);

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  List<Color> bgColors = [Colors.red,Colors.green,Colors.blue];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          // body: ListView.builder(
          //   itemBuilder: (context, index){
          //     return Container(
          //       height: 60,
          //       color: bgColors[index%3],
          //     );
          // },itemCount: 100)
          body: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  color: bgColors[index%3],
                  height: 50,
                );
              },
              separatorBuilder: (context,index){
                return const Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness:1,
                  height: 1,
                );
              },
              itemCount: 100
          ),
        )
    );
  }
}

/// 基础布局小案例 背景图片
class FoundationLayout2 extends StatefulWidget {
  const FoundationLayout2({Key? key}) : super(key: key);

  @override
  State<FoundationLayout2> createState() => _FoundationLayout2State();
}

class _FoundationLayout2State extends State<FoundationLayout2> {
  bool beShow = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          constraints:const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage("https://println-g1-carlos.oss-cn-qingdao.aliyuncs.com/upload/c.jpeg?OSSAccessKeyId=LTAI4G2yHvcj7ZpeHseBQZdH&Expires=1655217962&Signature=OHjApToos4C6mqyQpEtGWSD%2FcYM%3D")
              )
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("周大侠",style: TextStyle(fontSize: 20),),
                    IconButton(onPressed: (){
                      setState(() {
                        beShow = !beShow;
                      });
                    }, icon: Icon(beShow?Icons.vertical_align_top_sharp:Icons.vertical_align_bottom_sharp))
                  ],
                ),
                Visibility(
                  visible: beShow,
                  child: const Expanded(
                    child: Text("我一脚踢飞一串串红红的葫芦冰糖\n我一拳打飞一幕幕的回忆散在月光\n一截老老的老姜\n一段旧旧的旧时光\n我可以给你们一张签名照拿去想象\n我说啊 屏风就该遮冰霜\n屋檐就该挡月光\n江湖就该开扇窗\n平剧就该耍花枪\n" +
                        "扎下马步我不摇晃\n闷了慌了倦了我就穿上功夫装\n我不卖豆腐（豆腐） 豆腐（豆腐）\n我在武功学校里学的那叫功夫\n功夫（功夫） 功夫（功夫）\n赶紧穿上旗袍\n免得你说我吃你豆腐\n你就像豆腐（豆腐） 豆腐（豆腐）\n吹弹可破的肌肤在试练我功夫\n" +
                        "功夫（功夫） 功夫（功夫）\n赶紧穿上旗袍\n免得你说我吃你豆腐\n我稍微伸展拳脚\n你就滚到边疆\n回旋踢太用力\n画面就变的很荒凉\n落花配对配夕阳\n翻山越岭渡过江\n我清一清嗓\n清一清嗓 唱起秦腔\n飞天飞敦煌 北方北大荒\n谁在水一方我撑起一把纸伞回头望\n" +
                        "啊这什么地方 这什么状况\n啦啦啦啦 闷了慌了倦了我就踩在你肩膀\n我不卖豆腐（豆腐） 豆腐（豆腐）\n我在武功学校里学的那叫功夫\n功夫（功夫） 功夫（功夫）\n赶紧穿上旗袍\n免得你说我吃你豆腐\n你就像豆腐（豆腐） 豆腐（豆腐）\n" +
                        "吹弹可破的肌肤在试练我功夫\n功夫（功夫） 功夫（功夫）\n赶紧穿上旗袍\n免得你说我吃你豆腐\n",style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 15,color: Colors.amber),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 基础布局小案例 手机设置界面
class FoundationLayout1 extends StatefulWidget {
  const FoundationLayout1({Key? key}) : super(key: key);

  @override
  State<FoundationLayout1> createState() => _FoundationLayout1();
}

class _FoundationLayout1 extends State<FoundationLayout1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("基础布局小案例"),
          backgroundColor: Colors.cyan,
        ),
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Container(
                height: 65,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                          Icons.wifi_outlined
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("网络和互联网",style: TextStyle(fontSize: 18)),
                          Text("WALN,移动网络,流量使用",style: TextStyle(color: Colors.grey[600]),
                              overflow: TextOverflow.ellipsis //超出部分以省略号代替
                          )
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_right_alt)
                  ],
                ),
              ),
              Container( //复选框
                height: 65,
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text("设置项1",style: TextStyle(fontSize: 18)),
                    ),
                    Checkbox(value: true, onChanged: (val){

                    })
                  ],
                ),
              ),
              Container( //滑块按钮
                height: 65,
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text("是否开启蓝牙",style: TextStyle(fontSize: 18),),
                    ),
                    Switch(value: true, onChanged: (val){

                    })
                  ],
                ),
              ),
              Container( //滑块按钮
                height: 65,
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text("调节音量",style: TextStyle(fontSize: 18),),
                    ),
                    Slider(value: 10,max: 100,min: 1, onChanged: (val){

                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 使用Container替代Card实现卡片效果 使用层叠布局加水印
class ContainerToCard extends StatelessWidget {
  const ContainerToCard({Key? key}) : super(key: key);
  static const List<String> images = ["https://println-g1-carlos.oss-cn-qingdao.aliyuncs.com/upload/WechatIMG295.jpeg?OSSAccessKeyId=LTAI4G2yHvcj7ZpeHseBQZdH&Expires=1655128453&Signature=StWl6e%2Buuu%2BHI4aZqeN6ZzYI5Lw%3D",
    "https://println-g1-carlos.oss-cn-qingdao.aliyuncs.com/upload/WechatIMG296.jpeg?OSSAccessKeyId=LTAI4G2yHvcj7ZpeHseBQZdH&Expires=1655128492&Signature=ToXPln3klw4WE1%2B5RL4b9f8KB5s%3D"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello"),
          backgroundColor: Colors.cyan,
        ),
        body: Column(
          children: List.generate(2, (index){
            return Container(
              alignment: Alignment.center,
              child: AspectRatio(
                //设置图片的大小和比例
                  aspectRatio: 4/3,
                  child: Stack(
                      fit: StackFit.expand, //设置stack的布局充满
                      children: [
                        Image.network(
                            images[index],
                            fit: BoxFit.cover //填充方式 显示不下多余的剪切掉
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.centerLeft, //如果没有这个属性 container不会占满
                            padding: const EdgeInsets.only(left: 20),
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                            height: 50,
                            child: const Text("宝子真好看",style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 20
                            ),),
                          ),
                        )
                      ]
                  )
              ),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey
                  ),
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.amber,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, //阴影颜色
                        offset: Offset(4,4), //阴影偏移
                        blurRadius: 10 //阴影大小
                    )
                  ]
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Stack 层叠布局 使用Positioned处理相对位置 使用Align调整绝对位置
class MyStackApp extends StatelessWidget {
  const MyStackApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Hello Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello Flutter"),
          backgroundColor: Colors.cyan,
        ),
        body: Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              color: Colors.green,
            ),
            Positioned( //相对位置 可以手抖调整距离各个边框的距离
                right: 0,
                bottom: 0,
                child:Container(
                  width: 150,
                  height: 150,
                  color: Colors.blue,
                )
            ),
            const Align( //绝对位置 只能调整位置 不能设置具体位置大小
              alignment: Alignment.centerRight,
              child: Text("Fox",style: TextStyle(
                  fontSize: 12
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// 根据Container拓展的容器 SizedBox Padding
class MyContainerExtra extends StatefulWidget {
  const MyContainerExtra({Key? key}) : super(key: key);

  @override
  State<MyContainerExtra> createState() => _MyContainerExtraState();
}

class _MyContainerExtraState extends State<MyContainerExtra> {
  List<String> ships = ["倔强青铜","不屈白银","荣耀黄金","尊贵铂金","永恒钻石","至尊星耀","巅峰赛","最强王者","荣耀王者"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My App",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Hello Flutter"),
            backgroundColor: Colors.amber,
          ),
          body: Wrap(
            //列表布局
            children: List.generate(9, (index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                child: Chip(
                  label: Text(ships[index]),
                  deleteIcon: const Icon(Icons.clear),
                  deleteIconColor: Colors.white,
                  onDeleted: (){},
                  elevation: 10,
                  backgroundColor: Colors.cyan,
                ),
              );
            }),
          ),
        )
    );
  }
}

/// 流式布局Wrap 屏幕长度不足自动换行 适合写标签之类的数据
class MyWrap extends StatefulWidget {
  const MyWrap({Key? key}) : super(key: key);

  @override
  State<MyWrap> createState() => _MyWrapState();
}

class _MyWrapState extends State<MyWrap> {
  List<Color> colors = [Colors.red,Colors.blue,Colors.green];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Hello Flutter"),
            backgroundColor: Colors.amber,
          ),
          body: Wrap(
            //屏幕长度不足自动换行 适合写标签之类的数据
            children: List.generate(10, (index){
              return Container(
                margin: const EdgeInsets.only(right: 10),
                width: 80,
                height: 20,
                color: colors[index%3],
              );
            }),
          )
      ),
    );
  }
}

/// 线性布局Row Column
class MyRowColumn extends StatefulWidget {
  const MyRowColumn({Key? key}) : super(key: key);

  @override
  State<MyRowColumn> createState() => _MyRowColumn();
}

class _MyRowColumn extends State<MyRowColumn> {
  List<Color> bgColors = [Colors.red,Colors.green,Colors.blue];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello Flutter"),
          backgroundColor: Colors.amber,
        ),
        body: Container(
          color: Colors.grey,
          child: Row( //主轴默认为横轴的布局 省略了Flex的主轴方向的设置
            //--------元素对齐方式-----------
              mainAxisAlignment: MainAxisAlignment.spaceAround, //主轴对齐方式 主轴的方向根据上面设置的属性为准
              crossAxisAlignment: CrossAxisAlignment.center, //交叉轴的对齐方式
              //------元素顺序--------
              textDirection: TextDirection.ltr, //主轴元素的顺序 ltr左到右 rtl右到左
              verticalDirection: VerticalDirection.up, // 交叉轴元素的方向 up和down两个属性
              //------主轴占用空间--------
              mainAxisSize: MainAxisSize.min, //默认包裹子元素 不会超出子元素 设置此属性时对齐方式属性不会生效
              // mainAxisSize: MainAxisSize.max, //显示全部大小 设置此属性时 对齐方式属性依然有效
              children: List.generate(2, (index){
                return Column(
                  children: List.generate(3, (i){ //使用闭包创建
                    return Container(
                      color: bgColors[i],
                      width: 100,
                      height: 100,
                      child: Text("$i"),
                    );
                  }),
                );
              })
          ),
        ),
      ),
    );

  }
}

/// 线性布局Flex
class MyFlex extends StatefulWidget {
  const MyFlex({Key? key}) : super(key: key);

  @override
  State<MyFlex> createState() => _MyFlex();
}

class _MyFlex extends State<MyFlex> {
  List<Color> bgColors = [Colors.red,Colors.green,Colors.blue];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello Flutter"),
          backgroundColor: Colors.amber,
        ),
        body: Container(
          color: Colors.grey,
          child: Flex(
            direction: Axis.horizontal, //主轴的方向 horizontal为水平方向 此时的主轴为横轴 交叉轴为纵轴
            // direction: Axis.vertical, //此时主轴的方向为垂直方向 主轴为纵轴 交叉轴为横轴

            //--------元素对齐方式-----------
            mainAxisAlignment: MainAxisAlignment.spaceAround, //主轴对齐方式 主轴的方向根据上面设置的属性为准
            /** 主轴的对齐方式
             *  spaceBetween, //两边顶格 中间均分

                spaceAround, //两边有距离 元素之间有距离 距离并不相同 手拉手布局

                spaceEvenly, //等距均分
             */
            crossAxisAlignment: CrossAxisAlignment.center, //交叉轴的对齐方式
            //------元素顺序--------
            textDirection: TextDirection.ltr, //主轴元素的顺序 ltr左到右 rtl右到左
            verticalDirection: VerticalDirection.up, // 交叉轴元素的方向 up和down两个属性

            //------主轴占用空间--------
            mainAxisSize: MainAxisSize.min, //默认包裹子元素 不会超出子元素 设置此属性时对齐方式属性不会生效
            // mainAxisSize: MainAxisSize.max, //显示全部大小 设置此属性时 对齐方式属性依然有效

            children: List.generate(3, (i){ //使用闭包创建Container
              return Container(
                width: 100,
                height: 100,
                color: bgColors[i],
                child: Text("$i"),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// 页面控件
class MyContainer extends StatelessWidget {
  const MyContainer({Key? key}) : super(key: key);
  final String images = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2Ftp09%2F21061109241GT3-0-lp.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1657630645&t=f484d261aa9af4d7f41a7bfa7c8565fc";

  //EdgeInsets不支持国际化 设置左右上下
  //EdgeInsetsDirectional支持国际化 设置开始结束上下

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Learn Flutter"),
          ),
          body: Container(
            child: Image.network(
              images,
            ),
            margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 30), //适合设置左右一样 上下一样的容器
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration( //容器装饰器
                border: Border.all( //边框属性
                    color: Colors.red,
                    width:1, //边框往外扩展
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(20), //边框圆角
                color: Colors.cyan,
                gradient: const LinearGradient( //线性颜色
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green,
                      Colors.pink
                    ]
                )
            ),
          ),
        )
    );
  }
}
