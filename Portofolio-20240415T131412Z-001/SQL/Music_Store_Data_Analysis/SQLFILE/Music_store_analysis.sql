create database MusicStore;
use MusicStore;
select * from employee;
select * from employee order by levels desc limit 1;  #Senior most employee based on job title 
select * from invoice;
select count(*) as c , billing_country from invoice group by billing_country order by c desc; #countries with most invoices
select total from invoice order by total desc limit 3;  #top3 values by total columns 
select billing_city,sum(total)as invoice_total from invoice group by billing_city order by invoice_total desc; #Best customer total wise 
select * from customer;
select c.customer_id,c.first_name,c.last_name,sum(i.total)as invoice_total from customer c join #person who has spent most money 
invoice i on c.customer_id=i.customer_id
group by c.customer_id,c.first_name,c.last_name
order by invoice_total desc
limit 1;
select * from genre;
ALTER TABLE genre
CHANGE COLUMN name genre_name VARCHAR(255);


select distinct email,first_name,last_name from customer    #details related who listens to rock music 
join invoice  on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id IN(
select track_id from track
join genre on track.genre_id=genre.genre_id
where  genre_name = 'Rock')
order by email;

ALTER TABLE artist
CHANGE COLUMN name artist_name VARCHAR(255);

ALTER TABLE track
CHANGE COLUMN name track_name VARCHAR(255);

SELECT artist.artist_id, artist.artist_name, COUNT(track.track_id) AS number_of_songs # top 10 artists with the highest number of songs belonging to the 'Rock' genre
FROM track
JOIN album2 ON album2.album_id = track.album_id
JOIN artist ON artist.artist_id = album2.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.genre_name = 'Rock'
GROUP BY artist.artist_id, artist.artist_name
ORDER BY number_of_songs DESC
LIMIT 10;

select track_name,milliseconds from track where milliseconds > 
(Select avg(milliseconds) as avg_track_length from track)
order by milliseconds desc;

WITH best_selling_artist as(   #the artist with the highest total sales amount based on invoice line items, and then join this information with customer and invoice data to analyze customer spending on tracks associated with the best-selling artist.
select artist.artist_id as id,  #the artist with the highest total sales amount based on invoice line items associated with tracks, albums, and artists.
      artist.artist_name as artist_name,
      sum(invoice_line.unit_price * invoice_line.quantity) as total 
      from invoice_line 
join track on track.track_id=invoice_line.track_id
join album2 on album2.album_id=track.album_id
join artist on artist.artist_id=album2.artist_id
group  by artist.artist_id,artist.artist_name
order by total desc
limit 1 
)

select c.customer_id,
	   c.first_name,
	   c.last_name,
       bsa.artist_name,
       sum(il.unit_price*il.quantity) as amount_spend
       from invoice i 
join customer c on c.customer_id=i.customer_id
join invoice_line il on il.invoice_id=i.invoice_id
join track t on t.track_id=il.track_id
join album2 alb on alb.album_id=t.album_id
join best_selling_artist bsa on bsa.id=alb.artist_id
group by 1,2,3,4
order by 5 desc;

WITH best_selling_artist AS (
    SELECT
        artist.artist_id AS id,
        artist.artist_name AS artist_name,
        SUM(invoice_line.unit_price * invoice_line.quantity) AS total
    FROM
        invoice_line
    JOIN track ON track.track_id = invoice_line.track_id
    JOIN album2 ON album2.album_id = track.album_id
    JOIN artist ON artist.artist_id = album2.artist_id
    GROUP BY
        artist.artist_id, artist.artist_name
    ORDER BY
        total DESC
    LIMIT 1
)

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    bsa.artist_name,
    SUM(il.unit_price * il.quantity) AS amount_spent
FROM
    invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album2 alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.id = alb.artist_id
GROUP BY
    c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY
    amount_spent DESC;


