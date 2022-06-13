import 'package:flutter/material.dart';

void main() {
  runApp(const ContainerToCard());
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
