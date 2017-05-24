# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Cities
cities = ["Barranquilla",
          "Bello",
          "Bogotá",
          "Bucaramanga",
          "Buenaventura",
          "Cali",
          "Cartagena",
          "Cúcuta",
          "Ibagué",
          "Manizales",
          "Medellín",
          "Montería",
          "Neiva",
          "Pasto",
          "Pereira",
          "Santa Marta",
          "Soacha",
          "Soledad",
          "Valledupar",
          "Villavicencio",
          "Yopal"
]

cities.each do |city|
  City.find_or_create_by!(name: city)
end

# Labs
labs =[[
    'Villavicencio' ,'Cra 40 No. 24 –65 => Sótano: 1, Barrio: Bosque Alto, Edificio: CENTRO DE ESPECIALISTAS SOMOS','1234566'],
    ['Cúcuta', 'Calle 18 No. 0 - 50 => Local: 1 - Barrio Blanco','1234566'],
    ['Bogotá' , 'Avenida Calle 127 No. 19 A 28 => Consultorio 305 - Edificio: ACOMEDICA','1234566'],
    ['Yopal' , 'Calle 17 # 27-66 => Barrio Juan Pablo II','1234566']
]

labs.each do |it|
  lab = Lab.find_or_create_by!(address: it[1], city: it[0],phone: it[2])
  schedule = Shedule.find_or_create_by!(lab: lab)

  while schedule.time_ranges.count < 5
    a = rand(10)+1
    time_range_params = {shedule_id: schedule.id, start_time: "#{a}:00 PM", end_time: "#{a+1}:00 PM", weekday: rand(7)}
    time_range = TimeRange.create_time_range(time_range_params)
    time_range.save
  end
end


# Admin

#SuperAdmin
Admin.create!(email: "super@admin.com",
              password: "aaaaaaaa",
              password_confirmation: "aaaaaaaa",
              name: "David Camilo Delgado Arias",
              bio: "Ingeniero de Software de la Universidad Nacional de Colombia con enfasis en desarrollo de aplicaciones web y aplicaciones para dispositivos móviles. Administrador de la Plataforma",
              photo: Rails.root.join("test_files/avatar.png").open,
              permissions: Admin::MASTER,
              lab: Lab.find_by_city("Bogotá"))

#News
Admin.create!(email: "noticias@admin.com",
              password: "aaaaaaaa",
              password_confirmation: "aaaaaaaa",
              name: "Sonia Luque",
              bio: "Gerente de Proyectos Digitales y bacteriologa en CITOPAT. Me encanta escribir noticias sobre el mundo de la salud",
              photo: Rails.root.join("test_files/avatar_girl.png").open,
              permissions: Admin::NEWS,
              lab: Lab.find_by_city("Bogotá"))

#Results
Admin.create!(email: "resultados@admin.com",
              password: "aaaaaaaa",
              password_confirmation: "aaaaaaaa",
              name: "Sonia Sofia Duque Cano",
              bio: "Encargada del area de resultados de CITOPAT. Directora del laboratorio de resultados",
              photo: Rails.root.join("test_files/avatar_girl.png").open,
              permissions: Admin::RESULTS,
              lab: Lab.find_by_city("Bogotá"))

#Appointments and PickupRequests
Admin.create!(email: "extra@admin.com",
              password: "aaaaaaaa",
              password_confirmation: "aaaaaaaa",
              name: "Juan Martín Delgado Moreno",
              bio: "Secretario General Citopat de Colombia. Encargado del manejo de citas y de la logistica relacionada con las solicitudes de recogida de muestras",
              photo: Rails.root.join("test_files/avatar.png").open,
              permissions: Admin::PICKUP_REQUESTS + Admin::APPOINTMENTS,
              lab: Lab.find_by_city("Bogotá"))


