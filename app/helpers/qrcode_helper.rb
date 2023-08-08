module QrcodeHelper
  require 'rqrcode'

  def render_qr_code(text, size = 3)
    qr = RQRCode::QRCode.new(text)
    size_style = "width: #{size}px; height: #{size}px;"
    content_tag :table, class: 'qrcode pull-right' do
      qr.modules.each_index do |x|
        concat(content_tag(:tr) do
          qr.modules.each_index do |y|
            color = 'black'
            concat content_tag(:td, nil, class: color, style: size_style)
          end
        end)
      end
    end
  end
end
