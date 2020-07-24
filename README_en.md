# SwiftUISegmentedControlPage
Native Pager + Native SegmentedControl  in SwiftUI

[![Build Status](https://img.shields.io/badge/platforms-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20watchOS-green.svg)](https://github.com/HatsuneMikuV/SwiftUISegmentedControlPage)
[![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.6-blue.svg)](https://developer.apple.com/xcode)
[![Xcode](https://img.shields.io/badge/macOS-15.5-blue.svg)](https://developer.apple.com/macOS)


[中文](https://github.com/HatsuneMikuV/SwiftUISegmentedControlPage/blob/master/README.md)

### As shown in the figure below, use swiftUI to achieve the effect of a Page + SegmentControl. The content and data source of the Page can be replaced as needed
## Preview ↓↓↓
![](https://github.com/HatsuneMikuV/SwiftUISegmentedControlPage/blob/master/pagedemo.gif)


###  ContentView
**key point**
>In order to ensure that MySegmentControl and MyPageControlView can achieve the linkage effect, the same index is required
```
MySegmentControl(index: self.$index)
MyPageControlView(index: self.$index)
```

###  MySegmentControl

**key point**
>Use background to calculate the width and position of each item, which will be used for indicator
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
>Display indicator, indicator can be customized
```
.overlay(self.underline, alignment: .bottomLeading)

var underline: some View {
  Color.red
    .frame(width: 23, height: 5)
    .padding(.leading, self.frames[self.index] ?? 0)
}
```
>item click to switch, also can be customized as Button
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

**key point**
>Use content to set the offset
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
>Use DragGesture to calculate the user's sliding position
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


## Contacts

##### email : anglemiku.v@gmail.com

## License

SwiftUISegmentedControlPage is released under the MIT license. See [LICENSE](https://github.com/HatsuneMikuV/SwiftUISegmentedControlPage/blob/master/LICENSE) for details.

