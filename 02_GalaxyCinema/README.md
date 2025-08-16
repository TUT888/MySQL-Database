# Galaxy Cinema
Database design for single cinema

## Requirement
- There are many Films has name, length of film in minutes, type, country
- Cinema also has rooms and a room can show different films in different time in a day (we can call that's screening aka "xuất chiếu")
- A room has many seats with different seat type (normal, couple, luxury, etc). Each room has different number of seat and the seats map can be set up different for each room.
- One time booking, customer can book more than 1 seat. Seat have number and row info

## Query
1. Show film over 100mins
2. Which film over average length of all films
3. Which film has name start with letter 't'
4. Which film contain letter 'a'
5. How many film in US?
6. what is the longest, and shortest length of all film
7. Show unique film types of all film (NO DUPLICATE)
8. What is the distance (in days) of the 1st and the last film
9. Show all Screening Information including film name, room name, time of film "Tom&Jerry"
10. show all screening in 2 day '2022-05-25' and '2022-05-25'. 
    - Show film which dont have any screening
11. Who book more than 1 seat in 1 booking
12. Show room show more than 2 film in one day
13. which room show the least film ?
14. what film don't have booking
15. WHAT film have show the biggest number of room?
16. Show number of film that show in every day of week and order descending
17. show total length of each film that showed in 28/5/2022
18. What film has showing time above and below average show time of all film
19. what room have least number of seat?
20. what room have number of seat bigger than average number of seat of all rooms
21. Ngoai nhung seat mà Ong Dung booking duoc o booking id = 1 thi ong CÓ THỂ (CAN) booking duoc nhung seat nao khac khong?
22. Show Film with total screening and order by total screening. BUT ONLY SHOW DATA OF FILM WITH TOTAL SCREENING > 10
23. TOP 3 DAY OF WEEK based on total booking
24. CALCULATE BOOKING rate over screening of each film ORDER BY RATES.
25. CONTINUE Q15 -> WHICH film has rate over/below/equal average ?.
26. TOP 2 people who enjoy the least TIME (in minutes) in the cinema based on booking info - only count who has booking info (example : Dũng book film tom&jerry 4 times -> Dũng enjoy 90 mins x 4)
