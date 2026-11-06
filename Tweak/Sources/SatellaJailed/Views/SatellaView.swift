import SwiftUI

@available(iOS 15, *)
struct SatellaShapeView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = SatellaShape(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

@available(iOS 15, *)
struct SatellaView: View {
    @StateObject private var model: SatellaModel = .shared

    var body: some View {
        Button {
            model.isShowing = true
        } label: {
            Color(red: 0.80, green: 0.63, blue: 0.87)
                .mask { SatellaShapeView() }
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .frame(width: 33, height: 33)
        .fullScreenCover(isPresented: $model.isShowing) {
            PurchaseBannerView(isShowing: $model.isShowing)
                .preferredColorScheme(.dark)
                .background(Color.clear.ignoresSafeArea())
                .modifier(TransparentPreviewPresentation())
        }
    }
}

/// Makes the full-screen presentation transparent so SwiftUI does not draw
/// the extra dark rounded sheet container behind the custom glass card.
@available(iOS 15, *)
private struct TransparentPreviewPresentation: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content.presentationBackground(.clear)
        } else {
            content.background(Color.clear.ignoresSafeArea())
        }
    }
}
