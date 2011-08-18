atom_feed do |feed|
  feed.title "Who bought #{@product.title}"

  latest_order = @product.orders.sort_by(&:updated_at).last
  feed.updated ( latest_order && latest_order.updated_at)

  @product.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Order #{order.id}"
      entry.summary :type => "xhtml" do |xhtml|
        xhtml.p "shipped to #{order.addresse}"

        xhtml.table do
          xhtml.tr do
            xhtml.th "product"
            xhtml.th "quantity"
            xhtml.th "total_price"
          end
          order.line_items.each do |item|
            xhtml.tr do
              xhtml.td item.product.title
              xhtml.td item.quantity
              xhtml.td number_to_currency item.total_price
            end
          end
          xhtml.tr do
            xhtml.th "total", :colspan => 2
            xhtml.td number_to_currency order.line_items.map(&:total_price).sum
          end
        end

        xhtml.p "Paid by #{order.pay_type}"
      end
      entry.author do |author|
        entry.name order.name
        entry.email order.email
      end
    end
  end
end