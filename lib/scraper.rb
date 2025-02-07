require 'nokogiri'
require 'open-uri'
require "pry"

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  def get_page
    html = URI.open(URI.parse("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    Nokogiri::HTML(html)
  end
  def get_courses
    page = get_page
    courses =page.css(".post")
    # binding.pry
  end
  def make_courses
    get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css("em").text
      course.description = post.css("p").text
    end

  end
end

sc = Scraper.new
sc.make_courses
