//
//  MyPageControlView.swift
//  SegmentedControlPageDemo
//
//  Created by mbp13 on 2020/7/24.
//  Copyright © 2020 Anglemiku. All rights reserved.
//

import SwiftUI

struct MyPageControlView: View {
  
  @Binding var index: Int
  @EnvironmentObject var model:DataModel
  
  @State private var offset: CGFloat = 0
  @State private var isUserSwiping: Bool = false
  @State private var oldIndex: Int = 0
  
  var body: some View {
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 4)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .center, spacing: 0) {
          ForEach(self.model.sections) { section in
            List {
              ForEach(section.list) { item in
                HStack {
                  Text("section:\(section.title), item:\(item.title)")
                }
              }
            }
            .frame(width: APPWidth)
          }
        }
      }
      .content
      .offset(x: self.getOffset())
      .frame(width: APPWidth, alignment: .leading)
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
        .animation(.spring())
    }
  }
  
  ///解决列表上下滑动时，MySegmentControl 不能切换的问题
  ///Solve the problem that MySegmentControl cannot be switched when the list slides up and down
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
}