# Users
# Particular
User.create(email: "user1@user.com",
            password: "aaaaaaaa",
            password_confirmation: "aaaaaaaa",
            user_type: 2,
            doc: "1032462629",
            city: "Bogotá",
            address: "Calle 45 A Bis #21A-31",
            phone: "3145645434",
            name: "Juana Maria",
            lastname: "Cañizares Almanza")

User.create(email: "user2@user.com",
            password: "aaaaaaaa",
            password_confirmation: "aaaaaaaa",
            user_type: 2,
            doc: "2345465678",
            city: "Bogotá",
            address: "Calle 23A # 56-67",
            phone: "3214567586",
            name: "Diana Paola",
            lastname: "Castillo Moreno")

User.create(email: "user3@gmail.com",
            password: "aaaaaaaa",
            password_confirmation: "aaaaaaaa",
            user_type: 2,
            doc: "1032462629",
            city: "Bogotá",
            address: "Calle 45 A Bis #21A-31",
            phone: "3145645434",
            name: "Laura Angélica",
            lastname: "Puertas Corredor")

# IPS
User.create(email: "ips@user.com",
            password: "aaaaaaaa",
            password_confirmation: "aaaaaaaa",
            user_type: 1,
            doc: "1032462629",
            city: "Bogotá",
            address: "Calle 45 A Bis #21A-31",
            phone: "3145645434",
            name: "IPSALUD S A")
# EPS
User.create(email: "eps@user.com",
            password: "aaaaaaaa",
            password_confirmation: "aaaaaaaa",
            user_type: 0,
            doc: "1032462629",
            city: "Bogotá",
            address: "Calle 45 A Bis #21A-31",
            phone: "3145645434",
            name: "Compensar E.P.S.")


#Appointments

while Appointment.count < 30
  user = User.where(:user_type => User::PARTICULAR).sample
  lab = Lab.all.sample
  hours_available =[]
  random_date = Time.now

  begin
    random_date = Time.now + rand(7).to_i.days
    hours_available = lab.calculate_availability(random_date)
  end while hours_available.count < 1

  appointment_date = DateTime.strptime(random_date.strftime("%m/%d/%Y")+" "+hours_available.sample+" -0500", '%m/%d/%Y %I:%M %p %z')

  appointment = Appointment.new(user: user, status: [Appointment::CONFIRMED, Appointment::COMPLETED, Appointment::CANCELED].sample, date: appointment_date, lab: lab)

  if appointment.status == Appointment::CONFIRMED
    user_requested_appoinments = Appointment.find_by_user_and_status(user.id, Appointment::CONFIRMED)
    if user_requested_appoinments.count < Appointment::MAX_APPOINTMENTS_PER_USER
      appointment.save
    end
  else
    appointment.admin = Admin.where(:email => ["super@admin.com", "extra@admin.com"]).sample
    appointment.save
  end

end

#Results

while Result.count < 40
  user = User.all.sample

  if user.user_type == User::EPS
    name = "Paciente EPS #{user.name}: C.C #{rand(123123)}"
  elsif user.user_type == User::PARTICULAR
    name = "Particular #{user.name} - C.C. #{user.doc}"
  else
    name = "Paciente IPS: C.C - C.C. #{user.doc}"
  end

  Result.create!(lab: Lab.all.sample,
                 user: user,
                 upload_date: Time.now,
                 name: name,
                 file_path: Rails.root.join("test_files/test.pdf").open

  )
end

#Pickup_Requests

while PickupRequest.count < 30
  pickup_request = PickupRequest.new(latitude: rand()*2+2, longitude: rand()*-72-2, address: "Dirección Aleatoria #{rand(10)}", status: [PickupRequest::PENDING, PickupRequest::CONFIRMED, PickupRequest::COMPLETED].sample, message: ["Quisiera solicitar una recogida de muestras", "Necesito una recogida de muestra urgente!", "Quisiera averiguar como funciona el servicio"].sample, user: User.all.sample, date: Time.now+ rand(20).to_i.hours)

  if pickup_request.status == PickupRequest::PENDING
    if PickupRequest.active_for_user(pickup_request.user.id).count < PickupRequest::MAX_PENDING_REQUESTS_PER_USER
      pickup_request.save
    end
  else
    pickup_request.save
  end

