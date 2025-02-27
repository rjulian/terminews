# frozen_string_literal: true

require 'curses'

Curses.init_screen
Curses.start_color
Curses.noecho

Curses.init_pair(1, Curses::COLOR_BLACK, Curses::COLOR_WHITE)
Curses.init_pair(2, Curses::COLOR_RED, Curses::COLOR_WHITE)
Curses.init_pair(3, Curses::COLOR_WHITE, Curses::COLOR_RED)
Curses.init_pair(4, Curses::COLOR_RED, Curses::COLOR_BLACK)

my_str = "NEW REALITY TV SHOW DEBUTS: \n THE BACHELOR, POVERTY STRICKEN"

MAX_COLUMNS = 4
MAX_ROWS = 6
height = Curses.lines / MAX_ROWS
width = Curses.cols / MAX_COLUMNS
full_window = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
MAX_ROWS.times do |row|
  MAX_COLUMNS.times do |time|
    top = row * height
    left = time * width
    boxed_headline = full_window.subwin(height, width, top, left)
    boxed_headline.bkgd(Curses.color_pair(1))
    if time.zero? && row.zero?
      boxed_headline.box('*', '*')
    else
      boxed_headline.box('+', '-')
    end
    boxed_headline.refresh
    background_array = [Curses.color_pair(3), Curses.color_pair(2), Curses.color_pair(1), Curses.color_pair(4)]
    text_area_window = boxed_headline.subwin(height - 4, width - 4, top + 2, left + 2)
    text_area_window.bkgd(background_array.sample)

    text_area_window.setpos(2, 0)
    if time.zero? && row.zero?
      text_area_window.attron(Curses::A_BOLD)
      text_area_window.addstr("THE TERMINAL TIMES. \n")
      text_area_window.addstr("BREAKING NEWS. \n")
      text_area_window.attron(Curses::A_UNDERLINE)
      text_area_window.addstr("YOU NEED TO KNOW.")
    else
      text_area_window.addstr(my_str)
    end
    boxed_headline.refresh
    text_area_window.refresh
  end
end

full_window.getch
full_window.close
