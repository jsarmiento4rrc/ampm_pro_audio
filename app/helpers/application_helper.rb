module ApplicationHelper
  def render_breadcrumbs
    # Don't show breadcrumbs on the home page
    return if current_page?(root_path)

    crumbs = [link_to('Home', root_path)]

    if controller_name == 'products'
      if action_name == 'index'
        crumbs << 'All Products'
      elsif action_name == 'show' && @product
        crumbs << link_to('Products', products_path)
        
        # Safe navigation: Only try to show category if it exists
        if @product.respond_to?(:category) && @product.category.present?
          crumbs << link_to(@product.category.category_name, products_path(category_id: @product.category.id))
        end
        
        crumbs << @product.product_name
      end
    elsif controller_name == 'carts'
      crumbs << 'Shopping Cart'
    elsif controller_name == 'checkout'
      crumbs << link_to('Cart', cart_path)
      crumbs << 'Checkout'
    end

    # Build the Bulma breadcrumb HTML structure
    content_tag(:nav, class: 'breadcrumb is-small ml-5 mt-2', aria: { label: 'breadcrumbs' }) do
      content_tag(:ul) do
        crumbs.map.with_index do |crumb, index|
          is_last = (index == crumbs.length - 1)
          content_tag(:li, class: (is_last ? 'is-active' : '')) do
            if is_last
              # The last item is just text, not a link
              content_tag(:a, crumb, aria: { current: 'page' })
            else
              # If it's a link (from link_to), it stays a link. If it's a string, wrap it.
              crumb.html_safe? ? crumb : content_tag(:a, crumb)
            end
          end
        end.join.html_safe
      end
    end
  end
end