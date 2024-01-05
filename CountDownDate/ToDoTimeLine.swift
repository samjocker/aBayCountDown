//
//  ToDoTimeLine.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/14.
//

import SwiftUI
import SwiftData
import WidgetKit

struct ToDoTimeLine: View {
    
    @Environment(\.modelContext) private var context
    
    @AppStorage("todayToDoList", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var todayToDoList: String = ""
    
//    @State var todayToDoString: String = ""
    @State var addToDo: Bool = false
    @State var whichChoice: Bool = true
    @State var toDoName: String = ""
    @State var selectDay: String = "2023/12/01"
    @State var selectDayMonth: String = "12"
    @State var delectThing: Bool = false
    @State var haveThing: [Int] = [0, 0]
    @State var todayDate: String = ""
    @State var outOfLength: Bool = false
    @State var tapState: [Bool] = [false]
    @Query var dataBox: [DataFormat]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack() {
                    SmallWeekCalendar(selectDay: $selectDay, selectDayMonth: $selectDayMonth, havething: $haveThing, todayDate: $todayDate)
                        .frame(width: geo.size.width)
                        .padding(.top,12)
                    Spacer()
                        .frame(height: 15)
                    
                    ZStack {
                        if haveThing == [0, 0] {
                            VStack {
                                Spacer()
                                Text("今日尚無待辦，新增一些吧!")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(red: 0.4, green: 0.4, blue: 0.4))
                                    .frame(width: geo.size.width ,alignment: .center)
                                Spacer()
                                Spacer()
                            }
                        }
                        VStack(alignment: .leading) {
                            if haveThing != [0, 0] {
                                HStack {
                                    VStack {
                                        Button(action: {
                                            whichChoice = true
                                        }, label: {
                                            Text("待完成")
                                                .font(.system(size: 24))
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color.black)
                                        }).padding(.bottom,-2)
                                        
                                        Rectangle()
                                            .frame(width:72, height: 4)
                                            .cornerRadius(2)
                                            .foregroundStyle(whichChoice ? Color.accentColor : Color.clear)
                                            .padding(.top,-2)
                                    }
                                    Spacer()
                                        .frame(width: 18)
                                    VStack {
                                        Button(action: {
                                            whichChoice = false
                                        }, label: {
                                            Text("已完成")
                                                .font(.system(size: 24))
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color.black)
                                        }).padding(.bottom,-2)
                                        
                                        Rectangle()
                                            .frame(width:72, height: 4)
                                            .cornerRadius(2)
                                            .foregroundStyle(!whichChoice ? Color.accentColor : Color.clear)
                                            .padding(.top,-2)
                                    }
                                }.frame(width: geo.size.width)
                            }
                            
//                            if haveThing[0] > 0 || haveThing[1] > 0 {
//                                Text("待完成")
//                                    .font(.system(size: 22))
//                                    .fontWeight(.bold)
//                                    .foregroundStyle(Color.black)
//                                    .padding(.leading)
//                            }
                            ZStack {
                                ScrollView {
                                    VStack(spacing: 4) {
                                        ForEach(dataBox.filter{ $0.thingDate == selectDay && $0.thingState == true}, id: \.self) { dataItem in
                                            ToDoCheck(dataItem: .constant(dataItem), haveThing: $haveThing)
                                                .onAppear {
                                                    haveThing[0] += 1
                                                    todayToDoList = updateWidget()
                                                    WidgetCenter.shared.reloadTimelines(ofKind: "CountDownDateWidget")
                                                }
                                                .onDisappear {
                                                    todayToDoList = updateWidget()
                                                    WidgetCenter.shared.reloadTimelines(ofKind: "CountDownDateWidget")
                                                }
                                        }
                                    }
                                }.opacity(whichChoice ? 1.0 : 0.0)
                                .frame(width:geo.size.width)
                                if haveThing[0] == 0 && haveThing[1] > 0 && whichChoice{
                                    VStack {
                                        Spacer()
                                        Text("都完成了🥳")
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color(red: 1, green: 0.31, blue: 0.11))
                                        Spacer()
                                        Spacer()
                                    }
                                }
                                ScrollView {
                                    VStack(spacing: 4) {
                                        ForEach(dataBox.filter{ $0.thingDate == selectDay && $0.thingState == false}, id: \.self) { dataItem in
                                            ToDoCheck(dataItem: .constant(dataItem), haveThing: $haveThing)
                                                .onAppear {
                                                    haveThing[1] += 1
                                                }
                                        }
                                    }
                                }.opacity(!whichChoice ? 1.0 : 0.0)
                                .frame(width:geo.size.width)
                            }
                            
