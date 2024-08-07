//
//  ErrorView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 11/02/2024.
//

//import SwiftUI
//
//struct ErrorView: View {
//    let errorWrapper: ErrorWraper
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("Ups... small error happened ;)")
//                    .font(.title)
//                    .padding(.bottom)
//                Text(errorWrapper.error.localizedDescription)
//                    .font(.headline)
//                Text(errorWrapper.guidance)
//                    .font(.caption)
//                    .padding(.top)
//                Spacer()
//            }
//            .padding()
//            .background(.ultraThinMaterial)
//            .clipShape(.rect(cornerSize: CGSize(width: 15, height: 15)))
//            .toolbar{
//                ToolbarItem(placement: .topBarTrailing){
//                    Button("Dismiss"){
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    enum SampleError: Error {
//        case errorRequired
//    }
//    
//    var wrapper: ErrorWraper {
//        ErrorWraper(error: SampleError.errorRequired, guidance: "It's ok, we can continue ;)")
//    }
//    
//    return ErrorView(errorWrapper: wrapper)
//}
