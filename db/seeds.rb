# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Store.create!(
  name: "ゲンキノモト。平塚店",
  address: "〒254-0034 神奈川県平塚市宝町9-14",
  phone: "0463-27-2008",
  email: "genkinomoto-hiratsuka@email.com",
  line_id: "genkinomoto_line_dummy",
  description: Faker::Lorem.sentences(number: 10),
  opening_time: Time.current.beginning_of_day + 36000, # 10:00:00
  closing_time: Time.current.beginning_of_day + 72000, # 20:00:00
  last_order_time: Time.current.beginning_of_day + 68400, # 20:00:00
  non_business_day: "日曜日",
  working_staff: "1",
  google_map: "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3255.0627195805328!2d139.35094595109592!3d35.329263980181075!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6019ad25a8c32701%3A0x36c45fcb575b1d71!2z5bmz5aGa44K544Od44O844OE44Kx44Ki44K744Oz44K_44O8!5e0!3m2!1sja!2sjp!4v1644463885246!5m2!1sja!2sjp",
  flagship_location: true,
  image: File.open("app/assets/images/store1.jpg")
)

Store.create!(
  name: "ゲンキノモト。厚木店",
  phone: "0463-27-2008",
  email: "genkinomoto-atsugi@email.com",
  line_id: "genkinomoto_line_dummy",
  address: "〒234-0014 神奈川県厚木市旭町2丁目11-5 アポロパレス 101",
  description: Faker::Lorem.sentences(number: 10),
  opening_time: Time.current.beginning_of_day + 36000, # 10:00:00
  closing_time: Time.current.beginning_of_day + 72000, # 20:00:00
  last_order_time: Time.current.beginning_of_day + 68400, # 20:00:00
  non_business_day: "日曜日",
  working_staff: "1",
  google_map: "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3250.729532010515!2d139.36566915109853!3d35.43672948015504!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x60185554fee05891%3A0x4aad0ea8f4ab2da9!2z44Ky44Oz44Kt44OO44Oi44OI44CCQm9keSBDYXJlIFNhbG9uIOWOmuacqOW6lw!5e0!3m2!1sja!2sjp!4v1644465208813!5m2!1sja!2sjp",
  flagship_location: false,
  image: File.open("app/assets/images/store1.jpg")
)

Store.create!(
  name: "ゲンキノモト。小田原店",
  address: "神奈川県 小田原市 某所",
  phone: "0465-48-1009",
  email: "genkinomoto-odawara@email.com",
  line_id: "genkinomoto_line_dummy",
  description: Faker::Lorem.sentences(number: 10),
  opening_time: Time.current.beginning_of_day + 36000, # 10:00:00
  closing_time: Time.current.beginning_of_day + 72000, # 20:00:00
  last_order_time: Time.current.beginning_of_day + 68400, # 20:00:00
  non_business_day: "日曜日",
  working_staff: "1",
  google_map: "https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d26056.285485017193!2d139.190598!3d35.280239!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6019a5905e29d9ad%3A0x9d4ecfce9744b4a2!2z44CSMjU2LTA4MTMg56We5aWI5bed55yM5bCP55Sw5Y6f5biC5YmN5bed77yR77yV77yV4oiS77yR!5e0!3m2!1sja!2sjp!4v1644464272615!5m2!1sja!2sjp",
  flagship_location: false,
  image: File.open("app/assets/images/store1.jpg")
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

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "初回",
  category_title_number: 1,
  category_title_order: 1,
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
  category_number: 1,
  category_order: 1,
  category_title: "初回",
  category_title_number: 1,
  category_title_order: 1,
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
  category_number: 1,
  category_order: 1,
  category_title: "通常",
  category_title_number: 2,
  category_title_order: 2,
  title: "ネイルケア 40分",
  full_title: "通常 ネイルケア 40分",
  charge: 6000,
  description: "（爪のカット・甘皮ケア・爪溝のゴミ除去・コーティング）",
  treatment_time: 40,
  course_number: 3,
  reserve_flag: 1,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "通常",
  category_title_number: 2,
  category_title_order: 2,
  title: "フットケア 40分",
  full_title: "通常 フットケア 40分",
  charge: 6000,
  description: "（タコ、ウオノメ、角質除去・スクラブトリートメント・保湿ケア）",
  treatment_time: 40,
  course_number: 4,
  reserve_flag: 1,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "通常",
  category_title_number: 2,
  category_title_order: 2,
  title: "フットケア／ネイルケア 40分",
  full_title: "フットケア／ネイルケア 40分",
  charge: 6000,
  description: "（タコ、ウオノメ、角質除去・スクラブトリートメント・保湿ケア）",
  treatment_time: 40,
  course_number: 5,
  menu_flag: 1,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "通常",
  category_title_number: 2,
  category_title_order: 2,
  title: "スペシャルセット 60分",
  full_title: "スペシャルセット 60分",
  charge: 9000,
  description: "（ネイルケア＋フットケアのスペシャルセットケア）",
  treatment_time: 60,
  course_number: 6,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "スペシャル",
  category_title_number: 3,
  category_title_order: 3,
  title: "スペシャルセット 40分",
  full_title: "2ヶ月以内 スペシャルセット 40分",
  charge: 5400,
  original_charge: 6000,
  description: "2ヶ月以内に再度フットケアをご予約のお客様は、通常フットケア40分コースを10％OFFいたします。",
  treatment_time: 40,
  course_number: 7,
  menu_flag: 1,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "スペシャル",
  category_title_number: 3,
  category_title_order: 3,
  title: "スペシャルセット 60分",
  full_title: "2ヶ月以内 スペシャルセット 60分",
  charge: 7200,
  original_charge: 9000,
  description: "2ヶ月以内に再度フットケアをご予約のお客様は、通常フットケア60分コースを20％OFFいたします。",
  treatment_time: 60,
  course_number: 8,
  menu_flag: 1,
  store_id: 1
)

