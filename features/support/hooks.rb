Before do |scenario|
  $scenario_name = scenario.feature.name.gsub(' ' , '_')
  $result_path = "features/screenshots"
  $folder_name = "#{$result_path}/#{Time.now.strftime('%Y%m%d%H%M%S')}_#{$scenario_name.downcase!}"
  Dir.mkdir($folder_name) unless File.exists?($folder_name)

end

After do |scenario|
  file_name = "screenshot_#{Time.now.strftime('%Y%m%d%H%M%S')}_FAILED.png"

  if ENV['PLATFORM'].eql?('web')

    Dir["#{$folder_name}/screenshotPrint*"].each do |fileName|
      embed fileName , "image/png"
      File.delete("#{fileName}") if File.exist?("#{fileName}")
    end

    screenshot = "#{$folder_name}/#{file_name}"
    $driver.save_screenshot(screenshot)

    if scenario.failed?
      embed screenshot , "image/png"

    end
  else
    Utils.convert_driver_nativo
    $driver.screenshot(File.join($folder_name,file_name))
    Utils.convert_driver_webview

    if scenario.failed?
      embed("#{$folder_name}/#{file_name}", 'image/png')

    end
  end

  if ENV['PLATFORM'].eql?('web')
    $driver.close
    if ENV['BROWSER'].eql?('firefox')
    else
      $driver.quit
    end
  else
    $driver.driver_quit
  end
end

AfterStep do |step|
  file_name = "screenshot_#{Time.now.strftime('%Y%m%d%H%M%S')}_OK.png"

  if ENV['PLATFORM'].eql?('web')

    Dir["#{$folder_name}/screenshotPrint*"].each do |fileName|
      embed fileName , "image/png"
      File.delete("#{fileName}") if File.exist?("#{fileName}")
    end

    screenshot = "#{$folder_name}/#{file_name}"
    $driver.save_screenshot(screenshot)
    embed screenshot , "image/png"
  else
    Utils.convert_driver_nativo
    $driver.screenshot(File.join($folder_name,file_name))
    Utils.convert_driver_webview
    embed("#{$folder_name}/#{file_name}", 'image/png')
  end

end

at_exit do
  ReportBuilder.configure do |config|
    config.input_path = 'features/reports.json'
    config.report_path = 'features/reports'
    config.report_title = 'Gerdau Project - Test Results'
    config.color = 'cyan'
  end
  ReportBuilder.build_report
  FileUtils.cp 'features/reports.html', $folder_name
end

def self.report(name_file)
  embed("#{$folder_name}/#{name_file}", 'image/png')
end

