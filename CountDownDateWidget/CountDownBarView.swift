//
//  CountDownBarView.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/3.
//

import SwiftUI

struct CountDownBarView: View {
    
    @Binding var targetDate: Date {
        didSet {
            leftDateYear1 = getCountDownNum(targetDate: targetDate, lineNum: 1)
            leftDateYear2 = getCountDownNum(targetDate: targetDate, lineNum: 2)
        }
    }
    @State var leftDateYear1: Int = 0
    @State var leftDateYear2: Int = 0
    @State var startDistYear1: Int = 0
    @State var startDistYear2: Int = 0
    @State var haveDoubleLine: Bool = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 126,height: leftDateYear2>0 ? 21:10)
                .foregroundStyle(Color(red: 0.85, green: 0.85, blue: 0.85))
                .cornerRadius(4)
            Rectangle()
                .frame(width:CGFloat(126*(Float(leftDateYear2)/365.0)),height: 10)
                .foregroundStyle(Color.orange)
                .cornerRadius(4)
                .position(x:CGFloat(126*(Float(startDistYear2+leftDateYear2/2)/365.0)),y:5)
            Rectangle()
                .frame(width:CGFloat(126*(Float(leftDateYear1)/365.0)),height: 10)
                .foregroundStyle(Color.orange)
                .cornerRadius(4)
                .position(x:CGFloat(126*(Float(startDistYear1+leftDateYear1/2)/365.0)),y:haveDoubleLine ? 15.5 : 10)
            VStack(spacing:2){
                HStack(alignment: .top, spacing: 10) {
                    ForEach(0..<11){i in
                        Rectangle()
                            .frame(width: 1,height: 5)
                            .cornerRadius(1)
                            .foregroundStyle(Color.gray)
                    }
                }
                
                if leftDateYear2 > 0 {
                    Rectangle()
                        .frame(width: 120,height: 1)
                        .cornerRadius(1)
                        .foregroundStyle(Color.gray)
                    HStack(alignment: .top, spacing: 10) {
                        ForEach(0..<11){i in
                            Rectangle()
                                .frame(width: 1,height: 5)
                                .cornerRadius(1)
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
            }
            VStack(alignment:.leading, spacing:0){
                Image(systemName: "flag.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:8)
                    .foregroundStyle(Color.red)
                Line()
                    .stroke(style: .init(dash: [2]))
                    .foregroundStyle(Color.red)
                    .frame(width:1, height:10)
                
            }.position(x:startDistYear2>0 ? CGFloat(126*(Float(startDistYear2)/365.0)+3.5):CGFloat(126*(Float(startDistYear1)/365.0)+3.5),y:startDistYear2>0 ? 0:5)
            
        }.frame(width: 126,height: leftDateYear2>0 ? 21:21)
        .onAppear{
            leftDateYear1 = getCountDownNum(targetDate: targetDate, lineNum: 1)
            leftDateYear2 = getCountDownNum(targetDate: targetDate, lineNum: 2)
            if leftDateYear2>0 {
                haveDoubleLine = true
            } else {
                haveDoubleLine = false
            }
            startDistYear1 = getStartDistNum(targetDate: targetDate, lineNum: 1, haveLine2: haveDoubleLine)
            startDistYear2 = getStartDistNum(targetDate: targetDate, lineNum: 2, haveLine2: haveDoubleLine)
            print("------------")
            print(leftDateYear1)
            print(leftDateYear2)
            print(startDistYear1)
            print(startDistYear2)
        }
    }
    
    func getCountDownNum(targetDate: Date, lineNum: Int) -> Int {
        let dateForatter = DateFormatter()
        dateForatter.dateFormat = "yyyy"
        let dateYear = Int(dateForatter.string(from: targetDate))
        let nowYear = Int(dateForatter.string(from: .now))
        if nowYear == dateYear {
            if lineNum == 1 {
                let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate)
                return Int(days.day!)
            } else {
                return 0
            }
        } else if dateYear!-nowYear! == 1 {
            if lineNum == 1 {
                let endOfYear = DateComponents(calendar: .current, year: nowYear, month:12, day: 31).date!
                let days = Calendar.current.dateComponents([.day], from: .now, to: endOfYear)
                return Int(days.day!)
            } else if lineNum == 2 {
                let startOfYear = DateComponents(calendar: .current, year: dateYear, month:1, day: 1).date!
                let days = Calendar.current.dateComponents([.day], from: startOfYear, to: targetDate)
                return Int(days.day!)
            }
        }
        
        return 367
    }
    
    func getStartDistNum(targetDate: Date, lineNum: Int, haveLine2: Bool) -> Int {
        let dateForatter = DateFormatter()
        dateForatter.dateFormat = "yyyy"
        let dateYear = Int(dateForatter.string(from: targetDate))
        let nowYear = Int(dateForatter.string(from: .now))
        
        if haveLine2 {
            if lineNum == 1 {
//                let days = Calendar.current.dateComponents([.day], from: .now, to: DateComponents(calendar: .current, year: nowYear, month:12, day: 31).date!)
                return 0
            } else {
                let days = Calendar.current.dateComponents([.day], from: targetDate, to: DateComponents(calendar: .current, year: dateYear, month:12, day: 31).date!)
                return Int(days.day!)
            }
            
        } else {
            if lineNum == 1 {
                let days = Calendar.current.dateComponents([.day], from: targetDate, to: DateComponents(calendar: .current, year: nowYear, month:12, day: 31).date!)
                return Int(days.day!)
            } else {
                return 0
            }
            
        }
    }
}
//
//#Preview {
//    static var previews: some View {
//            let customDate = DateComponents(calendar: .current, year: 2024, month: 3, day: 4).date!
//
//            return CountDownBarView(targetDate: .constant(customDate))
//                .environment(\.locale, Locale(identifier: "en_US"))
//        }
//
////    CountDownBarView(targetDate: .constant(.now))
//}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
            let customDate = DateComponents(calendar: .current, year: 2023, month:12, day: 27).date!
            
            return CountDownBarView(targetDate: .constant(customDate))
        }
}
