def consolidate_cart(cart)
  # code here
  cart.each_with_object({}) do |item, info|
    name = item.keys.first
    if info[name]
        info[name][:count] += 1
    else
      info[name] = 
        {price: item[name][:price],
        clearance: item[name][:clearance],
        count: 1}
    end 
  end
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
      if cart[name] && cart[name][:count] >= coupon[:num]
        if cart["#{name} W/COUPON"]
          cart["#{name} W/COUPON"][:count] += 1
        else 
          cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
          cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
        end  
      cart[name][:count] -= coupon[:num]
      end 
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, info|
        if info[:clearance] 
          new_price = info[:price] * 0.80
          info[:price] = new_price.round(2)
        end
  end
end

def checkout(cart, coupons)
  # code here
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  cart.each do |key, value|
    total += (cart[key][:price]*cart[key][:count])
  end 
  
  if total>100 
    total = (total *0.9).round(2)
  end 
  total
end
