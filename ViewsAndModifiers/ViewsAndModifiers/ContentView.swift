//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by James Chun on 7/28/21.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            //.foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}//End of struct

struct Title: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
}//End of struct

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
    
}//End of extension

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< self.rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    ///below init will create implicit HStacks for us
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
}//End of struct

struct ContentView: View {
    var body: some View {
       
        ZStack {
            Color.orange
                .opacity(0.6)
                .frame(width: 350, height: 600, alignment: .center)
                .cornerRadius(30.0)
                .watermarked(with: "Hacking with Swift")
            
            VStack {
                CapsuleText(text: "first")
                    .foregroundColor(.red)
                CapsuleText(text: "second")
                    .foregroundColor(.yellow)
                Text("Hello World")
                    .modifier(Title())
                Text("Test")
                    .titleStyle()
                    .padding()
                GridStack(rows: 4, columns: 4) { row, column in
                    //HStack {
                        Image(systemName: "\(row * 4 + column).circle")
                        Text("R\(row) C\(column)")
                    //}
                    //.border(Color.black, width: 1)
                }
            }
            
        }
    }
    
}//End of struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}//End of struct
