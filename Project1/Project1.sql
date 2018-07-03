/* First check what cities there are*/
SELECT *
FROM city_list;

/* Boston, USA is closest to where I live*/
SELECT *
FROM city_data
WHERE city = 'Boston' and country = 'United States';

/* Then get global data*/
SELECT *
FROM global_data;

/*

1. Over time, for the most part, yearly temperatures in Boston have been lower than global temperatures, except
between 1805 and 1810. During those years, the average yearly temperatuer in Boston was above the global temperature.
After about 1843, this temperature difference seems to be consistently lower. Around 1950, Boston's yearly temperature
creeped up again to be close to the global temperature, but it decreased again. Before 1838, temperatures both
in Boston and overall global temperatures seemed to fluctuate a lot, but overall seemed to be mostly flat.

2. The overall changes in the temperature in Boston seem to be consistent with the changes in global temperature,
which seems to be going up over time, starting around 1843, and speeding up starting around 1970.

3. Though the overall trends of increase between global and Boston temperatures seem simiar, the global trends
seem to be more consistent -- slowly increasing over time, while Boston temperatures seem to increase quickly
between 1840 and 1950, decrease between 1950 and 1970, and the increase quickly again.

4. A drastic drop in temperature in  Boston in the 1770s, was about the same time as a slightly less drastic drop
in global temperature.