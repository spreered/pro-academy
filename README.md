# ProAcademy
This is a simple online course system demo.

# Installation

make sure you have installed postgre sql

```
$ brew install postgresql
$ brew services start postgresql
```

clone this repo

```
$ git clone git@github.com:spreered/pro-academy.git

```

prepared rails environment 

```
$ bundle install
$ bundle exec rails db:create
$ bundle exec rails db:migrate

# if you need seed data
$ bundle exec rails db:seed
```

start the server

```
$ bundle exec rails s
```


