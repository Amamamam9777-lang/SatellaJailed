import SwiftUI

/// A local visual demo only. It does not call StoreKit, create transactions,
/// change receipts, or charge an Apple Account.
@available(iOS 15, *)
struct PurchaseBannerView: View {
    @Binding var isShowing: Bool

    var body: some View {
        ZStack {
            Color.clear

            VStack(spacing: 18) {
                Capsule()
                    .fill(Color.white.opacity(0.34))
                    .frame(width: 38, height: 5)
                    .padding(.top, 10)

                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 17, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.78, green: 0.61, blue: 0.94), Color(red: 0.38, green: 0.31, blue: 0.72)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        Image(systemName: "bag.fill")
                            .font(.system(size: 27, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 58, height: 58)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Покупка в приложении")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Демонстрационный товар")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.68))
                    }
                    Spacer(minLength: 0)
                }

                Divider().overlay(Color.white.opacity(0.16))

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Пакет бонусов")
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                        Text("ДЕМО")
                            .font(.system(size: 10, weight: .bold))
                            .tracking(1.1)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(Color.white.opacity(0.13), in: Capsule())
                    }
                    Text("Пример оформления окна покупки. Название и стоимость здесь условные.")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.68))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .foregroundColor(.white)

                HStack(alignment: .firstTextBaseline) {
                    Text("Пример цены")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.65))
                    Spacer()
                    Text("0,99 €")
                        .font(.system(size: 21, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }

                VStack(spacing: 10) {
                    Button {
                        isShowing = false
                    } label: {
                        Text("Продолжить демо")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black.opacity(0.88))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.white.opacity(0.92), in: Capsule())
                    }
                    .buttonStyle(.plain)

                    Button("Закрыть") {
                        isShowing = false
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.78))
                    .padding(.vertical, 4)
                }

                Text("ВИЗУАЛЬНЫЙ МАКЕТ · НЕ ЯВЛЯЕТСЯ ОКНОМ APPLE И НЕ ПРОВОДИТ ОПЛАТУ")
                    .font(.system(size: 8, weight: .semibold))
                    .tracking(0.45)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.52))
                    .padding(.top, 1)
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 20)
            .frame(maxWidth: 460)
            .background {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.20), Color.white.opacity(0.035), Color.black.opacity(0.12)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.24), lineWidth: 1)
                    }
                    .shadow(color: .black.opacity(0.28), radius: 28, x: 0, y: 12)
            }
            .padding(.horizontal, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color.clear)
    }
}
