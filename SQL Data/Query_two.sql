
SELECT screen_name, MAX(statuses_count) AS max_votes
           FROM users
         GROUP
             BY screen_name order by max_votes desc limit 1;
             
             

