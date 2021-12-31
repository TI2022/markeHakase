# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Store.create!(
  name: "ゲンキノモト。厚木店",
  phone: "046-000-0001",
  email: "genkinomoto-atsugi@email.com",
  line_id: "genkinomoto_line_dummy",
  address: "神奈川県 厚木市 中央",
  description: Faker::Lorem.sentences(number: 10),
  opening_time: Time.current.beginning_of_day + 36000, # 10:00:00
  closing_time: Time.current.beginning_of_day + 72000, # 20:00:00
  last_order_time: Time.current.beginning_of_day + 68400, # 20:00:00
  non_business_day: "水曜日",
  working_staff: "1",
  image: File.open("app/assets/images/store1.jpg")
)

Store.create!(
  name: "ゲンキノモト。平塚店",
  address: "神奈川県 平塚市 某所",
  phone: "046-000-0002",
  email: "genkinomoto-hiratsuka@email.com",
  line_id: "genkinomoto_line_dummy",
  description: Faker::Lorem.sentences(number: 10),
  opening_time: Time.current.beginning_of_day + 36000, # 10:00:00
  closing_time: Time.current.beginning_of_day + 72000, # 20:00:00
  last_order_time: Time.current.beginning_of_day + 68400, # 20:00:00
  non_business_day: "水曜日",
  working_staff: "1",
  image: File.open("app/assets/images/store1.jpg")
)

Store.create!(
  name: "ゲンキノモト。小田原店",
  address: "神奈川県 小田原市 某所",
  phone: "046-000-0003",
  email: "genkinomoto-odawara@email.com",
  line_id: "genkinomoto_line_dummy",
  description: Faker::Lorem.sentences(number: 10),
  opening_time: Time.current.beginning_of_day + 36000, # 10:00:00
  closing_time: Time.current.beginning_of_day + 72000, # 20:00:00
  last_order_time: Time.current.beginning_of_day + 68400, # 20:00:00
  non_business_day: "水曜日",
  working_staff: "1",
  image: File.open("app/assets/images/store1.jpg")
)

Store.create!(
  name: "ゲンキノモト。イベント開場A",
  address: "神奈川県 海老名市 某所",
  phone: "046-000-0004",
  email: "genkinomoto-event@email.com",
  line_id: "genkinomoto_line_dummy",
  description: Faker::Lorem.sentences(number: 10),
  opening_time: Time.current.beginning_of_day + 36000, # 10:00:00
  closing_time: Time.current.beginning_of_day + 72000, # 20:00:00
  last_order_time: Time.current.beginning_of_day + 68400, # 20:00:00
  non_business_day: "水曜日",
  working_staff: "1",
  image: File.open("app/assets/images/event_site1.jpg")
)



10.times do |n|
  name  = Faker::Name.name
  email = "staff-#{n+1}@email.com"
  password = "password"
  phone = "080-0000-0000"
  store_id = 1
  Staff.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    phone: phone,
    store_id: store_id
  )
end

20.times do |n|
  name = "商品#{n+1} サンプル ボディケア専用オイル 250ml"
  price = (n+1)*100
  description = Faker::Lorem.sentences(number: 10)
  stock = (n+1)
    Item.create!(
      name: name,
      price: price,
      description: description,
      stock: stock,
      image: File.open("app/assets/images/item2.jpg")
    )
end

20.times do |n|
  title = "イベント-#{n+1} サンプルイベント"
  category = "屋外イベント"
  price = (n+1)*1000
  stock = (n+1)
  description = Faker::Lorem.sentences(number: 10)
  remaining_ticket_numbers = (n+1)
  location = "神奈川県厚木市"
  first_date = Date.current + 28
  last_date = Date.current + 48
  start_time = Time.current.beginning_of_day + 36000 # 10:00:00
  end_time = Time.current.beginning_of_day + 72000 # 20:00:00
    Event.create!(
      title: title,
      category: category,
      price: price,
      stock: stock,
      description: description,
      remaining_ticket_numbers: remaining_ticket_numbers,
      location: location,
      first_date: first_date,
      last_date: last_date,
      start_time: start_time,
      end_time: end_time,
      image: File.open("app/assets/images/event1.jpg")
    )
end

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_order: 1,
  category_title: "初回",
  title_order: 1,
  title: "フットケア40分",
  full_title: "初回 フットケア40分",
  charge: 4200,
  description: "下記から1つお選びください。
  ・足のネイルケア・タコ、ウオノメ除去
  ・角質除去・座りダコ",
  treatment_time: 40,
  course_number: 1,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_order: 1,
  category_title: "初回",
  title_order: 1,
  title: "フットケア60分",
  full_title: "初回 フットケア60分",
  charge: 6300,
  description: "足全体のお手入れ",
  treatment_time: 60,
  course_number: 2,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_order: 1,
  category_title: "通常",
  title_order: 2,
  title: "ネイルケア 40分",
  full_title: "通常 ネイルケア 40分",
  charge: 6000,
  description: "（爪のカット・甘皮ケア・爪溝のゴミ除去・コーティング）",
  treatment_time: 40,
  course_number: 3,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_order: 1,
  category_title: "通常",
  title_order: 2,
  title: "フットケア 40分",
  full_title: "通常 フットケア 40分",
  charge: 6000,
  description: "（タコ、ウオノメ、角質除去・スクラブトリートメント・保湿ケア）",
  treatment_time: 40,
  course_number: 4,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_order: 1,
  category_title: "通常",
  title_order: 2,
  title: "スペシャルセット 60分",
  full_title: "通常 スペシャルセット 60分",
  charge: 9000,
  description: "（ネイルケア＋フットケアのスペシャルセットケア）",
  treatment_time: 60,
  course_number: 5,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_order: 1,
  category_title: "巻き爪補正",
  title_order: 3,
  title: "取り付け",
  full_title: "巻き爪補正 取り付け",
  charge: 3000,
  description: "※ネイルケアまたはフットケアとセットでご予約ください。",
  treatment_time: 0,
  course_number: 6,
  store_id: 1
)

