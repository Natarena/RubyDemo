class Utils
  def get_status_appium
    begin
      Process.getpgid('appium')
      return true
    rescue Errno::ESRCH
      return false
    end
  end

  def start_appium

    unless get_status_appium true

    end
  end

  def quit_appium

    unless get_status_appium false

    end
  end

  if ENV['PLATFORM'].eql?('web')
  else
    def self.convert_driver_nativo
      context = $driver.available_contexts
      $driver.set_context(context[0])

    end

    def self.convert_driver_webview
      context = $driver.available_contexts

      if ENV['PLATFORM'] == "android"
        $driver.set_context("WEBVIEW_com.accenture.autobusca")
      else
        $driver.set_context(context[1])
      end

    end
  end

  def self.apaga_dados_input(tamanho)
    i = 0
    while i < tamanho do
      $driver.press_keycode(67)
      i = i + 1
    end
  end

  def self.print_web
    file_name = "screenshotPrint_#{Time.now.strftime('%Y%m%d%H%M%S')}_OK.png"
    screenshot = "#{$folder_name}/#{file_name}"
    $driver.save_screenshot(screenshot)
    sleep(2)
  end

  def self.open_excel(path)
    workbook = nil
    Dir[path].each do |fileName|
      workbook = Roo::Spreadsheet.open(fileName)
    end
    return workbook
  end

  def self.check_email_content(values_validation)
    validation = true
    textEmail = $driver.find_elements(:css, ".ii.gt")[0].attribute("innerText")

    if values_validation.include?(",")
      values = values_validation.split(",")
      cont = 0

      while values.size > cont
        if textEmail.include?(values[cont])
          puts values[cont] + " is in the email"
        else
          validation = false
          break
        end
        cont = cont + 1
      end
    else
      values = values_validation
      if textEmail.include?(values)
        puts values + " is in the email"
      else
        validation = false
      end
    end

    evidences = $driver.find_elements(:css, ".ii.gt")[0].find_elements(:tag_name, "tr")
    puts evidences.size
    if evidences.size > 12
      begin
        $driver.action.move_to(evidences[4]).perform
        Utils.print_web
        $driver.action.move_to(evidences[8]).perform
        Utils.print_web
        $driver.action.move_to(evidences[12]).perform
      rescue
      end
    end

    return validation
  end

  def self.open_pdf(name_pdf)
    validate = false
    path = Dir.home + "/Downloads/"+name_pdf+"*.pdf"

    Dir[path].each do |file_Name|
      if File.exist?(file_Name)
        $driver.navigate.to file_Name
        sleep(5)
        validate = true
      end
    end
    Utils.print_web
    Dir[path].each do |fileName|
      FileUtils.cp fileName, $folder_name
      File.delete("#{fileName}") if File.exist?("#{fileName}")
    end
    return validate
  end

  def self.verify_pdf(name_pdf, values_validate)
    validate = false
    values = values_validate.split(',')
    path = Dir.home + "/Downloads/"+name_pdf+"*"
    #binding.pry
    Dir[path].each do |file_Name|
      if File.exist?(file_Name)
        #accessSite("#{file_Name}")
        $driver.navigate.to file_Name
        sleep(5)
        reader = PDF::Reader.new(file_Name)
        reader.pages.each do |page|
          valuePdf = page.text
          cont = 0
          while values.size > cont
            if valuePdf.include?(values[cont].tr(" ",""))
              validate = true
            else
              $returnError = "Data in file not verified."
              break
            end
            cont = cont +1
          end

        end

      else
        $returnError = "File not found. Didn't download"
      end
    end
    Utils.print_web
    Dir[path].each do |fileName|
      FileUtils.cp fileName, $folder_name
      File.delete("#{fileName}") if File.exist?("#{fileName}")
    end
    return validate
  end

  def self.validate_download_file(name_file)
    validate = false
    cont = 0
    path = Dir.home + "/Downloads/"+name_file+"*"
    while validate == false && cont < 100
      Dir[path].each do |file_Name|
        if File.exist?(file_Name)
          validate = true
        end
      end
      sleep(1)
      cont = cont + 1
      puts cont
    end

    Dir[path].each do |fileName|
      FileUtils.cp fileName, $folder_name
      File.delete("#{fileName}") if File.exist?("#{fileName}")
    end
    return validate
  end
end