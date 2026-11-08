import UIKit

/// UI-only entry point. Installs one isolated demo control per active scene
/// in the host application. It does not install payment, receipt, network,
/// anti-cheat, or gameplay hooks.
@_cdecl("jinx_entry")
public func jinxEntry() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
        guard #available(iOS 15.0, *) else { return }
        SatellaController.installInActiveScenes()
    }
}
