//
//  ToDoTimeLine.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/14.
//

import SwiftUI
import Foundation

struct ToDoTimeLine: View {

    
    @State var addToDo: Bool = false
    @State var toDoName: String = ""
        
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack() {
                    SmallWeekCalendar()
                        .frame(width: geo.size.width)
                        .padding(.top,12)
                }.navigationTitle("待辦事項")
                Button(action: {
                    addToDo.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color(red: 1, green: 0.53, blue: 0.34), .white)
                        .frame(height: 80)
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 2, y: 2)
                }).position(CGPoint(x: geo.size.width/2, y: geo.size.height*0.9))
                    .sheet(isPresented: $addToDo) {
                        VStack() {
                            HStack {
                                Text("新增待辦事項")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .padding(.top)
                                Spacer()
                                Button("新增") {
                                    addToDo.toggle()
                                }
                            }.padding(.horizontal)
                            Spacer()
                                .frame(height: 10)
                            HStack{
                                Image(systemName: "text.badge.plus")
                                TextField("請輸入待辦標題", text: $toDoName)
                                    .textFieldStyle(.roundedBorder)
                                    .presentationDetents([.medium])
                            }.padding(.horizontal)
                            Spacer()
                        }.padding(.top,0)
                    }
            }.background(Color(red: 0.95, green: 0.9, blue: 0.87))
        }
    }
    
}

struct SmallWeekCalendar: View {
        
    let calendar = Calendar.current
    let weekName:[String] = ["週日","週一","週二","週三","週四","週五","週六"]
    
    @State var select: Int = 3
    @State var today: Int = 0
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<7) { i in
                VStack {
                    Text(weekName[i])
                        .font(.system(size: 10))
                        .fontWeight(.semibold)
                    Button(action: {
                        select = i
                    }, label: {
                        if select != i {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 40, height: 45)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 1.5)
                                            .stroke(i == today ? Color(red: 0.2, green: 0.3, blue: 0.5):Color(red: 0.6, green: 0.66, blue: 0.79), lineWidth: 3)
                                    )
                                VStack(alignment: .center) {
                                    Text(convertDateToNongLi(aStrDate: dateFor(i)))
                                        .font(.system(size: 8))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(red: 0.2, green: 0.3, blue: 0.5))
                                    Text(formatterDate(dateFor(i)))
                                        .font(.system(size: 20, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(red: 0.2, green: 0.3, blue: 0.5))
                                }.padding(.top, 3)
                            }
                        } else {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 40, height: 45)
                                    .background(Color(red: 0.2, green: 0.3, blue: 0.5))
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.25), radius: 3, x: 4, y: 4)
                                VStack(alignment: .center) {
                                    Text(convertDateToNongLi(aStrDate: dateFor(i)))
                                        .font(.system(size: 8))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(red: 0.95, green: 0.9, blue: 0.87))
                                    Text(formatterDate(dateFor(i)))
                                        .font(.system(size: 20, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(red: 0.95, green: 0.9, blue: 0.87))
                                }.padding(.top, 3)
                            }
                        }
                    })
                }
            }
        }.onAppear {
            let today = Date()
            let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: today)
            select = dateComponents.weekday! - 1
        }
    }
    
    func formatterDate(_ day:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: day)
    }
    
    func convertDateToNongLi(aStrDate:Date)-> String{
        let cDayName:[String] = [
            "初一","初二","初三", "初四", "初五",
            "初六", "初七", "初八", "初九", "初十",
            "十一", "十二", "十三", "十四", "十五",
            "十六", "十七", "十八", "十九", "二十",
            "廿一", "廿二", "廿三", "廿四", "廿五",
            "廿六", "廿七", "廿八", "廿九", "三十"
        ]
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.chinese)
        guard let  d = calendar?.components(.day, from: aStrDate).day else {return ""}
        
        let dStr = cDayName[d - 1]
        
        return dStr
    }
    
    func dateFor(_ offset: Int) -> Date {
        return calendar.date(byAdding: .day, value: offset, to: startOfWeek()) ?? Date()
    }
    
    func startOfWeek() -> Date {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        return calendar.date(from: components) ?? Date()
    }
    
    func formatterWeekDate(_ day:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: day)
    }
}

#Preview {
    ToDoTimeLine()
}
