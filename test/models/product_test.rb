require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end
  test 'Product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

    test 'Product price must be positive' do
      product = Product.new(
        title: 'Heres A Title',
        description: 'type of book',
        image_url: 'books.jpg'
      )

      product.price = -1
      assert product.invalid?
      assert_equal ['must be greater than or equal to 0.01'],
        product.errors[:price]

      product.price = 0
      assert product.invalid?
      assert_equal ['must be greater than or equal to 0.01'],
        product.errors[:price]

      product.price = 1
      assert product.valid?
    end

    def new_product(image_url)
      Product.new(
        title: 'My Book Order',
        description: 'This is a book about stuff',
        price: 1,
        image_url: image_url
      )
    end 
    
    test "Image_url" do
      ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
            https://a.b.c/x/y/z/fred.gif }
      bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
      ok.each do | image_url |
        assert new_product(image_url).valid?,
          "#{image_url} should be valid"
      end
    
      bad.each do | image_url |
        assert new_product(image_url).invalid?,
          "#{image_url} shouldn't be valid"
      end
    end

    test "product valid with out unique title" do 
      product = Product.new(
        title: products(:ruby).title,
        description: "yyy",
        price: 1,
        image_url: "fred.gif"
      )

      assert product.invalid?
      assert_equal ['has already been taken'], product.errors[:title]
    end

    # test "product valid with out unique title - I18n" do 
    #   product = Product.new(
    #     title: products(:ruby).title,
    #     description: "yyy",
    #     price: 1,
    #     image_url: "fred.gif"
    #   )

    #   assert product.invalid?
    #   assert_equal [i18n.translate('errors.message.taken')], 
    #           product.errors[:title]
    # end




end

