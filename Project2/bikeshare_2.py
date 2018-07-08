import time
import pandas as pd
import numpy as np

CITY_DATA = { 'chicago': 'chicago.csv',
              'new york city': 'new_york_city.csv',
              'washington': 'washington.csv' }

def get_filters():
    """
    Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    """
    print('Hello! Let\'s explore some US bikeshare data!')
    # get user input for city (chicago, new york city, washington). HINT: Use a while loop to handle invalid inputs
    isValid = False
    city = ''
    month = ''
    day = ''
    while not isValid:
        input_city = (input('Enter the city which you want data for: ')).lower()
        if city == 'chicago' or city == 'new york city' or city == 'washington':
            isValid = True
        else:
            print('invalid input, try again')
    isValid = False
    # get user input for month (all, january, february, ... , june)
    while not isValid:
        month = input('Enter the month: ').lower()
        if (month == 'january' or month == 'february' or month == 'march' or month == 'april'
        or month == 'may' or month == 'june' or month == 'july' or month == 'august'
        or month == 'september' or month == 'october' or month == 'november' or month == 'december'):
            isValid = True
        else:
            print('invalid input, try again')
    isValid = False

    # get user input for day of week (all, monday, tuesday, ... sunday)
    while not isValid:
        day = (input('Enter the day of the week which you want data for ')).lower()
        if day == 'monday' or day == 'tuesday' or day == 'wednesday' or day == 'thursday' or day == 'friday' or day == 'saturday' or day == 'sunday':
            isValid = True
        else:
            print('invalid input, try again')
    isValid = False

    print('-'*40)
    return city, month, day


def load_data(city, month, day):
    """
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    Returns:
        df - Pandas DataFrame containing city data filtered by month and day
    """

    # load data file into a dataframe
    df = pd.read_csv(CITY_DATA[city])

    # convert the Start Time column to datetime
    df['Start Time'] = pd.to_datetime(df['Start Time'])

    # extract month and day of week from Start Time to create new columns
    df['month'] = df['Start Time'].dt.month
    df['day_of_week'] = df['Start Time'].dt.weekday_name


    # filter by month if applicable
    if month != 'all':
        # use the index of the months list to get the corresponding int
        months = ['january', 'february', 'march', 'april', 'may', 'june']
        month = months.index(month) + 1
    
        # filter by month to create the new dataframe
        df = df[df['month'] == month]

    # filter by day of week if applicable
    if day != 'all':
        # filter by day of week to create the new dataframe
        df = df[df['day_of_week'] == day.title()]
    
    return df


def time_stats(df):
    """Displays statistics on the most frequent times of travel."""

    print('\nCalculating The Most Frequent Times of Travel...\n')
    start_time = time.time()

    # display the most common month
    print('Month: ' + str(df['month'].mode()[0]))

    # display the most common day of week
    print('Weekday: ' + df['day_of_week'].mode()[0])

    # display the most common start hour
    print('Hour: ' + str(df['Start Time'].dt.hour.mode()[0]))

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def station_stats(df):
    """Displays statistics on the most popular stations and trip."""

    print('\nCalculating The Most Popular Stations and Trip...\n')
    start_time = time.time()

    # display most commonly used start station
    start_station = df['Start Station'].mode()[0]
    print('Most popular start station: ' + start_station)

    # display most commonly used end station
    end_station = df['End Station'].mode()[0]
    print('Most popular end station: ' + end_station)

    # display most frequent combination of start station and end station trip
    df['start_end_intersection'] = 'Start: ' + df['Start Station'] + ', End: ' + df['End Station']
    start_end_intersection = df['start_end_intersection'].mode()
    for i in range(len(start_end_intersection)):
        print('Most popular combination of start and end station: ' + start_end_intersection[i])

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""

    print('\nCalculating Trip Duration...\n')
    start_time = time.time()

    # display total travel time
    total_seconds = df['Trip Duration'].sum() % 60
    total_minutes = df['Trip Duration'].sum() // 60
    total_hours = total_minutes // 60
    extra_minutes = total_minutes % 60
    result = 'Total time spent travelling: \nhours: {}, minutes: {}, seconds: {}'
    print(result.format(total_hours, extra_minutes, total_seconds))

    # display mean travel time
    mean_total_seconds = df['Trip Duration'].mean()
    mean_minutes = int(mean_total_seconds // 60)
    mean_seconds = int(mean_total_seconds % 60)
    result = 'Mean travel time:\nminutes: {}, seconds: {}'
    print(result.format(mean_minutes, mean_seconds))

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def user_stats(df):
    """Displays statistics on bikeshare users."""

    print('\nCalculating User Stats...\n')
    start_time = time.time()

    # Display counts of user types
    print(df['User Type'].value_counts())

    # Display counts of gender
    if 'Gender' in df.columns:
        print(df['Gender'].value_counts())
    else:
        print('Gender not included in this dataset')

    # Display earliest, most recent, and most common year of birth
    if 'Birth Year' in df.columns:
        earliest_year = df['Birth Year'].min()
        recent_year = df['Birth Year'].max()
        common_year = df['Birth Year'].mode()[0]
        result = 'Earliest year: {}\nMost recent year: {}\nMost common year: {}'
        print(result.format(earliest_year, recent_year, common_year))
    else:
        print('Birth year not included in this dataset')

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def main():
    while True:
        city, month, day = get_filters()
        df = load_data(city, month, day)

        time_stats(df)
        station_stats(df)
        trip_duration_stats(df)
        user_stats(df)

        restart = input('\nWould you like to restart? Enter yes or no.\n')
        if restart.lower() != 'yes':
            break


if __name__ == "__main__":
	main()
