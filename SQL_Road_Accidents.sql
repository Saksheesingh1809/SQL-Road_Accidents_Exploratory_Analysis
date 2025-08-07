


USE Road_Accidents;
GO

Select * 
     From [Road_Accident ] ;



 Select * 
	  from [Road_Accident ];


Select sum ( Number_of_casualties) as Total_Casualties
	     From [Road_Accident ] ;


		 -------------------Current Year Casualties --------

Select sum ( Number_of_casualties) as Current_Year_Casualties
	     From [Road_Accident ]
		    Where Year(Accident_Date) = ' 2022' ;


----------------------Fatal Accidents ----------------

Select Accident_Severity , Sum( Number_of_casualties) as Total_Casualties
      From [Road_Accident ] 
		    Group by Accident_Severity;

	----------------Fixing Typo Errors in Data --------

	UPDATE Road_Accident
SET Accident_Severity = 'Fatal'
WHERE Accident_Severity = 'Fetal';



Select Accident_Severity , Sum( Number_of_casualties) as Total_Casualties
      From [Road_Accident ] 
	      Where Accident_Severity = 'Fatal'
		    Group by Accident_Severity;

		------------Current Year Fatal Accidents ---------------

Select Accident_Severity , Sum( Number_of_casualties) as Total_Fatal_Casualties
      From [Road_Accident ] 
	      Where Accident_Severity = 'Fatal' and Year( Accident_Date) = '2022'
		    Group by Accident_Severity;

------------------------------------Current Year fatal Accidents in Dry Conditions------------

			Select Accident_Severity , Sum( Number_of_casualties) as CurrentYear_Fatal_Casualties
      From [Road_Accident ] 
	      Where Accident_Severity = 'Fatal' and Year( Accident_Date) = '2022' and Road_Surface_Conditions = 'Dry'
		    Group by Accident_Severity;

	------------------------------------Current Year Slight Accidents ------------


Select Accident_Severity , Sum( Number_of_casualties) as CurrentYear_Slight_Casualties
      From [Road_Accident ] 
	      Where Accident_Severity = 'Slight' and Year( Accident_Date) = '2022'
		    Group by Accident_Severity;

	------------------------------------Current Year Serious Accidents ------------

	Select Accident_Severity , Sum( Number_of_casualties) as CurrentYear_Slight_Casualties
      From [Road_Accident ] 
	      Where Accident_Severity = 'Serious' and Year( Accident_Date) = '2022'
		    Group by Accident_Severity;


------------------Current Year Total Accidents ------------------------
  
      
	Select Count(Accident_Index) as Total_Current_Year_Accidents 
      From [Road_Accident ] 
	      Where YEAR(Accident_Date) = '2022' ;
	     
	Select Count(Accident_Index) as Total_Accidents 
      From [Road_Accident ] ;



--------------------------------------Casualties by Car ------------


	   Select Sum( Number_of_casualties) as CurrentYear_Car_Casualties
      From [Road_Accident ] 
	      Where vehicle_type ='car' and Year( Accident_Date) = '2022' ;  


		  	   Select Sum( Number_of_casualties) as CurrentYear_Car_Casualties
      From [Road_Accident ] 
	      Where vehicle_type ='car' ;  ---------------------Total Car Casualties------------


-----------------------------Identify High-Risk Locations------------------------------
               ------------Objectives : Find the top 10 Local Authority Districts with the highest number of serious and fatal accidents.


Select top 10 Local_Authority_District ,Accident_Severity, Sum(Number_of_Casualties) as Total_Casualties
         From [Road_Accident ] 
		 where Accident_Severity IN ('Fatal', 'Serious')
		 Group by Local_Authority_District , Accident_Severity
		 Order By Total_Casualties Desc ;


--------------------------------------Time-Based Trend – Accidents by Hour------------
----------------------Objective: Understand the peak accident hours in a day.

	SELECT 
		DATEPART(HOUR, Time) AS Accident_Hour,
		COUNT(*) AS Total_Accidents
	FROM  Road_Accident
	GROUP BY 
		DATEPART(HOUR, Time)
	ORDER BY 
		Total_Accidents DESC ;


---------------------- Weather and Road Surface Impact------------------------------------------
    --Objective: Analyze how weather and road conditions affect accident severity


	Select *
	    From [Road_Accident ] ;

		    
	Select Road_Surface_Conditions , Weather_Conditions
	           Accident_severity, Count(*) as Accident_Count 
			        From [Road_Accident ] 
					Group by Road_Surface_Conditions , Weather_Conditions ,  Accident_severity
			            Order by  Accident_Count Desc ;


