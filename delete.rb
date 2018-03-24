64.times do |index|
  binary = index.to_s(2)
  zeros_to_add = 6 - binary.length
  binary = '0' * zeros_to_add + binary

  v = Spree::Variant.create(sku: "#{index+1}", price: 5000, is_master: false, product_id: 66, count_on_hand: 5, cost_price: 4000, position: 1)

  v.option_values << if binary[0] == '0'
                       Spree::OptionValue.find(15)
                     else
                       Spree::OptionValue.find(29)
                     end

  v.option_values << if binary[1] == '0'
                       Spree::OptionValue.find(16)
                     else
                       Spree::OptionValue.find(30)
                     end

  v.option_values << if binary[2] == '0'
                       Spree::OptionValue.find(17)
                     else
                       Spree::OptionValue.find(31)
                     end

  v.option_values << if binary[3] == '0'
                       Spree::OptionValue.find(18)
                     else
                       Spree::OptionValue.find(32)
                     end

  v.option_values << if binary[4] == '0'
                       Spree::OptionValue.find(19)
                     else
                       Spree::OptionValue.find(33)
                     end

  v.option_values << if binary[5] == '0'
                       Spree::OptionValue.find(20)
                     else
                       Spree::OptionValue.find(34)
                     end
end
