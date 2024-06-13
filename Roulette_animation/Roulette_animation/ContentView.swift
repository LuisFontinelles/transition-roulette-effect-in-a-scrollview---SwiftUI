//
//  ContentView.swift
//  Roulette_animation
//
//  Created by luis fontinelles on 12/06/24.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red,.blue,.green, .yellow, .cyan]
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(colors.indices, id: \.self) { index in
                        ZStack{
                            Circle()
                                .frame(width: size.width, height: size.height)
                                .foregroundStyle(colors[index])
                            Text(String(index + 1))
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                        .anchorPreference(key: ScrollPreferenceKey.self, value: .bounds) {
                            [index: $0]
                        }
                        .visualEffect { view, proxy in
                            view
                                .offset(offsetRoulette(proxy, size: size))
                                .rotationEffect(Angle(degrees: -rotation(proxy)), anchor: .center)
                        }
                    }
                }
            }
            .background(.black)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)

        }
        .ignoresSafeArea()
    }
    
    private func offsetRoulette(_ proxy: GeometryProxy, size: CGSize) -> CGSize {
        let progress = progress(proxy)
        return CGSize(width: progress < 0 ? progress * -size.height : progress * -size.height,
                      height: progress < 0 ? progress * -size.width : progress * size.width)
    }
    private func rotation(_ proxy: GeometryProxy) -> CGFloat {
        let progress = progress(proxy)
        return progress < 0 ? progress * 90 :  progress * 90
    }
    private func progress(_ proxy: GeometryProxy) -> CGFloat {
        let viewWidth = proxy.size.width
        let minX = proxy.bounds(of: .scrollView)?.minX ?? 0
        return minX / viewWidth
    }
}

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: Anchor<CGRect>] = [:]
    static func reduce(value: inout [Int: Anchor<CGRect>], nextValue: () -> [Int: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

#Preview {
    RoulleteScrollView()
}


import SwiftUI

struct RoulleteScrollView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .cyan]
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(colors.indices, id: \.self) { index in
                        ZStack {
                            Circle()
                                .frame(width: size.width, height: size.height)
                                .foregroundStyle(colors[index])
                            Text(String(index + 1))
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                        .anchorPreference(key: ScrollPreferenceKey.self, value: .bounds) {
                            [index: $0]
                        }
                        .visualEffect { view, proxy in
                            view
                                .offset(offsetRoulette(proxy, size: size))
                                .rotationEffect(Angle(degrees: -rotation(proxy)), anchor: .center)
                        }
                    }
                }
            }
            .background(.black)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
        }
        .ignoresSafeArea()
    }

    private func offsetRoulette(_ proxy: GeometryProxy, size: CGSize) -> CGSize {
        let progress = progress(proxy)
        return CGSize(width: progress < 0 ? progress * -size.height : progress * -size.height,
                      height: progress < 0 ? progress * -size.width : progress * size.width)
    }

    private func rotation(_ proxy: GeometryProxy) -> CGFloat {
        let progress = progress(proxy)
        return progress < 0 ? progress * 90 : progress * 90
    }

    private func progress(_ proxy: GeometryProxy) -> CGFloat {
        let viewWidth = proxy.size.width
        let minX = proxy.bounds(of: .scrollView)?.minX ?? 0
        return minX / viewWidth
    }
}
