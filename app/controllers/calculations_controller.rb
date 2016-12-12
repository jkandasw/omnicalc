class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces =@text.count("a-z" "A-Z")

    @word_count = @text.split.count

    @occurrences = @text.index(/[a-z]/)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    # @monthly_payment = @apr/12 * @principal
# (apr_Calc * principal)/((1-(1+apr_Calc)**(months)))
@apr_calc=@apr/1200.to_f
@term_months=-(@years*12)
    @monthly_payment = (@apr_calc * @principal)/((1-(1+@apr_calc)**(@term_months)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
      @starting = Chronic.parse(params[:starting_time])
      @ending = Chronic.parse(params[:ending_time])

      # ==========================================================================
      # Your code goes below.
      # The start time is in the Time @starting.
      # The end time is in the Time @ending.
      # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
      #   So if you subtract one time from another, you will get an integer
      #   number of seconds as a result.
      # ==========================================================================

      @seconds = @ending - @starting
      @minutes = @seconds / 1.minute # 1.minute is just shorthand for 1 * 60
      @hours = @seconds / 1.hour # 1.hour is just shorthand for 1 * 3600
      @days = @seconds / 1.day
      @weeks = @seconds / 1.week
      @years = @seconds / 1.year
    end

    def descriptive_statistics
      @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

      # ==========================================================================
      # Your code goes below.
      # The numbers the user input are in the array @numbers.
      # ==========================================================================

      @sorted_numbers = @numbers.sort

      @count = @numbers.count

      @minimum = @numbers.min

      @maximum = @numbers.max

      @range = @maximum - @minimum

      # Median
      # ======
      if @count.odd?
        @median = @sorted_numbers[@count / 2]
      else
        left_of_middle = @sorted_numbers[(@count / 2) - 1]
        right_of_middle = @sorted_numbers[(@count / 2)]
        @median = (left_of_middle + right_of_middle) / 2
      end


      @sum = @numbers.sum

      @mean = @sum / @count

      # Variance
      # ========
      squared_differences = []

      @numbers.each do |num|
        difference = num - @mean
        squared_difference = difference ** 2
        squared_differences.push(squared_difference)
      end

      @variance = squared_differences.sum / @count


      @standard_deviation = Math.sqrt(@variance)

      # Mode
      # ====

      leader = nil
      leader_count = 0

      @numbers.each do |num|
        occurrences = @numbers.count(num)
        if occurrences > leader_count
          leader = num
          leader_count = occurrences
        end
      end

      @mode = leader
    end
end
