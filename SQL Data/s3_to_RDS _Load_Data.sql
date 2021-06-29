CREATE TABLE retweets (
    created_date date,
    status_id varchar(255),
    retweeted_status varchar(255),
    lang varchar(255),
    retweet_count int(11),
	`source` varchar(255),
	`text` text,
	user_id varchar(255),
	primary key (user_id)
);


LOAD DATA FROM S3 's3://awsclassproject/retweets.csv' 
    INTO TABLE retweets
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (created_date, status_id, retweeted_status,lang,retweet_count,source,text,user_id);

Table: retweets
Columns:
created_date     		date 
status_id 			varchar(255) PK 
retweeted_status 		varchar(255) 
lang 				varchar(255) 
retweet_count 			int(11) 
source 				varchar(255) 
text 				text 
user_id 			varch(255)


CREATE TABLE friends (
    user_id varchar(255),
    user_screen_name varchar(255),
    friend_id varchar(255),
    friend_screen_name varchar(255),
	primary key (user_id)
);

LOAD DATA FROM S3 's3://awsclassproject/friends.csv' 
    INTO TABLE friends
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (user_id, user_screen_name, friend_id,friend_screen_name);

Table: friends
Columns:
user_id 			varchar(255) PK 
user_screen_name 		varchar(255) 
friend_id 			varchar(255) PK 
friend_screen_name 		varchar(255)

CREATE TABLE favorites (
    status_id varchar(255),
    user_id varchar(255),
    user_screen_name varchar(255)
	primary key (user_id)
);

LOAD DATA FROM S3 's3://awsclassproject/favorites.csv' 
    INTO TABLE favorites
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (status_id, user_id, user_screen_name);

LOAD DATA FROM S3 's3://awsclassproject/favorites.csv' 
    INTO TABLE favorites
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (status_id, user_id, user_screen_name);	

Table: favorites
Columns:
status_id 			varchar(255) PK 
user_id 			varchar(255) PK 
user_screen_name 		varchar(255)


CREATE TABLE statuses (
    created_date date,
    favorites_count int(11),
    status_id varchar(255),
	lang varchar(255),
    retweet_count int(11),
    source varchar(255),
	`text` text,
    truncated tinyint(1),
	user_id varchar(255),
	primary key (status_id)
);

LOAD DATA FROM S3 's3://awsclassproject/statuses.csv' 
    INTO TABLE statuses
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (created_date, favorites_count, status_id,lang,retweet_count,source,text,truncated,user_id);	

Table: statuses
Columns:
created_date 			date 
favorites_count 		int(11) 
status_id 			varchar(255) PK 
lang 				varchar(255) 
retweet_count 			int(11) 
source 				varchar(255) 
text text 
truncated 			tinyint(1) 
user_id 			varchar(255)



CREATE TABLE users (
    created_date date,
    description varchar(255),
    favorites_count int(11),
	friends_count int(11),
    user_id varchar(255),
    listed_count int(11),
	location varchar(255),
	name varchar(255),
	screen_name varchar(255),
    statuses_count int(11),
	url varchar(255),
	verified varchar(255),
	primary key (user_id)
);

LOAD DATA FROM S3 's3://awsclassproject/users.csv' 
    INTO TABLE users
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (created_date, description, favorites_count,friends_count,user_id,
	listed_count,location,name,screen_name,statuses_count,url,verified);	

Table: users

created_date 			date 
description 			varchar(255) 
favorites_count 		int(11) 
friends_count 			int(11) 
user_id 			varchar(255) PK 
listed_count 			int(11) 
location 			varchar(255) 
name 				varchar(255) 
screen_name 			varchar(255) 
statuses_count 			int(11) 
url 				varchar(255)
verified   				tinyin
