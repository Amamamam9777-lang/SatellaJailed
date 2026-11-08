import SwiftUI
import UIKit

@available(iOS 15, *)
final class SatellaController: UIViewController {
    private static let controllers = NSMapTable<UIWindowScene, SatellaController>(
        keyOptions: .weakMemory,
        valueOptions: .strongMemory
    )

    private let model = SatellaModel.shared
    private let host = UIView()
    private var hasInstalledContent = false

    static func installInActiveScenes() {
        dispatchPrecondition(condition: .onQueue(.main))

        let scenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }

        for scene in scenes {
            guard let window = scene.windows.first(where: { $0.isKeyWindow }),
                  let root = window.rootViewController else {
                continue
            }

            if controllers.object(forKey: scene) != nil {
                continue
            }

            let controller = SatellaController()
            controllers.setObject(controller, forKey: scene)
            root.addChild(controller)
            controller.view.frame = root.view.bounds
            controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            root.view.addSubview(controller.view)
            controller.didMove(toParent: root)
        }
    }

    override func loadView() {
        let passthrough = PassthroughView()
        passthrough.backgroundColor = .clear
        view = passthrough
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true

        host.translatesAutoresizingMaskIntoConstraints = true
        host.backgroundColor = .clear
        host.bounds = CGRect(x: 0, y: 0, width: 33, height: 33)
        host.center = CGPoint(x: view.bounds.width * 0.85, y: view.bounds.height * 0.5)
        host.autoresizingMask = []

        let hostingController = UIHostingController(rootView: SatellaView())
        hostingController.view.backgroundColor = .clear
        hostingController.view.frame = host.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addChild(hostingController)
        host.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        host.addGestureRecognizer(pan)
        view.addSubview(host)
        hasInstalledContent = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard hasInstalledContent else { return }

        if host.center == .zero {
            host.center = CGPoint(x: view.bounds.width * 0.85, y: view.bounds.height * 0.5)
        }
        clampHostToVisibleBounds()
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        host.center = CGPoint(
            x: host.center.x + translation.x,
            y: host.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
        if gesture.state == .ended || gesture.state == .cancelled {
            clampHostToVisibleBounds()
        }
    }

    private func clampHostToVisibleBounds() {
        let halfWidth = host.bounds.width / 2
        let halfHeight = host.bounds.height / 2
        let inset = view.safeAreaInsets
        let minX = inset.left + halfWidth
        let maxX = max(minX, view.bounds.width - inset.right - halfWidth)
        let minY = inset.top + halfHeight
        let maxY = max(minY, view.bounds.height - inset.bottom - halfHeight)

        host.center.x = min(max(host.center.x, minX), maxX)
        host.center.y = min(max(host.center.y, minY), maxY)
    }
}
