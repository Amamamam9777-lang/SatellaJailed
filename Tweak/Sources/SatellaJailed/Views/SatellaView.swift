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
        .sheet(isPresented: $model.isShowing) {
            PurchaseBannerView(isShowing: $model.isShowing)
                .preferredColorScheme(.dark)
                .modifier(DemoSheetPresentation())
        }
    }
}

/// Uses APIs available in the original project's iOS 15 deployment range.
/// On newer iOS versions the system sheet remains transparent so the material
/// card below reads as a Liquid Glass-inspired surface.
@available(iOS 15, *)
private struct DemoSheetPresentation: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content
                .presentationDetents([.height(430)])
                .presentationDragIndicator(.hidden)
        } else {
            content
        }
    }
}
