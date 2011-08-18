require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product price must be positive" do
    product = Product.new(:title => "my book",
                          :description => "sdlkjdsflkj sdlkfjsldkf",
                          :image_url => "erf.gif")

    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join("; ")

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join("; ")

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(:title => "my",
                :description => "sdfsdf sdfsdfewr",
                :price => 1,
                :image_url => image_url)
  end

  test "image url" do

    ok = %w{ fre.gif fre.jpg fre.png fre.GIF fre.JPG fre.PNG http://f.gh.ch/e/r/t/test.jpg }
    bad = %w{ fre.doc fre.gif/more fred.gif.sh }

    ok.each do |url|
      assert new_product(url).valid?, "#{url} shouldn't be invalid"
    end

    bad.each do |url|
      assert new_product(url).invalid?, "#{url} should be invalid"
    end
  end

end