-------------------------Vehicle Type Involvement
------------------------------Objective: Most common vehicle types involved in accidents.

	Select 	Distinct Vehicle_Type , Count(*) as Total_Count
                 From [Road_Accident ]
				   Group by Vehicle_Type 
				   Order by Total_Count Desc;


 ------------------------Accident Severity by Road Surface and Weather Conditions
-------------------------------Objective: Identify environmental conditions leading to severe accidents.


Select *
    From [Road_Accident ] ;

   SELECT Road_Surface_Conditions, Weather_Conditions,
    Accident_Severity,
    COUNT(*) AS Accident_Count
              FROM [Road_Accident ]
				 GROUP BY 
					Road_Surface_Conditions,
					Weather_Conditions,
					Accident_Severity
				ORDER BY Accident_Count DESC;


---------------------Peak Accident Times
----------------------Objective: Analyze accident frequency by time of day.


Select  FORMAT(Time , 'HH:00') as Hour_of_day , count(*) as Total_Count
            From  [Road_Accident ]
			  Group by FORMAT(Time , 'HH:00' )
			  Order by Total_Count Desc ;


	
-------------------------------Day of the Week Analysis
-----------------------------Objective: Identify the most accident-prone days.

Select Day_of_week , Count(*) as Total_Count
            From [Road_Accident ] 
			   Group by Day_of_week
			     Order by Total_Count Desc ;


-------------------------------- Police Force Performance vs the accidents 
---------------------Objective: Compare accident handling frequency among police forces.


	SELECT  Police_Force, COUNT(*) AS Cases_Handled
				FROM [Road_Accident ]
		GROUP BY Police_Force
		ORDER BY Cases_Handled DESC;

	SELECT  Police_Force, COUNT(*) AS Cases_Handled , Count(Accident_Index) as Total_Accidents
				FROM [Road_Accident ]
		GROUP BY Police_Force
		ORDER BY Cases_Handled DESC;



 --------------------------------------------------------------------------------------------
 -------------------Casualty Severity by Speed Limit
-----------------Objective: Check how speed limits relate to accident severity.

Select Accident_severity , Speed_Limit , Count(*) as Total_Severity 
             From [Road_Accident ] 
			   Group by Accident_severity , Speed_Limit
			    Order by Total_Severity Desc  ;



----------------------------Junction Type vs Accident Severity
------------------------Objective: Find which junction types are more dangerous

		SELECT 
			Junction_Detail,
			Accident_Severity,
			COUNT(*) AS Accident_Count
		FROM [Road_Accident ]
		GROUP BY Junction_Detail, Accident_Severity
		ORDER BY Accident_Count DESC;


---------------------------------------Urban vs Rural Accidents by Surface Condition
----------------Objective: Urban/rural distribution of accidents under different surface conditions.

Select Urban_or_rural_area , Road_surface_conditions , Count(*) as Total_Count 
              From [Road_Accident ] 
			     Group By Urban_or_rural_area , Road_surface_conditions 
				 Order by Total_Count ;


---------------------------Casualties and VehiclLight conditions-------
-------------------Objective: Analyze impact of lighting on number of casualties and vehicles involved


Select Light_Conditions , Avg(number_of_casualties) as Avg_Casualties ,
                    Avg(number_of_vehicles) as Avg_Vehicles
					  From [Road_Accident] 
					  Group by Light_Conditions
					    Order by Avg_Casualties Desc ;



------------------------------------Weather Effect on Specific Vehicle Types
------------------Objective: See how weather affects different vehicles.

Select Vehicle_type, Weather_conditions , count(*) as Total_Count 
             From [Road_Accident ] 
			   Group By Weather_conditions , Vehicle_type 
			     Order by Total_Count ;

-----Pivot table -----


SELECT *
FROM (
    SELECT 
        Vehicle_Type, 
        Weather_Conditions
        , COUNT(*) AS Total_Count
    FROM Road_Accident
    GROUP BY Vehicle_Type, Weather_Conditions
) AS SourceTable
PIVOT (
    SUM(Total_Count)
    FOR Weather_Conditions IN (
        [Fine + high winds], 
        [Fog or mist], 
        [Raining + high winds], 
        [Raining + no high winds], 
        [Snowing + high winds],
        [Snowing + no high winds],
        [Fine + no high winds],
        [Other]
    )
) AS PivotTable
ORDER BY Vehicle_Type;


                       