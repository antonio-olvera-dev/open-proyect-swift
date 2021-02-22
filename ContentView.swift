//
//  ContentView.swift
//  init
//
//  Created by Antonio Olvera on 21/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            MainView().ini()
        }
        .frame(width: 600.0)
    }
}

class MainView{

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

    func boton(title:String) -> some View{
        let boton = Button(action:{self.open(name: title)}) {
            Text(title)
        }.padding(.top, 20)
        return boton
    }

    func open(name:String){
        let command = "code /Users/antonioolvera/workspace/Drivel/\(name)"
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
    }

    func ini() ->some View{
        let command = "ls /Users/antonioolvera/workspace/Drivel"
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        let list = output.split(separator: "\n")

        return Group{
            ForEach(0..<list.count) { i in
                self.boton(title: "\(list[i])")
            }
            
        }
        
        
        
    }



    
    
}
