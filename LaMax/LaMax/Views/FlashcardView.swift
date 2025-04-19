// FlashcardView.swift
import SwiftUI

struct FlashcardView: View {
    @ObservedObject var viewModel: SpacedRepetitionViewModel
    @State private var isFlipped = false
    var onBack: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            ZStack {
                if isFlipped {
                    VStack {
                        Text(viewModel.definition)
                            .font(.body)
                        Text(viewModel.example)
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue.opacity(0.2))
                } else {
                    Text(viewModel.word)
                        .font(.system(size: 17, weight: .bold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.yellow.opacity(0.2))
                }
            }
            .cornerRadius(16)
            .onTapGesture {
                withAnimation {
                    isFlipped.toggle()
                }
            }
            .rotation3DEffect(
                .degrees(isFlipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            PrimaryButton(title: "Retour") {
                onBack?()
            }
        }
    }
}

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(viewModel: SpacedRepetitionViewModel())
    }
}
