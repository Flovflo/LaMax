// QuizEntryView.swift
import SwiftUI

struct QuizEntryView: View {
    var body: some View {
        List {
            Section("Listening") {
                ForEach(1...4, id: \.self) { idx in
                    NavigationLink("Part \(idx)") {
                        QuizView(viewModel: QuizViewModel(partName: "part-\(idx)"), onQuit: { })
                    }
                }
            }
            Section("Reading") {
                ForEach(5...7, id: \.self) { idx in
                    NavigationLink("Part \(idx)") {
                        QuizView(viewModel: QuizViewModel(partName: "part-\(idx)"), onQuit: { })
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Choisir une partie")
    }
}

struct QuizEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            QuizEntryView()
        }
    }
}
