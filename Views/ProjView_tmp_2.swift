//
//  ProjView_tmp_2.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 30/06/2024.
//

import SwiftUI

struct ProjView_tmp_2: View {
    
    
    @EnvironmentObject var stateManager: StateManager
    
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
     Text("Hello World!")
        
//                    List{
//                        Section(header: Text("Navi stack").foregroundColor(.black)){
//                            VStack(alignment: .leading ){
//                                ForEach (stateManager.navigationPath){ element in
//        
//                                }
//        
//                            }
//                        }
//                    }
//        
        
        
    }
}

#Preview {
    ProjView_tmp_2()
}