Menu.create!(
  category: "Body Care  ~ボディケア~",
  category_order: 2,
  category_title: "全身",
  title_order: 1,
  title: "全身 80分",
  full_title: "ボディケア 全身 80分",
  charge: 8360,
  description: "※首や肩や腰など気になる部分を中心に揉みほぐします。",
  treatment_time: 80,
  course_number: 7,
  store_id: 1
)

Menu.create!(
  category: "Body Care  ~ボディケア~",
  category_order: 2,
  category_title: "全身",
  title_order: 1,
  title: "全身 50分",
  full_title: "ボディケア 全身 50分",
  charge: 5170,
  description: "※首や肩や腰など気になる部分を中心に揉みほぐします。",
  treatment_time: 50,
  course_number: 8,
  store_id: 1
)

Menu.create!(
  category: "Body Care  ~ボディケア~",
  category_order: 2,
  category_title: "足ツボ",
  title_order: 2,
  title: "足ツボ 45分",
  full_title: "ボディケア 足ツボ 45分",
  charge: 4800,
  description: "※ふくらはぎや足裏の反射区をクリームを使ってしっかりと施術します。",
  treatment_time: 45,
  course_number: 9,
  store_id: 1
)

Menu.create!(
  category: "Body Care  ~ボディケア~",
  category_order: 2,
  category_title: "足ツボ",
  title_order: 2,
  title: "足ツボ 30分",
  full_title: "ボディケア 足ツボ 30分",
  charge: 3190,
  description: "※ひざから下をクリームを使って施術します。",
  treatment_time: 30,
  course_number: 10,
  store_id: 1
)

Menu.create!(
  category: "Topping  ~トッピング~",
  category_order: 3,
  category_title: "全身",
  title_order: 1,
  title: "全身 30分",
  full_title: "トッピング 全身 30分",
  charge: 3190,
  description: "※背中、肩など気になる部分を中心に圧してほぐします。",
  treatment_time: 30,
  course_number: 11,
  store_id: 1
)

Top.create!(
  reserve_title: "Web予約手順",
  reserve_text: "①下記項目にご入力いただき、ご確認後、入力内容を送信します。",
  reserve_text_caution: "※この時点では仮の予約となります。予約は確定ではありません。",
  reserve_text2: "②スタッフが申請予約を確認後、折り返しメールにて予約確定の案内を差し上げます。",
  reserve_text2_caution: "※メールが届いた時点で予約が確定になります。",
  reserve_comfirm_title: "○ご確認事項",
  reserve_comfirm_text: "※すでに、スケジュールが埋まっている場合もございます。ご了承ください。
※スケジュールを調整した上、改めてこちらからご連絡いたします。
※送信していただく情報は、ご予約・お問い合わせ対応以外の目的で使用することはありません。
※送信いただいた内容に詳しくお返事するために、メールでなくお電話でご連絡させていただく場合もございます。",
  calendar_title: "現在の予約空き状況",
  introduction_title: "サロン紹介",
  introduction_text: "巻き爪、タコ、ウオノメのケアを中心としたボディケアサロンです。
巻き爪ケアは痛みが少なく短い爪でも補正ができ、ご好評をいただいています！
皆様のご来店をお待ちしています。",
  introduction_address: "〒254-0034 神奈川県平塚市宝町9-14 平塚スポーツケアセンター2階",
  introduction_time: "11:00〜20:00(18:00最終受付)",
  introduction_holiday: "日曜日",
  introduction_tel: "0463-27-2008",
  slide_number: 0,
  image_order: 1,
  slide_image_count: 3,
  introduction_image_count: 2,
  image_text: "一番目の画像",
  store_id: 1
)

10.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  phone = "080-0000-0000"
  store_id = 1
  cart_id = n+1
  postal_code = 2430000
  prefecture_code = "神奈川県"
  city = "厚木市"
  street = "戸室"
  other_address = "1-1-1"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    phone: phone,
    store_id: store_id,
    cart_id: cart_id,
    postal_code: postal_code,
    prefecture_code: prefecture_code,
    city: city,
    street: street,
    other_address: other_address
  )
  Cart.create!(
    user_id: n+1
  )
  time = Time.current
  Order.create!(
    cart_id: n+1,
    item_id: n+1,
    quantity: n+1,
    paid_at: time,
    payment_id: n+1,
    shipped_at: time
  )
  EventOrder.create!(
    cart_id: n+1,
    event_id: n+1,
    quantity: n+1,
    paid_at: time,
    payment_id: n+1,
    shipped_at: time
  )
  item = Item.find(n+1)
  event = Event.find(n+1)
  subtotal = (item.price + event.price)*(n+1)
  if subtotal >= 5000 || subtotal == 0
    shipping_fee = 0
  else
    shipping_fee = 500
  end
  tax = ((subtotal+shipping_fee)*0.10).round
  total = subtotal+shipping_fee+tax
  Payment.create!(
    cart_id: n+1,
    subtotal: subtotal,
    tax: tax,
    shipping_fee: shipping_fee,
    total: total,
    all_shipped_at: time
  )

end



