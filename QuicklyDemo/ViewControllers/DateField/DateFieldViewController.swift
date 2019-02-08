//
//
//  Quickly
//

import Quickly

protocol IDateFieldViewControllerRouter : IQRouter {

    func dismiss(viewController: DateFieldViewController)
    
}

class DateFieldViewController : QNibViewController, IQRouterable, IQContextable {

    weak var router: IDateFieldViewControllerRouter!
    weak var context: AppContext!

    @IBOutlet private weak var dateField: QDateField!

    init(router: RouterType, context: ContextType) {
        self.router = router
        self.context = context
        super.init()
    }

    override func didLoad() {
        super.didLoad()

        self.dateField.formatter = QDateFieldFormatter(
            dateFormat: "dd.MM.yyyy",
            textStyle: QTextStyle(
                font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
                color: UIColor.black
            )
        )
        self.dateField.placeholder = QText("DateField")
        self.dateField.onSelect = { (dateField, date) in
            print("\(NSStringFromClass(dateField.classForCoder)).onSelect(date: \(date)")
        }
    }

    override func didPresent(animated: Bool) {
        super.didPresent(animated: animated)
        self.dateField.beginEditing()
    }

    override func prepareInteractiveDismiss() {
        super.prepareInteractiveDismiss()
        self.view.endEditing(false)
    }

    override func cancelInteractiveDismiss() {
        super.cancelInteractiveDismiss()
        self.dateField.beginEditing()
    }

    override func finishInteractiveDismiss() {
        super.finishInteractiveDismiss()
    }

    override func willDismiss(animated: Bool) {
        super.willDismiss(animated: animated)
        self.view.endEditing(false)
    }

}
