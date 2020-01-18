class BaseScreen
  def get_attribute_by_id(valor_id,attribute)
    attribute = $driver.find_element(:id,valor_id).attribute("#{attribute}")

    return attribute
  end

  def get_attribute_by_class(valor,attribute)
    attribute = $driver.find_element(:class,valor).attribute("#{attribute}")

    return attribute
  end

  def get_attribute_by_css(valor,attribute)
    attribute = $driver.find_element(:css,valor).attribute("#{attribute}")

    return attribute
  end

  def click_by_elements_id(id)
    el = $driver.find_elements(:id, id)
    el.click
  end

  def click_by_class(valor_class)
    el = $driver.find_element(:class, valor_class)
    el.click
  end

  def wait_dynamic(att,value,time)
    $driver.wait_true(time) { $driver.exists { $driver.find_element(att, value) }}
  end

  def wait_for_id (id,time)
    $driver.wait_true(time) { $driver.exists { $driver.find_element(:id, id) }}
  end

  def wait_for_css (css,time)
    $driver.wait_true(time) { $driver.exists { $driver.find_element(:css, id) }}
  end

  def wait_for_class (valor_class,time)
    $driver.wait_true(time) { $driver.exists { $driver.find_element(:class, valor_class) }}
  end

  def click_by_id (id)
    $driver.find_element(:id, id).click
  end

  def send_keys_by_id(id,msg)

    name = $driver.find_element(:id, id).text

    if name.nil? || name == ""
      $driver.find_element(:id, id).send_keys(msg)

      if $driver.is_keyboard_shown
        $driver.hide_keyboard
      end
    end

  end

  def send_by_dynamic(att,valorAtt, valorText)
    elemento = $driver.find_element(att, valorAtt)
    elemento.send_keys(valorText)
  end

  def send_by_id(id, valorText)
    elemento = $driver.find_element(:id, id)
    elemento.send_keys(valorText)
  end

  def send_by_class(valor_class, valorText)
    elemento = $driver.find_element(:class, valor_class)
    elemento.send_keys(valorText)
  end

  def send_keys_for_father_id (valor_tag_pai, valor_tag_filho, valor_input)

    elementoPai = $driver.find_element(:id, valor_tag_pai)
    elementoFilho = elementoPai.find_element(:name, valor_tag_filho)
    elementoFilho.send_keys(valor_input)

  end

  def click_for_father_id (valor_tag_pai, valor_tag_filho)

    elementoPai = $driver.find_element(:id, valor_tag_pai)
    elementoFilho = elementoPai.find_element(:name, valor_tag_filho)
    elementoFilho.click

  end

  def replace_value_for_father_id (valor_tag_pai, valor_tag_filho, valor_input)

    elementoPai = $driver.find_element(:id, valor_tag_pai)
    elementoFilho = elementoPai.find_element(:name, valor_tag_filho)

    $driver.replace_value elementoFilho, valor_input

  end

  def send_keys_for_xpath_input(id,valor_input)
    $driver.find_element(xpath: "//*[@id = '#{id}' ]/input").send_keys(valor_input)

  end

  def clear_by_id (id)
    $driver.find_element(:id, id).clear
  end

  def clear_xpath_input(id)
    $driver.find_element(xpath: "//*[@id = '#{id}']/input").clear

  end

  def click_xpath_id(id)
    $driver.find_element(xpath: "//*[@id = '#{id}']").click

  end

  def click_xpath_dynamic(tag, valor)
    elemento = $driver.find_element(xpath: "//#{tag}[contains(text(), \"#{valor}\")]")
    elemento.click
  end

  def wait_for_xpath_dynamic (time, tag, valor)
    $driver.wait_true(time) { $driver.exists { $driver.find_element(xpath: "//#{tag}[contains(text(), \"#{valor}\")]") }}
  end

  def get_xpath_dynamic_driver(driver,tag, valor)
    elemento = driver.find_element(xpath: "//#{tag}[contains(text(), \"#{valor}\")]")
    return elemento
  end

  def get_elemento_dynamic(tag, valor)
    elemento = $driver.find_element(xpath: "//#{tag}[contains(text(), \"#{valor}\")]")
    return elemento
  end

  def get_attribute_by_xpath_dynamic(tag, valor, attribute)
    elemento = $driver.find_element(xpath: "//#{tag}[contains(text(), \"#{valor}\")]")
    attribute = elemento.attribute("#{attribute}")

    return attribute
  end

  def click_xpath_class(valor_class)
    $driver.find_element(xpath: "//*[@class = '#{valor_class}']").click

  end

  def find_element_by_id(id)
    $driver.find_element(:id, id)
  end

  def is_displayed_by_id (id)
    el = $driver.find_element(:id, id).displayed?

    return el
  end

  def is_enabled_by_id (id)
    el = $driver.find_element(:id, id).enabled?
    return el
  end

  def is_exists_by_id (id)
    el = $driver.find_element(:id, id).exists?
    return el
  end

  def is_visible_by_id(id)
    el = $driver.find_element(:id, id).visible?
    return el
  end

  def click_by_accessibility_id(id)
    $driver.find_element(:accessibility_id, id).click
  end

  def click_by_resource_id(resource_id)
    $driver.find_element(xpath: "//*[@resource-id = '#{resource_id}' ]").click
  end

  def click_by_elements_xpath(id)
    el = $driver.find_elements(:xpath, id)
    el.click
  end

  def wait_for_xpath (xpath,time)
    $driver.wait_true(time) { $driver.exists { $driver.find_element(xpath: xpath) }}
  end

  def wait_for_resource_id (resourceId,time)
    $driver.wait_true(time) { $driver.exists { $driver.find_element(xpath: "//*[@resource-id = '#{resourceId}' ]") }}
  end

  def wait_for_accessibility_id (id,time)
    $driver.wait_true(time) { $driver.exists { $driver.find_element(:accessibility_id, id) }}
  end

  def get_attribute_by_resource_id(resource_id,attribute)
    attribute = $driver.find_element(xpath: "//*[@resource-id = '#{resource_id}']").attribute("#{attribute}")
    return attribute
  end

  def get_array_by_class(valor_class)
    arrayClass = $driver.find_elements(:class, valor_class)
    return arrayClass
  end

  def get_array_by_id(id)
    arrayClass = $driver.find_elements(:id, id)
    return arrayClass
  end

  #lista de elementos por cssSelector
  def get_array_by_css(css)
    # arrayElementos = $driver.find_elements(:css, css)
    arrayElementos = $driver.find_elements(:css, css)
    return arrayElementos
  end

  def click_cssSelector(css)
    $driver.find_element(:css, css).click
  end

  #Retorna elemento driver de filho
  def get_elemento_filho_id(driver, id)
    filhoArray = driver.find_element(:id, id)
    return filhoArray
  end

  #Retorna um array com todos os valores do atributo informado
  def get_array_by_id_atributo(id, atributo)
    arrayClass = $driver.find_elements(:id, id)

    i = 0
    arrayItens = []
    #  puts "o tamanho do meu array de elementos da tela: #{arrayClass.length}"
    while i < arrayClass.length do

      arrayClass.each do |item|
        arrayItens[i] = item.attribute("#{atributo}")
        #   puts "o valor salvo no array foi: #{ arrayItens[i]} para o i: #{i}"
        i = i + 1

      end
    end
    #puts arrayItens.length
    return arrayItens
  end

  def get_attribute_by_xpath(valorxpath,attribute)
    attribute = $driver.find_element(xpath: valorxpath).attribute("#{attribute}")
    return attribute
  end

  def click_by_xpath(xpath)
    $driver.find_element(xpath: xpath).click
  end

  def send_keys_by_accessibility_id(xpath,msg)

    name = $driver.find_element(:accessibility_id, xpath).text

    if name.nil? || name == ""
      $driver.find_element(:accessibility_id, xpath).send_keys(msg)

      if $driver.is_keyboard_shown
        $driver.hide_keyboard
      end
    end
  end

  def send_keys_by_xpath(xpath,msg)

    name = $driver.find_element(xpath: xpath).text

    if name.nil? || name == ""
      $driver.find_element(xpath: xpath).send_keys(msg)

      if $driver.is_keyboard_shown
        $driver.hide_keyboard
      end
    end
  end

  #função de manipular tag filho atraves do pai
  def send_keys_for_child (resource_id_pai, class_filho, valor_input)

    elementoPai = $driver.find_element(xpath: "//*[@resource-id = '#{resource_id_pai}']")
    elementoFilho = elementoPai.find_element(:class, "#{class_filho}")
    elementoFilho.send_keys(valor_input)

  end

  def find_element_by_xpath(xpath)
    $driver.find_element(xpath: xpath)
  end

  def find_elements_by_xpath(xpath)
    $driver.find_elements(xpath: xpath)
  end

  def find_elements_by_id(id)
    $driver.find_elements(:id, id)
  end

  def send_keys_elements_by_xpath(xpath, msg)
    el = $driver.find_elements(:xpath, xpath)
    el_name = el.text

    if el_name.nil? || el.name == ""
      el.send_keys(msg)
      $driver.hide_keyboard
    end
  end

  def touch_actions_press(coord_x, coord_y)
    # Appium::TouchAction.new.press(x:coord_x, y:coord_y, count: 1).perform
  end

  def touch_actions_move_to(coord_x, coord_y)
    #   Appium::TouchAction.new.move_to(x:coord_x, y:coord_y, count: 10).perform
  end

  def touch_actions_tap(coord_x, coord_y)
    #   Appium::TouchAction.new.tap(x: coord_x, y: coord_y).perform
  end

  def touch_actions_swipe(start_x,start_y,end_x,end_y, duration)
    #  Appium::TouchAction.new.swipe(start_x: start_x, start_y: start_y, end_x: end_x, end_y: end_y, duration: duration).perform #TO_DO
  end

  def scroll_to_element_by_resource_id(resource_id, scrollable_index = 0)
    # Pass the full resource-id into the param e.g.:
    # "com.example.Test:id/enter"

    resource_id = %("#{resource_id}")

    content = "new UiSelector().resourceId(#{resource_id})"

    $driver.find_element :uiautomator, "new UiScrollable(new UiSelector().scrollable(true).instance(#{scrollable_index})).scrollIntoView(#{content}.instance(0));"
  end

  def get_element_for_css(css)
    element = $driver.find_element(:css, css)
    return element
  end

  def get_element_for_id(id)
    element = $driver.find_element(:id, id)
    return element
  end

  def get_element_for_class(valueClass)
    element = $driver.find_element(:class,valueClass)
    return element
  end

  def get_element_arr(att, value)
    element = $driver.find_elements(att,value)
    return element
  end

  def get_el(att, value)
    el = $driver.find_element(att,value)
    return el
  end

  #################################Browser###########################################################

  def accessSite(site)
    $driver.navigate.to site
  end

  def maxBrowser
    $driver.manage.window.maximize
  end

  def scroll_to_element_js(element)
    $driver.execute_script('arguments[0].scrollIntoView();', element)
  end

  def open_new_tab_browser
    $driver.execute_script("window.open()")
    tabs = $driver.window_handles
    $driver.switch_to.window tabs[1]
  end

  def closing_last_tab
    tabs = $driver.window_handles
    $driver.switch_to.window tabs[1]
    $driver.close
    $driver.switch_to.window tabs[0]

  end

  def changeColor(color,element)
    $driver.execute_script("arguments[0].style.backgroundColor = '" + color + "'", element)
  end

  def mouse_move_to(el)
    $driver.action.move_to(el).perform
  end

  def refresh
    $driver.navigate.refresh
  end

  def close_browser
    $driver.close
  end
end