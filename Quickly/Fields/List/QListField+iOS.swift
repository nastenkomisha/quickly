//
//  Quickly
//

#if os(iOS)

    @IBDesignable
    open class QListField : QView, IQField {

        public typealias ShouldClosure = (_ listField: QListField) -> Bool
        public typealias SelectClosure = (_ listField: QListField, _ row: QListFieldPickerRow) -> Void
        public typealias Closure = (_ listField: QListField) -> Void

        public var rows: [QListFieldPickerRow] {
            set(value) { self.pickerSection.rows = value }
            get { return self.pickerSection.rows as! [QListFieldPickerRow] }
        }
        public var selectedRow: QListFieldPickerRow? {
            didSet {
                if let selectedRow = self.selectedRow {
                    self.label.contentAlignment = selectedRow.fieldContentAlignment
                    self.label.padding = selectedRow.fieldPadding
                    self.label.numberOfLines = selectedRow.fieldNumberOfLines
                    self.label.lineBreakMode = selectedRow.fieldLineBreakMode
                    self.label.text = selectedRow.fieldText
                    self.pickerController.select(row: selectedRow, animated: self.isEditing)
                } else {
                    self.label.text = self.placeholder
                }
                self.invalidateIntrinsicContentSize()
            }
        }
        public var rowHeight: CGFloat {
            set(value) {
                self.pickerSection.size.height = value
                self.pickerController.reload()
            }
            get { return self.pickerSection.size.height }
        }
        public var isValid: Bool {
            get { return self.selectedRow != nil }
        }
        public var placeholder: IQText? {
            didSet {
                if self.selectedRow == nil {
                    self.label.text = self.placeholder
                    self.invalidateIntrinsicContentSize()
                }
            }
        }
        public var isEnabled: Bool = true
        public var isEditing: Bool {
            get { return self.isFirstResponder }
        }
        open override var canBecomeFirstResponder: Bool {
            get {
                guard self.isEnabled == true else { return false }
                guard let closure = self.onShouldBeginEditing else { return true }
                return closure(self)
            }
        }
        open override var canResignFirstResponder: Bool {
            get {
                guard let closure = self.onShouldEndEditing else { return true }
                return closure(self)
            }
        }
        open override var inputView: UIView? {
            get { return self.picker } 
        }

        public var onShouldBeginEditing: ShouldClosure?
        public var onBeginEdititing: Closure?
        public var onSelect: SelectClosure?
        public var onShouldEndEditing: ShouldClosure?
        public var onEndEdititing: Closure?

        private var label: QLabel!
        private var picker: QPickerView!
        private var pickerSection: QPickerSection!
        private var pickerController: QPickerController!

        open override var intrinsicContentSize: CGSize {
            get { return self.label.intrinsicContentSize }
        }

        open override func setup() {
            super.setup()

            self.backgroundColor = UIColor.clear

            self.label = QLabel(frame: self.bounds)
            self.label.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
            self.addSubview(self.label)

            self.picker = QPickerView()

            self.pickerSection = QPickerSection(cellType: QListFieldPickerCell.self, height: 40, rows: [])

            self.pickerController = QPickerController()
            self.pickerController.sections = [ self.pickerSection ]
            self.pickerController.delegate = self
            self.picker.pickerController = self.pickerController
        }

        open override func sizeThatFits(_ size: CGSize) -> CGSize {
            return self.label.sizeThatFits(size)
        }

        open override func sizeToFit() {
            return self.label.sizeToFit()
        }

        @discardableResult
        open override func becomeFirstResponder() -> Bool {
            guard super.becomeFirstResponder() == true else { return false }
            if self.selectedRow == nil {
                self.selectedRow = self.rows.first
            }
            self.onBeginEdititing?(self)
            return true
        }

        @discardableResult
        open override func resignFirstResponder() -> Bool {
            guard super.resignFirstResponder() == true else { return false }
            self.onEndEdititing?(self)
            return true
        }

    }

    extension QListField : IQPickerControllerDelegate {

        public func select(_ controller: IQPickerController, section: IQPickerSection, row: IQPickerRow) {
            guard let row = row as? QListFieldPickerRow else { return }
            self.selectedRow = row
            guard let closure = self.onSelect else { return }
            closure(self, row)
        }

    }

#endif