
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version- ruby '2.7.2'

* System dependencies- rails "7.0.0"

* Configuration

* Database creation- 
   1.For create database just run command : rails db:create
   2.For migrating database run command: rails db:migrate
  As it's a application for webscrapping so we need to send a input string of linked in profile
  for scrapping.

  On root page there is form for input string and there is json data response from the scrapping which we are sending to api
  so simple end point is just fill the form for rails application and it will save the data to database. Here we are using 
  sqlite database
* How to run the rails application 

  1. For running this application we just run bundle install (make sure you install required ruby and rails version in your system)
  2. After bundle install run we just need to create database by command mentioned above
  3. And last for up rails server simply we need to run command: rails sever
  4. For local we can go to root path http://localhost:3000/ 
  
