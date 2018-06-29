//
//  Quickly
//

public final class QButtonStyle : IQButtonStyle {

    public weak var parent: IQButtonStyle?

    public var color: UIColor? {
        set(value) { self._color = value }
        get {
            if let value = self._color { return value }
            if let parent = self.parent { return parent.color }
            return nil
        }
    }
    private var _color: UIColor?

    public var border: QViewBorder? {
        set(value) { self._border = value }
        get {
            if let value = self._border { return value }
            if let parent = self.parent { return parent.border }
            return nil
        }
    }
    private var _border: QViewBorder?

    public var cornerRadius: QViewCornerRadius? {
        set(value) { self._cornerRadius = value }
        get {
            if let value = self._cornerRadius { return value }
            if let parent = self.parent { return parent.cornerRadius }
            return nil
        }
    }
    private var _cornerRadius: QViewCornerRadius?

    public var shadow: QViewShadow? {
        set(value) { self._shadow = value }
        get {
            if let value = self._shadow { return value }
            if let parent = self.parent { return parent.shadow }
            return nil
        }
    }
    private var _shadow: QViewShadow?

    public var image: IQImageSource? {
        set(value) { self._image = value }
        get {
            if let value = self._image { return value }
            if let parent = self.parent { return parent.image }
            return nil
        }
    }
    private var _image: IQImageSource?

    public var text: IQText? {
        set(value) { self._text = value }
        get {
            if let value = self._text { return value }
            if let parent = self.parent { return parent.text }
            return nil
        }
    }
    private var _text: IQText?

    public init() {
    }

    public init(parent: IQButtonStyle) {
        self.parent = parent
    }

    public init(parent: IQButtonStyle, text: IQText) {
        self.parent = parent
        self.text = text
    }

    public init(parent: IQButtonStyle, image: IQImageSource) {
        self.parent = parent
        self.image = image
    }

}
