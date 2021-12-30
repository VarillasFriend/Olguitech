require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    setup do
        @product = products(:one)
        @product2 = products(:two)
    end

    test 'should change title language with locale' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @product.get_title)

        I18n.locale = :en

        assert_equal('English - Lorem Ipsum', @product.get_title)
    end

    test 'should cut title correctly' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @product.get_short_title)

        assert_equal(
            '12345678901234567890123456789012345678901234567890...',
            @product2.get_short_title,
        )
    end

    test 'should change desc language with locale' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @product.get_desc,
        )

        I18n.locale = :en

        assert_equal(
            'English - Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @product.get_desc,
        )
    end

    test 'should cut desc correctly' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ...',
            @product.get_short_desc,
        )

        assert_equal(
            '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890',
            @product2.get_short_desc,
        )
    end

    test 'should get content and change it with locale' do
        I18n.locale = :es

        assert_equal(ActionText::RichText.find(5), @product.get_content)

        I18n.locale = :en

        assert_equal(ActionText::RichText.find(6), @product.get_content)
    end

    test 'should add articles, projects and categories' do
        @product.change_related([1, 2], [1, 2], [1, 2])

        assert_equal(Article.all, @product.articles)
        assert_equal(Proyecto.all, @product.proyectos)
        assert_equal(Category.all, @product.categories)
    end

    test 'should change articles, projects and categories' do
        @product.change_related([1], [2], [1])

        assert_equal([Article.find(1)], @product.articles)
        assert_equal([Proyecto.find(2)], @product.proyectos)
        assert_equal([Category.find(1)], @product.categories)

        @product.change_related([], [], [])

        assert_equal([], @product.articles)
        assert_equal([], @product.proyectos)
        assert_equal([], @product.categories)
    end

    test 'should get uncategorized' do
        @product.change_related([], [], [])
        @product2.change_related([], [], [1])

        assert_equal([@product], Product.uncategorized)

        @product.change_related([], [], [1])
        @product2.change_related([], [], [])

        assert_equal([@product2], Product.uncategorized)
    end
end
