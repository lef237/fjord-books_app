# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:cherry_book)

    visit root_path
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test 'visiting the index' do
    visit books_url

    assert_selector 'h1', text: '本'
    assert_selector 'th', text: 'タイトル'
    assert_selector 'th', text: 'メモ'
    assert_selector 'th', text: '著者'
    assert_selector 'th', text: '画像'
    assert_selector 'td', text: 'プロを目指す人のためのRuby入門'
    assert_selector 'td', text: 'チェリー本'
    assert_selector 'td', text: '伊藤さん'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'Ruby超入門'
    fill_in 'メモ', with: 'とてもわかり易い！'
    fill_in '著者', with: '五十嵐さん'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text 'Ruby超入門'
    assert_text 'とてもわかり易い！'
    assert_text '五十嵐さん'
    take_screenshot # この画面のスクリーンショットを撮れる
  end

  test 'updating a Book' do
    visit books_url
    click_on '編集', match: :smart

    fill_in 'タイトル', with: 'Ruby超入門'
    fill_in 'メモ', with: 'とてもわかり易い！'
    fill_in '著者', with: '五十嵐さん'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'Ruby超入門'
    assert_text 'とてもわかり易い！'
    assert_text '五十嵐さん'
  end

  test 'destroying a Book' do
    visit books_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '本が削除されました。'
  end
end
