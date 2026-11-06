import UIKit

/// UI-only entry point. It installs the floating demo control and does not
/// hook StoreKit, transactions, receipts, payment eligibility, or networking.
@_cdecl("jinx_entry")
public func jinxEntry() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        let activeScene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }

        guard
            let window = activeScene?.windows.first(where: { $0.isKeyWindow }),
            let rootViewController = window.rootViewController
        else {
            return
        }

        rootViewController.add(SatellaController.shared)
    }
}
