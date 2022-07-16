//
//  OffsetModifier.swift
//  CollapsableHeader
//
//  Created by Nawin Poolsawad on 16/7/2565 BE.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    let coordinateSpace: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            GeometryReader { proxy in
                let offset = proxy.frame(in: .named(self.coordinateSpace)).minY
                Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
            }
        }
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            self.offset = value
        }
    }
}


struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
    typealias Value = CGFloat

}