                            //                            if haveThing[1] > 0 {
                            //                                Text("已完成")
                            //                                    .font(.system(size: 22))
                            //                                    .fontWeight(.bold)
                            //                                    .foregroundStyle(Color.black)
                            //                                    .padding(.leading)
                            //                            }
                            
                        }
                    }
                }.navigationTitle("待辦事項  "+selectDayMonth+"月")
                Button(action: {
                    addToDo.toggle()
                }, label: {
                    ZStack {
                        //                        Rectangle()
                        //                            .frame(width: geo.size.width, height: geo.size.height*0.1 + 60)
                        //                            .backgroundStyle(Color.clear)
                        //                            .blur(radius: 20)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color(red: 1, green: 0.53, blue: 0.34), .white)
                            .frame(height: 80)
                            .shadow(color: .black.opacity(0.1), radius: 20, x: 2, y: 2)
                    }
                }).position(CGPoint(x: geo.size.width/2, y: geo.size.height*0.9))
                    .sheet(isPresented: $addToDo) {
                        VStack() {
                            HStack() {
                                Text("新增待辦事項")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                Spacer()
                                Button("新增") {
                                    if toDoName.isEmpty || toDoName.count > 12 {
                                        outOfLength = true
                                    } else {
                                        outOfLength = false
                                        let data = DataFormat(thingDate: selectDay, thingName: toDoName, thingState: true)
                                        context.insert(data)
                                        try! context.save()
                                        toDoName = ""
                                        addToDo.toggle()
                                    }
                                }
                                .alert("內容不得為空或超過12字", isPresented: $outOfLength) {
                                    Button("重新編輯"){
                                        
                                    }
                                }
                                .padding(.vertical)
                            }.padding(.horizontal)
                                .padding(.top, 20)
                            Spacer()
                                .frame(height: 10)
                            HStack{
                                Image(systemName: "text.badge.plus")
                                TextField("請輸入待辦標題", text: $toDoName)
                                    .textFieldStyle(.roundedBorder)
                                    .presentationDetents([.height(140)])
                                    .presentationDragIndicator(.visible)
                            }.padding(.horizontal)
                            Spacer()
                        }.padding(.top,0)
                    }
            }.background(Color("aBayBackground"))
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                refreshStatistic()
            }
        }
    }
    
    func updateWidget() -> String{
        var todayToDoString: String = ""
        for dataItem in (dataBox.filter{ $0.thingDate == todayDate && $0.thingState == true}) {
            todayToDoString.append(dataItem.thingName+"^")
            todayToDoList = todayToDoString
            WidgetCenter.shared.reloadTimelines(ofKind: "CountDownDateWidget")
        }
        return todayToDoString
    }
    
    func refreshStatistic() {
        haveThing = [0, 0]
        for item in dataBox.filter{ $0.thingDate == selectDay} {
            if item.thingState {
                haveThing[0] += 1
            } else {
                haveThing[1] += 1
            }
        }
    }
    
}

struct SmallWeekCalendar: View {
    
    let calendar = Calendar.current
    let weekName:[String] = ["週日","週一","週二","週三","週四","週五","週六"]
    
    @Binding var selectDay: String
    @Binding var selectDayMonth: String
    @Binding var havething: [Int]
    @Binding var todayDate: String
    