end


#Categories and Tags

10.times do |n|
  Category.find_or_create_by!(name: "Categoria #{n+1}")
  Tag.find_or_create_by!(name: "Tag #{n+1}")
end

#News

def gbody(image_1,image_2)
 a= "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam dapibus sem non mollis aliquam. Sed nunc ipsum, luctus mattis lacus vitae, venenatis porta est. Maecenas hendrerit dignissim lectus, vel accumsan purus rhoncus ac. Pellentesque fringilla aliquet ultricies. Cras non rhoncus enim. Donec aliquet aliquet risus placerat egestas. Etiam in ex ac turpis mollis efficitur. Aenean mattis massa feugiat orci interdum ultrices. Praesent pulvinar dapibus aliquet. Phasellus eu enim ut odio elementum sodales. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vivamus efficitur vitae dolor ut egestas.\r\n\r\nPhasellus scelerisque, nunc efficitur ultricies posuere, justo arcu dictum quam, vitae porta lacus nulla in diam. Aliquam eu nisl eu nunc malesuada tincidunt congue ac augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et ullamcorper magna. Maecenas at mi massa. Mauris purus dui, sollicitudin ut laoreet elementum, rutrum ut est. Ut non tortor nunc. Pellentesque vitae enim at metus venenatis malesuada quis quis risus. Ut ipsum arcu, consequat vel faucibus ut, bibendum ut dolor. Nullam at fringilla dolor, eu consequat erat. Donec vel hendrerit est. Nunc luctus ipsum est, ac laoreet odio laoreet id.\r\n\r\nDonec cursus vel mi at rhoncus. Aliquam eu dignissim orci. Aliquam vitae ornare velit. Sed in lacus lobortis, tincidunt mauris ut, aliquet orci. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris eu aliquam sem, et pharetra sapien. Quisque nec elit massa. Duis pulvinar rhoncus pulvinar.</p><p style=\"text-align: center; \"><br></p><hr><p style=\"text-align: center; \"><br></p><p style=\"text-align: center; \"><img src=\"#{image_1.image.url}\" class=\"uploaded_image pull-left img-thumbnail\" id=\"#{image_1.id}\" style=\"width: 455px; float: left; height: 303.676px;\">t egestas. Etiam in ex ac turpis mollis efficitur. Aenean mattis massa feugiat orci interdum ultrices. Praesent pulvinar dapibus aliquet. Phasellus eu enim ut odio elementum sodales. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vivamus efficitur vitae dolor ut egestas. Phasellus scelerisque, nunc efficitur ultricies posuere, justo arcu dictum quam, vitae porta lacus nulla in diam. Aliquam eu nisl eu nunc malesuada tincidunt congue ac augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et ullamcorper magna. Maecenas at mi massa. Mauris purus dui, sollicitudin ut laoreet elementum, rutrum ut est. Ut non tortor nunc. Pellentesque vitae enim at metus venenatis malesuada quis quis risus. Ut ipsum arcu, consequat vel faucibus ut, bibendum ut dolor. Nullam at fringilla dolor, eu consequat erat. Donec vel hendrerit est. Nunc luctus ipsum est, ac laoreet odio laoreet id. Donec cursus vel mi at rhoncus. Aliquam eu dignissim orci. Aliquam vitae ornare velit. Sed in lacus lobortis, tincidunt mauris ut, aliquet orci. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris eu aliquam sem, et pharetra sapien. Quisque nec elit massa. Duis pulvinar rhoncus</p><p style=\"text-align: left;\"><img src=\"#{image_2.image.url}\" class=\"uploaded_image pull-right\" id=\"#{image_2.id}\" style=\"width: 545.925px; height: 251px; float: right;\">consectetur adipiscing elit. Donec et ullamcorper magna. Maecenas at mi massa. Mauris purus dui, sollicitudin ut laoreet elementum, rutrum ut est. Ut non tortor nunc. Pellentesque vitae enim at metus venenatis malesuada quis quis risus. Ut ipsum arcu, consequat vel faucibus ut, bibendum ut dolor. Nullam at fringilla dolor, eu consequat erat. Donec vel hendrerit est. Nunc luctus ipsum est, ac laoreet odio laoreet id. Donec cursus vel mi at rhoncus. Aliquam eu dignissim orci. Aliquam vitae ornare velit. Sed in lacus lobortis, tincidunt mauris ut, aliquet orci. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris eu aliquam sem, et pharetra sapien. Quisque nec elit massa. Duis pulvinar rhoncus pulvinar.</p><p><br></p><hr><p><br></p><p><br></p>"
