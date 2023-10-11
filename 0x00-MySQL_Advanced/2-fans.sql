-- 2. Best band ever
SELECT
  origin,
  SUM(fans) as nb_fans
FROM metal_bands
WHERE LOCATE(',', origin) <= 0
GROUP BY origin
ORDER BY nb_fans DESC;
