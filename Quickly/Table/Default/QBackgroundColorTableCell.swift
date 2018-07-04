//
//  Quickly
//

open class QBackgroundColorTableRow : QTableRow {

    public var backgroundColor: UIColor?
    public var selectedBackgroundColor: UIColor?

    public init(backgroundColor: UIColor? = nil, selectedBackgroundColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
        self.selectedBackgroundColor = selectedBackgroundColor
        super.init()
    }

}

open class QBackgroundColorTableCell< RowType: QBackgroundColorTableRow >: QTableCell< RowType > {

    open override func set(row: RowType, animated: Bool) {
        super.set(row: row, animated: animated)

        self._applyContentBackgroundColor(selected: self.isSelected, highlighted: self.isHighlighted)
    }

    open override func setSelected(_ selected: Bool, animated: Bool) {
        self._applyContentBackgroundColor(selected: selected, highlighted: self.isHighlighted)
    }

    open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self._applyContentBackgroundColor(selected: self.isSelected, highlighted: highlighted)
    }

    private func _applyContentBackgroundColor(selected: Bool, highlighted: Bool) {
        let backgroundColor = self._currentContentBackgroundColor(selected: selected, highlighted: highlighted)
        self.backgroundColor = backgroundColor
        self.contentView.backgroundColor = backgroundColor
    }

    private func _currentContentBackgroundColor(selected: Bool, highlighted: Bool) -> UIColor? {
        guard let row = self.row else { return nil }
        if let selectedBackgroundColor = row.selectedBackgroundColor {
            if selected == true || highlighted == true {
                return selectedBackgroundColor
            }
        }
        return row.backgroundColor
    }

}
