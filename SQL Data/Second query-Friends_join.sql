SELECT * FROM friends
		JOIN users ON friends.friend_id = users.user_id
		JOIN statuses ON statuses.user_id = users.user_id;



