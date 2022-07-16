//
//  ContentView.swift
//  Shared
//
//  Created by Nawin Poolsawad on 16/7/2565 BE.
//

import SwiftUI

struct ContentView: View {
    let maxHeightHeader: CGFloat = 300
    let minHeightHeader: CGFloat = 80
    let gfImageURL: URL = URL(string: "https://scontent.fbkk28-1.fna.fbcdn.net/v/t39.30808-6/292002760_741990463747374_4361991751707384254_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=8bfeb9&_nc_eui2=AeFRciWIFTAvSe4m9zh0NN9UXatZClHdcoJdq1kKUd1ygtYV4afBjDKsPUxVdw4LqnkveCde9zQKPRaFJegA9zrR&_nc_ohc=5BQGk1iVeygAX9gK9Go&_nc_ht=scontent.fbkk28-1.fna&oh=00_AT8yf1ghtFJER1q65_NrilzhqhpFN2wO7vUC7_RIan9VQA&oe=62D87345")!
    @State var offset: CGFloat = 0
    
    
    var body: some View {
        return (
            ZStack(alignment: .top) {
                GeometryReader { mainProxy in
                    ScrollView(showsIndicators: false) {
                        /// Header
                        VStack {
                            GeometryReader { proxy in
                                VStack {
                                    HStack(spacing: 12) {
                                        getGFImage()
                                        VStack(alignment: .leading) {
                                            Text("Sureewan Pantasoot")
                                                .bold()
                                                .font(.system(size: 24))
                                            Text("My lovely angle")
                                                .foregroundColor(.white)
                                                .font(Font.system(size: 18))
                                                .fontWeight(.thin)
                                        }
                                    }
                                    .padding(.bottom, 24)
                                    .opacity(getHeaderOpacity())
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: getHeaderHeight(), alignment: .bottom)
                                .background { Color.blue }
                                .clipShape(RoundedCorner(radius: getCornerRadius(), corners: .bottomRight))
                            }
                            .frame(height: maxHeightHeader)
                            .offset(y: -offset)
                            
                            
                            /// Random content
                            ForEach((0..<20)) { index in
                                HStack {
                                    Text("\(index)")
                                }
                                .frame(height: 50)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding(.horizontal, 10)
                            }
                            .zIndex(-1)
                        }
                        .modifier(OffsetModifier.init(offset: $offset, coordinateSpace: "SCROLL"))
                    }
                    .coordinateSpace(name: "SCROLL")
                }.ignoresSafeArea()
                
                VStack {
                    Text("SureeWan Pantasoot")
                        .opacity(1 - getHeaderOpacity())
                }
            }
        )
    }
    
    @ViewBuilder
    func getGFImage() -> some View {
        AsyncImage(
            url: gfImageURL,
            content: { image in
                image.resizable()
                     .aspectRatio(contentMode: .fill)
                     .overlay {
                         Circle()
                             .stroke(.white, style: StrokeStyle(lineWidth: 5))
                     }
                     .clipShape(Circle())
            },
            placeholder: {
                ProgressView()
            }
        ).frame(width: 60, height: 60)
    }
    
    func getHeaderOpacity() -> Double {
        let opacity = 1 - ( -offset / 60)
        
        return opacity
    }
    
    func getCornerRadius() -> CGFloat {
        let progress = 1 - ( -offset / 100 )
        let realProgress = progress < 0 ? 0 : progress
        let cornerRadius = realProgress * 48
        return cornerRadius
        
    }
    
    func getHeaderHeight() -> CGFloat {
        let height = ( maxHeightHeader + offset) > 0 ? maxHeightHeader + offset : 0
        if height < minHeightHeader {
            return minHeightHeader
        } else {
            return height
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
