//
//  ContentView.swift
//  UI-110
//
//  Created by にゃんにゃん丸 on 2021/01/24.
//

import SwiftUI

let ang = AngularGradient(gradient: Gradient(colors: [Color.purple, Color.red]), center: .center)
struct ContentView: View {
    var body: some View {
        NavigationView{
            Home()
                .navigationBarTitle("Title")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    @State var txt = ""
    
    @State var chips : [[ChipData]] = [
    
//     [ChipData(chiptext: "AA"),ChipData(chiptext: "BB"),ChipData(chiptext: "CC")]
    
    ]
    var body: some View{
        
        VStack(spacing:30){
            
            
            ScrollView{
                LazyVStack(alignment:.leading,spacing:15){
                    
                    
                        
                        ForEach(chips.indices,id:\.self){index in
                            
                            HStack(spacing:5){
                                
                                ForEach(chips[index].indices,id:\.self){chipindex in
                                    
                                    Text(chips[index][chipindex].chiptext)
                                        .fontWeight(.semibold)
                                     
                                        .padding(.vertical,10)
                                        .padding(.horizontal)
                                        .background(Capsule().stroke(Color.red,lineWidth: 1.3))
                                        .lineLimit(1)
                                        .overlay(
                                            
                                            GeometryReader{reader -> Color in
                                                
                                                let maxX = reader.frame(in: .global).maxX
                                                
                                                if maxX > UIScreen.main.bounds.width - 70 && !chips[index][chipindex].isExeed{
                                                    
                                                    DispatchQueue.main.async {
                                                        chips[index][chipindex].isExeed = true
                                                        
                                                        
                                                        let lastitem = chips[index][chipindex]
                                                        
                                                        chips.append([lastitem])
                                                        chips[index].remove(at: chipindex)
                                                    }
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                return Color.clear
                                                
                                            },alignment:.trailing
                                            
                                        
                                        
                                        )
                                        .clipShape(Capsule())
                                        .onTapGesture {
                                            chips[index].remove(at: chipindex)
                                            if chips[index].isEmpty{chips.remove(at: index)}
                                        }
                                    
                                }
                               
                            }
                            
                            
                            
                        }
                        
                    
                    
                    
                }
                .padding()
                
                
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray,lineWidth: 1.5))
          
           TextEditor(text: $txt)
            .padding()
            .frame(height: 150)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray,lineWidth: 1.5))
            
            
            Button(action: {
               
                    
                    if chips.isEmpty{
                        chips.append([])
                        
                    }
                withAnimation(.default){
                
               
                    
                    chips[chips.count - 1].append(ChipData(chiptext: txt))
                    txt = ""
                    
                }
                
            }, label: {
                Text("Add Tag")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical,15)
                    .frame(maxWidth: .infinity)
                    .background(ang)
                    .cornerRadius(10)
                    
            })
            .disabled(txt == "")
            .opacity(txt == "" ? 0.4 : 1)
            
            
            
        }
        .padding()
    }
}
struct ChipData : Identifiable {
    var id = UUID().uuidString
    var chiptext : String
    var isExeed = false
}