# ゲスト用メニュー表示用
Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "巻き爪補正",
  category_title_number: 4,
  category_title_order: 3,
  title: "取り付け",
  full_title: "巻き爪補正 取り付け",
  charge: 3000,
  description: "※ネイルケアまたはフットケアとセットでご予約ください。",
  treatment_time: 0,
  course_number: 9,
  reserve_flag: 1,
  store_id: 1
)

# 予約画面表示用
Menu.create!(
  category: "巻き爪補正",
  category_number: 4,
  category_order: 4,
  category_title: "巻き爪補正",
  category_title_number: 4,
  category_title_order: 3,
  title: "ネイル取り付け１本",
  full_title: "フットケア ネイル取り付け１本",
  charge: 3000,
  description: "40分以上のフットケアコースと合わせてご予約ください。",
  treatment_time: 0,
  add_nail_count: 1,
  course_number: 10,
  menu_flag: 1,
  store_id: 1
)

# 予約画面表示用
Menu.create!(
  category: "巻き爪補正",
  category_number: 4,
  category_order: 4,
  category_title: "巻き爪補正",
  category_title_number: 4,
  category_title_order: 3,
  title: "ネイル取り付け２本",
  full_title: "フットケア ネイル取り付け２本",
  charge: 6000,
  description: "60分以上のフットケアコースと合わせてご予約ください。",
  treatment_time: 0,
  add_nail_count: 2,
  course_number: 11,
  menu_flag: 1,
  store_id: 1
)

Menu.create!(
  category: "Body Care  ~ボディケア~",
  category_number: 2,
  category_order: 2,
  category_title: "全身",
  category_title_number: 5,
  category_title_order: 1,
  title: "全身 80分",
  full_title: "ボディケア 全身 80分",
  charge: 8360,
  description: "※首や肩や腰など気になる部分を中心に揉みほぐします。",
  treatment_time: 80,
  course_number: 12,
  store_id: 1
)

Menu.create!(
  category: "Body Care  ~ボディケア~",
  category_number: 2,
  category_order: 2,
  category_title: "全身",
  category_title_number: 5,
  category_title_order: 1,
  title: "全身 50分",
  full_title: "ボディケア 全身 50分",
  charge: 5170,
  description: "※首や肩や腰など気になる部分を中心に揉みほぐします。",
  treatment_time: 50,
  course_number: 13,
  store_id: 1
)

Menu.create!(
  category: "Body Care  ~ボディケア~",
  category_number: 2,
  category_order: 2,
  category_title: "足ツボ",
  category_title_number: 6,
  category_title_order: 2,
  title: "足ツボ 45分",
  full_title: "ボディケア 足ツボ 45分",
  charge: 4800,
  description: "※ふくらはぎや足裏の反射区をクリームを使ってしっかりと施術します。",
  treatment_time: 45,
  course_number: 14,
  store_id: 1
)

Menu.create!(
  category: "Body Care  ~ボディケア~",
  category_number: 2,
  category_order: 2,
  category_title: "足ツボ",
  category_title_number: 6,
  category_title_order: 2,
  title: "足ツボ 30分",
  full_title: "ボディケア 足ツボ 30分",
  charge: 3190,
  description: "※ひざから下をクリームを使って施術します。",
  treatment_time: 30,
  course_number: 15,
  store_id: 1
) 

Menu.create!(
  category: "Topping  ~トッピング~",
  category_number: 3,
  category_order: 3,
  category_title: "全身",
  category_title_number: 5,
  category_title_order: 1,
  title: "全身 30分",
  full_title: "ボディケア 全身 30分",
  charge: 3190,
  description: "※背中、肩など気になる部分を中心に圧してほぐします。",
  treatment_time: 30,
  course_number: 16,
  store_id: 1
)

Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "DM",
  category_title_number: 7,
  category_title_order: 1,
  title: "スペシャル 60分",
  full_title: "DM スペシャル 60分",
  charge: 6300,
  original_charge: 9000,
  description: "DM持参で通常スペシャル 60分コースを30％OFFいたします。",
  treatment_time: 60,
  course_number: 17,
  menu_flag: 1,
  store_id: 1
)

# 予約画面表示用（２週間以内巻き爪補正単品）
Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "巻き爪補正",
  category_title_number: 4,
  category_title_order: 3,
  title: "ネイル貼り替え１本",
  full_title: "フットケア ネイル貼り替え１本",
  charge: 5000,
  description: "フットケア ネイル貼り替え１本",
  treatment_time: 0,
  course_number: 18,
  menu_flag: 1,
  store_id: 1
)

# 予約画面表示用（２週間以内巻き爪補正単品）
Menu.create!(
  category: "Foot Care  ~フットケア~",
  category_number: 1,
  category_order: 1,
  category_title: "巻き爪補正",
  category_title_number: 4,
  category_title_order: 3,
  title: "ネイル貼り替え２本",
  full_title: "フットケア ネイル貼り替え２本",
  charge: 8000,
  description: "フットケア ネイル貼り替え２本",
  treatment_time: 0,
  course_number: 19,
  menu_flag: 1,
  store_id: 1
)

10.times do |n|
  title  = "サンプルタイトルNo.#{n+1}"
  body = Faker::Lorem.sentences(number: 100)
  Notification.create!(
    title: title,
    body: body,
    staff_id: 1
  )
end
