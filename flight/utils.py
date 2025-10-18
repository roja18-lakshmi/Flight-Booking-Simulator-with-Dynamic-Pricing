from datetime import timedelta, datetime,date
from flight.models import *
from .models import Week, Place, Flight
from tqdm import tqdm
import random
def get_number_of_lines(file):
    with open(file) as f:
        for i, l in enumerate(f):
            pass
    return i + 1

def createWeekDays():
    days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']
    for i,day in enumerate(days):
        Week.objects.create(number=i, name=day)

def addPlaces():
    file = open("./Data/airports.csv", "r")
    print("Adding Airports...")
    total = get_number_of_lines("./Data/airports.csv")
    for i, line in tqdm(enumerate(file), total=total):
        if i == 0:
            continue
        data = line.split(',')
        city = data[0].strip()
        airport = data[1].strip()
        code = data[2].strip()
        country = data[3].strip()
        try:
            Place.objects.create(city=city, airport=airport, code=code, country=country)
        except Exception as e:
            continue
    print("Done.\n")

def addDomesticFlights():
    file = open("./Data/domestic_flights.csv", "r")
    print("Adding Domestic Flights...")
    total = get_number_of_lines("./Data/domestic_flights.csv")
    for i, line in tqdm(enumerate(file), total=total):
        if i == 0:
            continue
        data = line.split(',')
        origin = data[1].strip()
        destination = data[2].strip()
        depart_time = datetime.strptime(data[3].strip(), "%H:%M:%S").time()
        depart_week = int(data[4].strip())
        duration = timedelta(hours=int(data[5].strip()[:2]), minutes=int(data[5].strip()[3:5]))
        arrive_time = datetime.strptime(data[6].strip(), "%H:%M:%S").time()
        arrive_week = int(data[7].strip())
        flight_no = data[8].strip()
        airline = data[10].strip()
        economy_fare = float(data[11].strip()) if data[11].strip() else 0.0
        business_fare = float(data[12].strip()) if data[12].strip() else 0.0
        first_fare = float(data[13].strip()) if data[13].strip() else 0.0

        try:
            a1 = Flight.objects.create(origin=Place.objects.get(code=origin), destination=Place.objects.get(code=destination), depart_time=depart_time , duration=duration, arrival_time=arrive_time, plane=flight_no, airline=airline, economy_fare=economy_fare, business_fare=business_fare, first_fare=first_fare)
            a1.depart_day.add(Week.objects.get(number=depart_week))
            a1.save()
        except Exception as e:
            print(e)
            return
    print("Done.\n")

def addInternationalFlights():
    file = open("./Data/international_flights.csv", "r")
    print("Adding International Flights...")
    total = get_number_of_lines("./Data/international_flights.csv")
    for i, line in tqdm(enumerate(file), total=total):
        if i == 0:
            continue
        data = line.split(',')
        origin = data[1].strip()
        destination = data[2].strip()
        depart_time = datetime.strptime(data[3].strip(), "%H:%M:%S").time()
        depart_week = int(data[4].strip())
        duration = timedelta(hours=int(data[5].strip()[:2]), minutes=int(data[5].strip()[3:5]))
        arrive_time = datetime.strptime(data[6].strip(), "%H:%M:%S").time()
        arrive_week = int(data[7].strip())
        flight_no = data[8].strip()
        airline = data[10].strip()
        economy_fare = float(data[11].strip()) if data[11].strip() else 0.0
        business_fare = float(data[12].strip()) if data[12].strip() else 0.0
        first_fare = float(data[13].strip()) if data[13].strip() else 0.0

        try:
            a1 = Flight.objects.create(origin=Place.objects.get(code=origin), destination=Place.objects.get(code=destination), depart_time=depart_time , duration=duration, arrival_time=arrive_time, plane=flight_no, airline=airline, economy_fare=economy_fare, business_fare=business_fare, first_fare=first_fare)
            a1.depart_day.add(Week.objects.get(number=depart_week))
            a1.save()
        except Exception as e:
            print(e)
            return
    print("Done.\n")



# Existing functions: get_number_of_lines, createWeekDays, addPlaces, addDomesticFlights, addInternationalFlights
# Keep them as-is

def calculate_dynamic_fare(flight, seat_class, depart_date, booked_seats=0, total_seats=180):
    """
    Dynamic fare = base*(1 + seat_factor + time_factor + demand_factor + tier_factor)
    """
    if isinstance(depart_date, datetime):
        depart_date = depart_date.date()  
    # Base fare
    if seat_class == 'economy':
        base_fare = flight.economy_fare
    elif seat_class == 'business':
        base_fare = flight.business_fare
    elif seat_class == 'first':
        base_fare = flight.first_fare
    else:
        return 0

    if not base_fare or base_fare == 0:
        return 0

    # Seat availability factor
    seat_pct = booked_seats / total_seats
    if seat_pct < 0.5:
        seat_factor = 0.0
    elif seat_pct < 0.8:
        seat_factor = 0.15
    else:
        seat_factor = 0.3

    # Time until departure factor
    days_until_departure = (depart_date - datetime.now().date()).days
    if days_until_departure > 30:
        time_factor = -0.1  # early bird discount
    elif days_until_departure > 7:
        time_factor = 0.0
    elif days_until_departure > 3:
        time_factor = 0.1
    else:
        time_factor = 0.3  # last-minute surge

    # Demand factor (simulate random demand)
    demand_factor = random.uniform(0.0, 0.15)

    # Tier factor (seat class adjustment)
    tier_factor = 0.0
    if seat_class == 'business':
        tier_factor = 0.2
    elif seat_class == 'first':
        tier_factor = 0.4

    dynamic_fare = base_fare * (1 + seat_factor + time_factor + demand_factor + tier_factor)

    # Round to nearest 10
    dynamic_fare = round(dynamic_fare / 10) * 10
    print(f"Dynamic fare applied for {flight.airline} ({flight.origin} → {flight.destination}, {seat_class}): {base_fare} → {dynamic_fare}")

    return dynamic_fare
