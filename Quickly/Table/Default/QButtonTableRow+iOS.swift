//
//  Quickly
//

#if os(iOS)

    open class QButtonTableRow: QBackgroundColorTableRow {

        public var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero
        public var height: CGFloat = 44

        public var buttonContentHorizontalAlignment: UIControlContentHorizontalAlignment = .center
        public var buttonContentVerticalAlignment: UIControlContentVerticalAlignment = .center
        public var buttonContentInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        public var buttonImagePosition: QButtonImagePosition = .left
        public var buttonImageInsets: UIEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        public var buttonTextInsets: UIEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        public var buttonNormalStyle: QButtonStyle?
        public var buttonHighlightedStyle: QButtonStyle?
        public var buttonDisabledStyle: QButtonStyle?
        public var buttonSelectedStyle: QButtonStyle?
        public var buttonSelectedHighlightedStyle: QButtonStyle?
        public var buttonSelectedDisabledStyle: QButtonStyle?
        public var buttonSpinnerPosition: QButtonSpinnerPosition = .fill
        public var buttonSpinnerView: QSpinnerView?
        public var buttonIsSpinnerAnimating: Bool = false
        public var buttonIsSelected: Bool = false
        public var buttonIsEnabled: Bool = true

    }

#endif
