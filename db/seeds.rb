# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Sedes


  lab = Lab.new
  lab.address="Calle Falsa 1235"
  lab.city ="BOGOTA"
  lab.save

  shedule = Shedule.new(lab:lab)
  shedule.save

# Admins

Admin.create(email:"davidcamiloneo@gmail.com",password:"aaaaaaaa",password_confirmation:"aaaaaaaa",name:"David Camilo",bio:"Software Engineer",photo:"photo.jpg",permissions:16,lab: Lab.all.first)
Admin.create(email:"haavendanov@unal.edu.co",password:"nacional",password_confirmation:"nacional",name:"Helmer Andres Avendaño Vargas",bio:"Software Engineer",photo:"photo.jpg",permissions:16,lab: Lab.all.first)

# Users

User.create(email:"davidcamiloneo@gmail.com",password:"asdasd",password_confirmation:"asdasd",user_type:2,doc:"1032462629",city:"Bogotá",address:"Calle 45 A Bis #21A-31",phone:"3145645434",name:"asdasdasd")
User.create(email:"davidcamiloneo2@gmail.com",password:"asdasd",password_confirmation:"asdasd",user_type:2,doc:"1032462626",city:"Bogotá",address:"Calle 45 A Bis #21A-31",phone:"3145645434",name:"asdasdasd")
User.create(email:"davidcamiloneo3@gmail.com",password:"asdasd",password_confirmation:"asdasd",user_type:2,doc:"1032462627",city:"Bogotá",address:"Calle 45 A Bis #21A-31",phone:"3145645434",name:"Helmer Andrés",lastname:"Avendaño")
User.create(email:"compensar@gmail.com",password:"asdasd",password_confirmation:"asdasd",user_type:0,doc:"12312313",city:"Bogotá",address:"Calle 45 A Bis #21A-31",phone:"3145645434",name:"Compensar")
User.create(email:"sinfilas@gmail.com",password:"asdasd",password_confirmation:"asdasd",user_type:1,doc:"12312313",city:"Bogotá",address:"Calle 45 A Bis #21A-31",phone:"3145645434",name:"SinFilas")


PickupRequest.create(latitude:4.710989,longitude:-74.072092,address:"Calle Falsa 123",status:PickupRequest::PENDING,message:"Hola Como Estás?",user:User.all.first,date:Time.now)