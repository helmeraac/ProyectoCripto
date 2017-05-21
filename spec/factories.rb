FactoryGirl.define do
  factory :time_range do
    weekday 1
    start_time "2017-04-26 19:48:01"
    end_time "2017-04-26 19:48:01"
  end
  factory :lab do
    name "Huila"
    address "Calle Falsa 123"
  end
  factory :admin do
    sequence(:email) {|n| "#{n}@#{n}gmail.com"}
    sequence(:password) {|n| "#{n}@#{n}asdasdads"}
    name {"an admin name"}
    photo {File.open(File.join(Rails.root, '/spec/bird.jpg'))}
    bio {"an admin bio"}
  end
  factory :user do
    sequence(:email) {|n| "#{n}@#{n}gmail.com"}
    sequence(:password) {|n| "#{n}@#{n}asdasdads"}
    website {"http://mysite.com"}
    doc {rand(1000000..100000000)}
    address {"a user address"}
    phone {rand(1000000..9999999999)}
    name {"a user name"}
    lastname {"a user lastname"}
  end
  factory :appointment do
    lab
    user
    date {Time.now}
    duration {rand(16..90)}
    status {rand(0..2)}
  end
  factory :category do
    sequence(:name) {|n| "Category - N #{n}"}
  end
  factory :pickup_request do
    latitude {rand(-90..90)}
    longitude {rand(-180..180)}
    address {"Cll 3 # 20-50"}
    status {rand(0..2)}
    user
  end
  factory :post do
    title {"A normal article title"}
    published_date {Time.now - 30.minutes}
    html_body {"<p> Esto seria un parrafo </p>"}
    header_img {"public/images/my_header.png"}
    admin
  end
  factory :result do
    comment {"El paciente presenta altos indices de lo que parece ser algo extrano"}
    upload_date {Time.now - 30.minutes}
    file_path {File.open(File.join(Rails.root, '/spec/test.pdf'))}
    user
  end
  factory :tag do
    sequence(:name) {|n| "Tag - N #{n}"}
  end
  factory :shedule do
    weekdays {"[1,2,3,4,5,6]"}
    hours_per_day {"[10:30,1:00,4:00,7,4,1]"}
    lab
  end
end
