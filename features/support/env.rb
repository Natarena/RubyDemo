#!/usr/bin/env ruby
require 'em/pure_ruby'
require 'appium_lib'
require 'appium_console'
require 'cpf_faker'
require 'pry'
require 'faker'
require 'rspec'
require 'credy'
require 'httparty'
require 'flick'
require 'fileutils'
require 'report_builder'
require 'allure-cucumber'
require 'securerandom'
require 'capybara/dsl'
require 'webdrivers'
require 'watir'
require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'test/unit/assertions'
require 'spreadsheet'
require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'roo'
require 'pdf/reader'


require_relative 'screen_helper'
require 'open3'

#### Start Report

Cucumber::Core::Test::Step.module_eval do
  def name
    return text
  end
end

#1- Saber quais caps devemos na nossa sessãoss

if ENV['PLATFORM'].eql?('web')

  World(ScreenHelper)
  World(Test::Unit::Assertions)

  Before {

    case ENV['BROWSER']
    when "chrome"
      # Specify the driver path
      chromedriver_path = File.join(File.absolute_path('..\support', File.dirname(__FILE__)),"drivers","chromedriver.exe")
      Selenium::WebDriver::Chrome.driver_path = chromedriver_path
      $driver = Selenium::WebDriver.for :chrome

    when "firefox"
      capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(acceptInsecureCerts: true)
      $driver = Selenium::WebDriver.for(:firefox, desired_capabilities: capabilities)

    when "ie"
      capabilities = Selenium::WebDriver::Remote::Capabilities.ie(acceptSslCerts: true, ignoreProtectedModeSettings: true)
      $driver = Selenium::WebDriver.for(:ie, desired_capabilities: capabilities)

    end
  }

  # Encerrar sessao
  After {
    #    if ENV['BROWSER'].eql?('chrome')
    #      puts "entrou no after"
    #      $driver.quit
    #    end

  }
  #driver = Selenium::WebDriver.for :firefox
else if ENV['PLATFORM'].nil?
    ENV['PLATFORM'] = 'android'
    caps_path = File.join(File.dirname(__FILE__), '..', '..', 'capabilities','QA',"#{ENV['PLATFORM']}.txt")
  else
    caps_path = File.join(File.dirname(__FILE__), '..', '..', 'capabilities','QA',"#{ENV['PLATFORM']}.txt")
  end

  caps = Appium.load_appium_txt file: caps_path, verbose: true

  #2- Criar um cliente e preparar as caps
  Appium::Driver.new caps, true

  World(ScreenHelper)

  class AppiumWorld
  end

  Appium.promote_appium_methods AppiumWorld

  #3- Iniciar sessao

  Before {
    # stdin, stdout, stderr, wait_thr = Open3.popen3("appium")
    $driver.start_driver
    Utils.convert_driver_webview

  }

  #4 - Encerrar sessao

  After {
    #@utils.quit_appium
    $driver.driver_quit
    # Process.kill("KILL", wait_thr.pid)

  }
end