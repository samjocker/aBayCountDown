//
//  HomePage.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/2.
//

import SwiftUI

struct HomePage: View {
    
    @State var selectId: Int = 0
    
    var body: some View {
        NavigationStack(){
            ScrollView(.vertical){
                VStack(alignment:.leading) {
                    Text("小工具編輯")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .padding(.leading)
                        .padding(.top)
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(alignment:.center){
                            ForEach(0..<5) { i in
                                VStack{
                                    Text("學測/統測")
                                        .font(.system(size: 32))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(red: 0.2, green: 0.3, blue: 0.5))
                                        .scrollTransition { content,phase in
                                            content.opacity(phase.isIdentity ? 1.0:0.0)
                                                .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                        }
                                    
                                    Rectangle()
                                        .frame(width: 200,height: 200)
                                        .foregroundStyle(Color.orange)
                                        .containerRelativeFrame(.horizontal, count:1, spacing:20)
                                        .cornerRadius(20)
                                        .shadow(radius: 8,x:4,y:4)
                                        .id(i)
                                        .scrollTransition { content,phase in
                                            content.opacity(phase.isIdentity ? 1.0:0.5)
                                                .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                        }
                                    Spacer()
                                        .frame(height: 20)
                                    NavigationLink() {
                                        EditDatePage()
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 160, height: 50)
                                                .background(Color(red: 0.2, green: 0.3, blue: 0.5))
                                                .cornerRadius(25)
                                                .shadow(color: Color(red: 0.2, green: 0.3, blue: 0.5).opacity(0.7), radius: 0, x: 0, y: 4)
                                            Text("編輯")
                                                .font(.system(size: 26))
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color.white)
                                        }.scrollTransition { content,phase in
                                            content.opacity(phase.isIdentity ? 1.0:0.0)
                                                .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                        }
                                    }.padding(.bottom,5)
                                }
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.bottom,14)
                        
                    }.contentMargins(100)
                    .scrollTargetBehavior(.viewAligned)
                    .frame(height:400)
//                    .background(Color.white)
                }
                .navigationTitle("初四倒數")
                
//                    .toolbarBackground(Color(red: 0.95, green: 0.9, blue: 0.87).opacity(0.5), for: .navigationBar)
            }.background {
                Color(red: 0.95, green: 0.95, blue: 0.97)
                    .ignoresSafeArea()
            }

        }
        
    }
    
}

struct EditDatePage: View {
    
    @State var targetDate: Date = .now
    @AppStorage("targetDateSave") var targetDateSave: String = "2023/12/03"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            VStack{
                Form {
                    Section(header: Text("設定目標日期")) {
                        HStack(alignment:.center){
                            Image(systemName: "calendar")
                            DatePicker("目標日期", selection: $targetDate, in: Date()..., displayedComponents: .date)
                                .environment(\.locale,Locale.init(identifier: "zh-tw"))
                        }
                        
                    }
                    Button("testButton"){
                        let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate)
                        print(String(days.day!+1))
                    }
                }.onAppear{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    targetDate = dateFormatter.date(from: targetDateSave)!
                }
                
            }.navigationTitle("小工具編輯")
                .toolbar {
                    ToolbarItemGroup(placement:.topBarTrailing){
                        Button("儲存"){
                            self.presentationMode.wrappedValue.dismiss()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy/MM/dd"
                            let dateString = dateFormatter.string(from: targetDate)
                            targetDateSave = dateString
                            print("save-"+dateString)
                        }
                    }
                }
        }
        
    }
}

#Preview {
    HomePage()
}

#Preview {
    EditDatePage()
}
