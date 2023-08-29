//
//  ContentView.swift
//  rAthenaApp
//
//  Created by Leon Li on 2022/11/2.
//

import SwiftUI
import rAthenaLogin
import rAthenaChar
import rAthenaMap
import rAthenaWeb
import rAthenaControl

struct ContentView: View {
    private let servers: [RAServer] = [
        RALoginServer.shared,
        RACharServer.shared,
        RAMapServer.shared,
        RAWebServer.shared,
    ]

    private let databases: [RADatabase] = [
        RAItemDatabase.shared,
        RAMonsterDatabase.shared,
        RAJobDatabase.shared,
        RASkillDatabase.shared,
        RASkillTreeDatabase.shared,
    ]

    var body: some View {
        NavigationView {
            List {
                Section("Servers") {
                    ForEach(servers, id: \.name) { server in
                        NavigationLink {
                            RAServerView(server: server)
                        } label: {
                            Label(server.name, systemImage: "macpro.gen3.server")
                        }
                    }
                }
                Section("Databases") {
                    ForEach(databases, id: \.name) { database in
                        NavigationLink {
                            RADatabaseView(database: database)
                        } label: {
                            Label(database.name, systemImage: "list.bullet.rectangle")
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("rAthena")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