    @State var select: Int = 3
    @State var today: Int = 0
    @State private var currentWeekOffset = 0
    @State var tapState: [Bool] = [false]
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<7) { i in
                VStack {
                    Text(weekName[i])
                        .font(.system(size: 10))
                        .fontWeight(.semibold)
                    Button(action: {
                        select = i
                        selectDay = formatterSelectDate(dateFor(i))
                        refreshSelectDate()
                        tapState[0].toggle()
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
                                            .stroke(formatterSelectDate(dateFor(i)) == todayDate ? Color(red: 0.2, green: 0.3, blue: 0.5):Color(red: 0.6, green: 0.66, blue: 0.79), lineWidth: 3)
                                    )
                                VStack(alignment: .center) {
                                    Text(convertDateToNongLi(aStrDate: dateFor(i)))
                                        .font(.system(size: 8))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(red: 0.2, green: 0.3, blue: 0.5))
                                    Text(formatterDayDate(dateFor(i)))
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
                                    Text(formatterDayDate(dateFor(i)))
                                        .font(.system(size: 20, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(red: 0.95, green: 0.9, blue: 0.87))
                                }.padding(.top, 3)
                            }
                        }
                    }).sensoryFeedback(.decrease , trigger: tapState[0])
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < -30 {
                                // 向左滑动，显示下一周
                                currentWeekOffset += 1
                                refreshSelectDate()
                            } else if value.translation.width > 30 {
                                // 向右滑动，显示上一周
                                currentWeekOffset -= 1
                                refreshSelectDate()
                            }
                            // 更新选择的日期等逻辑
                            // 更新 selectDay 和 select 等属性的逻辑，以显示新的日期
                        }
                )
            }
        }.onAppear {
            let today = Calendar.current.component(.weekday, from: Date())
            let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
            select = dateComponents.weekday! - 1
            selectDay = formatterSelectDate(dateFor(select))
            todayDate = formatterSelectDate(Date())
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            let today = Calendar.current.component(.weekday, from: Date())
            let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
            select = dateComponents.weekday! - 1
            selectDay = formatterSelectDate(dateFor(select))
            todayDate = formatterSelectDate(Date())
        }
    }
    
    func formatterDayDate(_ day:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: day)
    }
    
    func formatterSelectDate(_ day:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: day)
    }
    
    func refreshSelectDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        selectDay = formatter.string(from: dateFor(select))
        havething = [0, 0]
        let monthStart = selectDay.index(selectDay.startIndex, offsetBy: 5)
        let monthEnd = selectDay.index(selectDay.startIndex, offsetBy: 6)
        if String(selectDay[monthStart]) == "0" {
            selectDayMonth = " " + String(selectDay[monthEnd])
        } else {
            selectDayMonth = String(selectDay[monthStart]) + String(selectDay[monthEnd])
        }    }
    
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
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: calendar.date(byAdding: .day, value: currentWeekOffset*7 , to: Date())!)
        return calendar.date(from: components) ?? Date()
    }
    
    func formatterWeekDate(_ day:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: day)
    }
}

struct ToDoCheck: View {
    
    @Environment(\.modelContext) private var context
    
    @Binding var dataItem: DataFormat
    @Binding var haveThing: [Int]
    
    @State var delectThing: Bool = false
    @State var tapState: Bool = false
    @Query var dataBox: [DataFormat]
    
    var body: some View {
        
        Button(action: {
            delectThing.toggle()
        }, label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 45)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .inset(by: 1.5)
                            .stroke(dataItem.thingState ? Color(red: 1, green: 0.53, blue: 0.34):Color(red: 0.51, green: 0.51, blue: 0.51), lineWidth: 3)
                    )
                HStack {
                    Text(dataItem.thingName)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                        .padding(.leading)
                    Spacer()
                    if dataItem.thingState {
                        Button(action: {
                            updateState(item: dataItem, toDoState: false)
                            haveThing[0] -= 1
                            haveThing[1] += 1
                            tapState.toggle()
                        }, label: {
                            ZStack(alignment: .center) {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 54, height: 24)
                                    .background(Color(red: 1, green: 0.31, blue: 0.11))
                                    .cornerRadius(12)
                                    .shadow(color: Color(red: 0.74, green: 0.24, blue: 0.1), radius: 0, x: 0, y: 2)
                                    .padding(.top, -2)
                                Text("完成")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                            }
                        }).sensoryFeedback(.success, trigger: tapState)
                        .padding(.trailing)
                    } else {
//                        Image(systemName: "checkmark.circle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 26)
//                            .padding(.trailing)
                        Button(action: {
                            updateState(item: dataItem, toDoState: true)
                            haveThing[1] -= 1
                            haveThing[0] += 1
                        }, label: {
                            ZStack {
                                Circle()
                                    .scaledToFit()
                                    .frame(width: 26)
                                    .foregroundStyle(Color.white)
                                    .shadow(color: Color(red: 0.82, green: 0.41, blue: 0.25), radius: 0, x: 0, y: 2)
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26)
                                    
                            }.padding(.top, -2)
                        })
                        .padding(.trailing)
                    }
                    
                }
            }.padding(.horizontal)
        }).confirmationDialog("要確定誒",isPresented: $delectThing) {
            Button("刪除待辦", role: .destructive) {
                if dataItem.thingState {
                    haveThing[0] -= 1
                } else {
                    haveThing[1] -= 1
                }
                context.delete(dataItem)
            }
        }
    }
    
    func updateState(item: DataFormat, toDoState: Bool) {
        item.thingState = toDoState
        try! context.save()
    }
    
}


//#Preview {
//    ToDoCheck(thingName: .constant("寫數學講義"))
//}

#Preview {
    ToDoTimeLine()
}