end

news =[
    ["¿Cada cuánto hay que hacerse una citología?" ,"Cuándo hay que hacerse una citología es una de las dudas más comunes que tienen las mujeres en edad adulta. Se desconoce cuándo hay que comenzar a hacerse este tipo de pruebas, si una vez que se hayan empezado las relaciones sexuales o no, cómo hay que ir preparada, o saber qué sucede después. El jefe del servicio de Ginecología y Obstetricia del Hospital Quironsalud Málaga, Andrés Carlos López, aclara estas preguntas.    ¿En qué consiste es ..."],
   ["Conozca una guía para atender el VPH y el cáncer de cuello uterino", "El año pasado les informaba que en Venezuela estamos en una prevalencia cercana al 75% del VPH, luego de haber entrevistado a la Dra. Tina Correnti, Investigadora, Bióloga e Infectólogo de la Universidad Central de Venezuela, quien realizó un extenso estudio por más de 7 años. Si observamos las cifras publicadas en el 2008, en el Ministerio de Sanidad hoy Ministerio del Poder Popular para la Salud, murieron 1.642 madres de familia, dejando cada una un promedio de 5 huérfanos por año."],
    ["Una simple citología de cuello de útero se acerca al genoma del feto" , "La ciencia continúa investigando cómo conocer las características genéticas de los embriones o fetos lo más pronto posible y sin correr los riesgos, pequeños pero reales, que supone acceder directamente a la barriga de la madre mediante una amniocentesis o una biopsia de corion. La revista Science Translational Medicine publica este miércoles un nuevo avance que acerca la citología del cuello uterino, ampliamente utilizada para detectar de forma precoz el cáncer de cuello de útero, a la secuenciación completa del genoma del feto, y por lo tanto al diagnóstico prenatal del riesgo de anomalías genéticas."],
]

images = ["test_files/banner1.jpg","test_files/banner2.jpg","test_files/banner3.jpg"]


while Post.count < 50
  categories = Category.all.map(&:id).shuffle.each_slice((rand(3)+1)*2).to_a
  tags = Tag.all.map(&:id).shuffle.each_slice((rand(3)+1)*2).to_a
  content = news.sample
  admin = Admin.where(:permissions =>[Admin::MASTER,Admin::NEWS]).sample
  post_image_1 = PostImage.create!(image: Rails.root.join(images.sample).open,admin:admin)
  post_image_2 = PostImage.create!(image: Rails.root.join(images.sample).open,admin:admin)


  post = Post.create!(admin: admin,
               tag_ids: tags.sample,
               category_ids: categories.sample,
               html_summary: content.last,
               title: content.first,
               html_body: gbody(post_image_1,post_image_2),
               header_img: Rails.root.join(images.sample).open,
               post_image_ids:[post_image_1.id,post_image_2.id]
  )
  post_image_1.post =post;
  post_image_2.post =post;
  post_image_1.save
  post_image_2.save


end

