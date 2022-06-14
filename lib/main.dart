import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ListBuilder());
}

/// 创建可滚动列表 ListView 通过ListView.builder创建 性能好
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
          constraints:BoxConstraints.expand(),
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

/// Stack 层叠布局
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
