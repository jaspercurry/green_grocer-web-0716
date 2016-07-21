def consolidate_cart(cart)
  final = {}
  list = []
  cart.each do |names|
    list << names.keys[0]
  end
  cart.each do |item|
    final[item.keys[0]] = item[item.keys[0]] 
    final[item.keys[0]][:count] = list.count(item.keys[0])
  end
  final
end

def apply_coupons(cart, coupons)
  coupons.each do |coup|
    if cart[coup[:item]] == nil
      puts "Please enter a valid coupon"
    elsif coup[:num] <= cart[coup[:item]][:count]
        num = cart[coup[:item]][:count] - coup[:num]
        cart[coup[:item]][:count] = num
        name = "#{coup[:item]} W/COUPON" 
        cart[name] ||= {} 
        cart[name][:price] = coup[:cost] 
        cart[name][:clearance] = cart[coup[:item]][:clearance] 
        cart[name][:count] ||= 0
        cart[name][:count] += 1
    else
        puts "Not valid - not enough items to use coupon"
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |k, v|
    if v[:clearance]
      v[:price] = (v[:price]*0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0
    cart.each do |k, v|
      total += v[:price]*v[:count]
    end
    if total > 100
      total = total*(0.9)
    end
    total
end

def apply_coupons2(cart, coupons)
  coupons.each do |coup|
    if cart[coup[:item]] == nil
      puts "Please enter a valid coupon"
    elsif coup[:num] <= cart[coup[:item]][:count]
        num = cart[coup[:item]][:count] - coup[:num]
        cart[coup[:item]][:count] = num
        name = "#{coup[:item]} W/COUPON" 
        cart[name] = {} 
        cart[name][:price] = coup[:cost] 
        cart[name][:clearance] = cart[coup[:item]][:clearance] 
        cart[name][:count] = 1
    else
        puts "Not valid - not enough items to use coupon"
    end
  end
  cart
end

