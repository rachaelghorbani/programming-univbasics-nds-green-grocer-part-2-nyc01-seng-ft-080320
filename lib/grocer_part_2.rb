require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    
    coupon_item = find_item_by_name_in_collection(coupon[:item], cart)
    in_basket = !!coupon_item
    enough_items = in_basket && coupon_item[:count] >= coupon[:num]
    if enough_items 
      cart.push(
           {:item => "#{coupon_item[:item]} W/COUPON",
            :price => coupon[:cost]/coupon[:num],
            :clearance => coupon_item[:clearance],
            :count => coupon[:num]} 
        )
        coupon_item[:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item_hash|
    current_item = find_item_by_name_in_collection(item_hash[:item], cart)
    item_exists = !!current_item
    if item_exists && current_item[:clearance]
      current_item[:price] *= 0.8 
      current_item[:price] = current_item[:price].round(2)
    end
  end
 return cart
end




def checkout(cart, coupon)
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupon)
  final_cart = apply_clearance(coupons_applied)

  cart_total = 0
  final_cart.each do |item_hash|
  item_total_price = item_hash[:price] * item_hash[:count]
  cart_total += item_total_price
  end
  if cart_total > 100
    cart_total *= 0.9
  end

return cart_total
end

