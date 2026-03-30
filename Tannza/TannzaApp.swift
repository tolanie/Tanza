//
//  TannzaApp.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 19/02/2026.
//

import SwiftUI
import SwiftData

@main
struct TannzaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: UserData.self)
    }
}
