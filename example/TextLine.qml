Widget {
    id: textedit
    property Function whenValue: nil
    property Object   valueRef:  nil
    onExtern: {
        ref = OSC::RemoteParam.new($remote, textedit.extern)
        ref.callback = lambda {|x|
            textedit.label = x;
            textedit.damage_self
        }
        textedit.valueRef = ref
    }
    function draw(vg)
    {
        background Theme::GeneralBackground
        vg.font_face("bold")
        vg.font_size h*0.8
        vg.text_align NVG::ALIGN_LEFT | NVG::ALIGN_MIDDLE
        vg.fill_color = Theme::TextColor
        l = label.empty? ? "..." : label
        vg.text(8,h/2,l.upcase)
    }

    function onKey(k)
    {
        puts k.ord
        if(k.ord == 8)
            self.label = self.label[0...-1]
        else
            self.label += k
        end
        whenValue.call if whenValue
        valueRef.value = self.label if valueRef
        damage_self
    }

    function onMerge(val)
    {
        self.label = val.label
    }
}