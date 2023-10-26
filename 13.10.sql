-- 1
SELECT nick as 'Name', age, rost, ves
FROM users
WHERE
  (nick like '%n%')
  AND (sex = 1)
  AND (age >= 25)
  AND (age <= 35)
  AND (rost >= 160)
  AND (rost <= 180)
  AND (ves >= 50)
  AND (ves <= 70)

-- 2
SELECT * FROM users
WHERE my_build = 2 AND eyes_color = 4 AND hair_color = 1 AND sex = 2
UNION ALL
SELECT * FROM users
WHERE my_build = 4 AND eyes_color = 2 AND hair_color = 4 AND sex = 1;
SELECT 'Total' AS description, COUNT(*) AS total_count FROM users
WHERE (my_build = 2 AND eyes_color = 4 AND hair_color = 1 AND sex = 2)
OR (my_build = 4 AND eyes_color = 2 AND hair_color = 4 AND sex = 1);

-- 3
SELECT *
FROM users
JOIN users_interes usi ON users.user_id = usi.user_id
JOIN interes i ON i.id = usi.interes_id
JOIN users_moles usm ON users.user_id = usm.user_id
JOIN moles m ON m.id = usm.moles_id
WHERE id_framework = 1 AND i.id = 23 AND m.id = 1

-- 4
SELECT u.user_id, u.nick, COUNT(gs.id_to) as gift_count
FROM users u
JOIN gift_service gs ON u.user_id = gs.id_to
WHERE u.id_zodiak = 12
GROUP BY u.user_id, u.nick;

-- 5
SELECT u.id, u.nick, r.name as richness, u.like_kitchen
FROM users u
JOIN richness r ON u.my_rich = r.id
JOIN (
    SELECT user_id, COUNT(languages_id) as lang_count
    FROM users_languages
    GROUP BY user_id
    HAVING COUNT(languages_id) > 5
) ul ON u.user_id = ul.user_id
WHERE u.like_kitchen = 2

-- 6
SELECT 
    '< 18' as age_group,
    COUNT(*) as count,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users)) as percentage
FROM users
WHERE age < 18
UNION ALL
SELECT 
    '18-24' as age_group,
    COUNT(*),
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users))
FROM users
WHERE age BETWEEN 18 AND 24
UNION ALL
SELECT 
    '24-30' as age_group,
    COUNT(*),
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users))
FROM users
WHERE age BETWEEN 24 AND 30
UNION ALL
SELECT 
    '30>=' as age_group,
    COUNT(*),
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users))
FROM users
WHERE age >= 30;