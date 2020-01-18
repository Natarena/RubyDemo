Dir[File.join(File.dirname(__FILE__),"../elements/*.rb")].each { |file| require file }

class GoogleScreen < BaseScreen
  include Elements_screen_google
  include Test::Unit::Assertions
  def setSearch(data)
    boxSearch = get_el(:id, element_screen_google[:box_search])
    assert(boxSearch.enabled?, "page google not enabled for search")
    inputSearch = get_el(:name, element_screen_google[:input_search])
    inputSearch.send_keys(data)
    Utils.print_web
    inputSearch.send_keys(:enter)

  end

  def verifySearch(data)
    # binding.pry
    arrLinksSearch = get_element_arr(:class,element_screen_google[:links_search])
    cont = 0

    while cont < arrLinksSearch.size
      puts arrLinksSearch[cont].attribute("innerText")
      if(!arrLinksSearch[cont].attribute("innerText").downcase.include?(data.downcase) && !arrLinksSearch[cont].attribute("innerText").eql?(""))
        assert(false, "the result not contains search value.")
      end
      cont = cont + 1
    end

  end

end