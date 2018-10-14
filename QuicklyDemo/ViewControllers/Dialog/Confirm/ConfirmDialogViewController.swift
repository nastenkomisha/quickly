//
//
//  Quickly
//

import Quickly

protocol IConfirmDialogViewControllerRouter : IQRouter {

    func dismiss(viewController: ConfirmDialogViewController)
    
}

class ConfirmDialogViewController : QNibViewController, IQDialogContentViewController, IQRouterable, IQContextable {

    weak var router: IConfirmDialogViewControllerRouter!
    weak var context: AppContext!

    @IBOutlet private weak var imageView: QImageView!
    @IBOutlet private weak var closeButton: QButton!

    init(router: RouterType, context: ContextType) {
        self.router = router
        self.context = context
        super.init()
    }

    override func didLoad() {
        super.didLoad()

        self.view.layer.cornerRadius = 4

        self.imageView.source = QImageSource("icon_confirm")

        let normalStyle = QButtonStyle()
        normalStyle.color = UIColor.lightGray
        normalStyle.cornerRadius = QViewCornerRadius.manual(radius: 4)
        normalStyle.text = QText("Close", color: UIColor.black)

        let highlightedStyle = QButtonStyle(parent: normalStyle)
        highlightedStyle.color = UIColor.darkGray
        highlightedStyle.text = QText("Close", color: UIColor.black)

        self.closeButton.imageInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.closeButton.textInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.closeButton.normalStyle = normalStyle
        self.closeButton.highlightedStyle = highlightedStyle
        self.closeButton.addTouchUpInside(self, action: #selector(self.pressedClose(_:)))
    }

    override func preferedStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }

    func didPressedOutsideContent() {
        self.router.dismiss(viewController: self)
    }

    @objc
    private func pressedClose(_ sender: Any) {
        self.router.dismiss(viewController: self)
    }

}
