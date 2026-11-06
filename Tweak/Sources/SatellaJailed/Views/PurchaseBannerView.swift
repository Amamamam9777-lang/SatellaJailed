import SwiftUI

/// Clearly labelled visual demo inspired by the supplied reference video.
/// This view does not call StoreKit, authenticate with Apple, or process payments.
@available(iOS 15, *)
struct PurchaseBannerView: View {
    @Binding var isShowing: Bool

    @State private var isPresented = false
    @State private var pulse = false

    private let primaryText = Color.white.opacity(0.96)
    private let secondaryText = Color.white.opacity(0.62)
    private let separator = Color.white.opacity(0.10)

    var body: some View {
        ZStack(alignment: .bottom) {
            // The darkened backdrop gives the same depth as the video reference.
            Color.black
                .opacity(isPresented ? 0.48 : 0)
                .ignoresSafeArea()
                .onTapGesture(perform: close)

            purchaseCard
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .offset(y: isPresented ? 0 : 26)
                .scaleEffect(isPresented ? 1 : 0.975, anchor: .bottom)
                .opacity(isPresented ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
        .onAppear {
            withAnimation(.spring(response: 0.46, dampingFraction: 0.88)) {
                isPresented = true
            }
            withAnimation(.easeInOut(duration: 1.15).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }

    private var purchaseCard: some View {
        VStack(spacing: 0) {
            header

            divider
                .padding(.top, 17)
                .padding(.bottom, 17)

            productRow

            divider
                .padding(.top, 17)
                .padding(.bottom, 16)

            priceRow

            divider
                .padding(.top, 15)
                .padding(.bottom, 15)

            accountRow

            demoConfirmation
                .padding(.top, 25)

            Text("ДЕМО-ПРЕДПРОСМОТР · ОПЛАТА ОТКЛЮЧЕНА")
                .font(.system(size: 9, weight: .semibold, design: .rounded))
                .tracking(1.15)
                .foregroundColor(.white.opacity(0.52))
                .multilineTextAlignment(.center)
                .padding(.top, 16)
        }
        .padding(.horizontal, 22)
        .padding(.top, 17)
        .padding(.bottom, 20)
        .frame(maxWidth: 500)
        .background {
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .fill(Color(red: 0.075, green: 0.08, blue: 0.09).opacity(0.77))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.085),
                                    Color.white.opacity(0.025),
                                    Color.black.opacity(0.12)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.16), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.36), radius: 30, x: 0, y: 14)
        }
    }

    private var header: some View {
        HStack(spacing: 8) {
            Text("In-App Purchase")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(primaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.82)

            Text("DEMO")
                .font(.system(size: 9, weight: .heavy, design: .rounded))
                .tracking(1.1)
                .foregroundColor(.white.opacity(0.9))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.white.opacity(0.14), in: Capsule())

            Spacer(minLength: 4)

            Button(action: close) {
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white.opacity(0.90))
                    .frame(width: 35, height: 35)
                    .background(Color.white.opacity(0.105), in: Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.08), lineWidth: 1))
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Закрыть демонстрацию")
        }
    }

    private var productRow: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.25, green: 0.57, blue: 0.92),
                                Color(red: 0.10, green: 0.26, blue: 0.50)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white.opacity(0.95))
            }
            .frame(width: 62, height: 62)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white.opacity(0.15), lineWidth: 1))

            VStack(alignment: .leading, spacing: 4) {
                Text("60 Unknown Cash")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(primaryText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)

                HStack(spacing: 5) {
                    Text("PUBG MOBILE")
                        .font(.system(size: 13, weight: .medium))
                    Text("13+")
                        .font(.system(size: 9, weight: .semibold))
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(secondaryText, lineWidth: 0.8))
                }
                .foregroundColor(secondaryText)

                Text("Встроенная покупка")
                    .font(.system(size: 12))
                    .foregroundColor(secondaryText)
            }

            Spacer(minLength: 0)
        }
    }

    private var priceRow: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("99,00 руб.")
                .font(.system(size: 19, weight: .semibold, design: .rounded))
                .foregroundColor(primaryText)
            Text("Единовременный платёж")
                .font(.system(size: 13))
                .foregroundColor(secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var accountRow: some View {
        HStack(spacing: 5) {
            Text("Демо-аккаунт:")
                .foregroundColor(secondaryText)
            Text("demo@example.com")
                .foregroundColor(.white.opacity(0.74))
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .font(.system(size: 12, weight: .regular))
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var demoConfirmation: some View {
        VStack(spacing: 9) {
            ZStack {
                Circle()
                    .stroke(Color.blue.opacity(pulse ? 0.30 : 0.68), lineWidth: 2)
                    .frame(width: 39, height: 39)
                    .scaleEffect(pulse ? 1.10 : 0.94)

                Image(systemName: "checkmark")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(red: 0.20, green: 0.58, blue: 1.0))
            }

            Text("Демонстрационное подтверждение")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white.opacity(0.86))

            Text("Боковая кнопка и платёжная авторизация не используются")
                .font(.system(size: 10))
                .foregroundColor(secondaryText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private var divider: some View {
        Rectangle()
            .fill(separator)
            .frame(height: 1)
    }

    private func close() {
        withAnimation(.easeOut(duration: 0.20)) {
            isPresented = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            isShowing = false
        }
    }
}
