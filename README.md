# SwiftUISegmentedControlPage
Native Pager + Native SegmentedControl  in SwiftUI

[![Build Status](https://img.shields.io/badge/platforms-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20watchOS-green.svg)](https://github.com/HatsuneMikuV/SwiftUISegmentedControlPage)
[![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.6-blue.svg)](https://developer.apple.com/xcode)
[![Xcode](https://img.shields.io/badge/macOS-15.5-blue.svg)](https://developer.apple.com/macOS)


[English](https://github.com/HatsuneMikuV/SwiftUISegmentedControlPage/blob/master/README_en.md)

### 如下图展示，使用swiftUI实现一个Page + SegmentControl的效果，Page的内容和数据源 可按需更换
## 预览↓↓↓
![](https://github.com/HatsuneMikuV/SwiftUISegmentedControlPage/blob/master/pagedemo.gif)


###  ContentView
**关键点**
>为了保证MySegmentControl和MyPageControlView能实现联动效果，需要用同一个index
```
MySegmentControl(index: self.$index)
MyPageControlView(index: self.$index)
```

###  MySegmentControl

**关键点**
>利用background来计算每个item的宽度和位置，将用于指示器
```
.background (
    GeometryReader { geo in
      Color.clear.onAppear {
        let index = self.model.sections.firstIndex(of: section) ?? 0
        self.frames[index] = geo.frame(in: .global).midX - 11.5
      }
    }
)
```
>显示指示器，指示器可自定义
```
.overlay(self.underline, alignment: .bottomLeading)

var underline: some View {
  Color.red
    .frame(width: 23, height: 5)
    .padding(.leading, self.frames[self.index] ?? 0)
}
```
>item点击切换，同样可自定义为Button
```
.overlay(MoveUnderlineButton(){
  withAnimation {
    self.index = self.model.sections.firstIndex(of: section) ?? 0
  }
})

struct MoveUnderlineButton: View {
  
  let action: () -> Void
  
  var body: some View {
    GeometryReader { geometry in
      Button(action: {
        self.action()
      }) {
        Rectangle().foregroundColor(.clear)
      }
    }
  }
}
```
###  MyPageControlView

**关键点**
>利用content来设定偏移量
```
.content
.offset(x: self.getOffset())

private func getOffset() -> CGFloat {
  if self.oldIndex != self.index {
    DispatchQueue.main.async {
      self.oldIndex = self.index
      self.isUserSwiping = false
    }
  }
  let offset = self.isUserSwiping ? self.offset : CGFloat(self.index) * -APPWidth
  return offset
}

```
>使用DragGesture来，计算用户滑动的位置
```
.gesture(
        DragGesture()
          .onChanged({ value in
            self.isUserSwiping = true
            self.offset = value.translation.width + -APPWidth * CGFloat(self.index)
          })
          .onEnded({ value in
            if (value.translation.width < 0){
              if value.predictedEndTranslation.width < APPWidth / 2, self.index < self.model.sections.count - 1 {
                self.index += 1
              }
            }
            else if (value.translation.width > 0){
              if value.predictedEndTranslation.width > APPWidth / 2, self.index > 0 {
                self.index -= 1
              }
            }
            withAnimation {
              self.isUserSwiping = false
            }
          })
      )
```


## QQ 479069761

##### 欢迎大家补充添加，有问题请联系企鹅号
##### 想获取更多组件，让你的开发更轻松，那赶快加入组件群746954046

## License

SwiftUISegmentedControlPage is released under the MIT license. See [LICENSE](https://github.com/HatsuneMikuV/SwiftUISegmentedControlPage/blob/master/LICENSE) for details.

