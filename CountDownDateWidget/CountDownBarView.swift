//
//  CountDownBarView.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/2.
//

import SwiftUI

struct CountDownBarView: View {
    
    @Binding var leftDateYear1: Int
    @Binding var leftDateYear2: Float
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 126,height: leftDateYear2>0 ? 21:10)
                .foregroundStyle(Color(red: 0.85, green: 0.85, blue: 0.85))
                .cornerRadius(4)
            Rectangle()
                .frame(width:CGFloat(126*(Float(leftDateYear1)/365.0)),height: leftDateYear2>0 ? 21:10)
                .foregroundStyle(Color.orange)
                .cornerRadius(4)
            HStack(alignment: .top, spacing: 10) {
                ForEach(0..<11){i in
                    Rectangle()
                        .frame(width: 1,height: 5)
                        .cornerRadius(1)
                        .foregroundStyle(Color.gray)
                }
            }
            
        }.frame(width: 126,height: leftDateYear2>0 ? 21:10)
    }
}

#Preview {
    CountDownBarView(leftDateYear1: .constant(140), leftDateYear2: .constant(0))
}
