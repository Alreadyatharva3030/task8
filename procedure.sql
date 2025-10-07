CREATE PROCEDURE GetPassengerBookings(IN p_name VARCHAR(100))
BEGIN
    SELECT p.passenger_name, f.flight_name, b.booking_date, b.travel_date
    FROM Passengers p
    JOIN Bookings b ON p.passenger_id = b.passenger_id
    JOIN Flights f ON b.flight_id = f.flight_id
    WHERE p.passenger_name = p_name;
END $$

-- Function: Calculate total bookings for a specific flight
CREATE FUNCTION CountBookingsForFlight(flightName VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Bookings b
    JOIN Flights f ON b.flight_id = f.flight_id
    WHERE f.flight_name = flightName;
    RETURN total;
END $$

DELIMITER ;

-- Call Stored Procedure
CALL GetPassengerBookings('Atharva');

-- Use Function
SELECT CountBookingsForFlight('Air India AI101') AS Total_Bookings;
